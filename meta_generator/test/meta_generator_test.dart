import 'package:build_test/build_test.dart';
import 'package:build/build.dart';
import 'package:meta_generator/builder.dart';
import 'package:test/test.dart';

// The in-memory resolver needs the annotation source provided explicitly
// because testBuilder uses an isolated in-memory reader.
const _pkg = {
  'meta_generator|lib/meta_generator.dart': "export 'src/annotations.dart';",
  'meta_generator|lib/src/annotations.dart': '''
class WithMeta { const WithMeta(); }
const withMeta = WithMeta();
''',
};

void main() {
  final builder = metaBuilder(BuilderOptions.empty);

  // SharedPartBuilder produces .meta_generator.g.part (later combined into
  // .g.dart). testBuilder only runs our builder, so we check the .g.part files
  // and wrap matchers in decodedMatches to convert bytes to a string.

  group('regular class', () {
    test('emits self, field/method name consts, and props/methods lists',
        () async {
      await testBuilder(
        builder,
        {
          ..._pkg,
          'pkg|lib/person.dart': r'''
import 'package:meta_generator/meta_generator.dart';
part 'person.g.dart';

@withMeta
class Person {
  final String name;
  final int age;
  final String? email;

  const Person({required this.name, required this.age, this.email});

  String greeting() => 'Hello!';
  bool isAdult() => age >= 18;
}
''',
        },
        outputs: {
          'pkg|lib/person.meta_generator.g.part': decodedMatches(allOf([
            contains('class PersonMeta'),
            contains("static const String self = 'Person';"),
            contains("static const String name = 'name';"),
            contains("static const String age = 'age';"),
            contains("static const String email = 'email';"),
            contains("static const String greeting = 'greeting';"),
            contains("static const String isAdult = 'isAdult';"),
            contains('static const List<String> props = [name, age, email];'),
            contains('static const List<String> methods = [greeting, isAdult];'),
            isNot(contains('enum PersonField')),
            isNot(contains('typeName')),
          ])),
        },
      );
    });

    test('omits the methods list when there are no public methods', () async {
      await testBuilder(
        builder,
        {
          ..._pkg,
          'pkg|lib/point.dart': r'''
import 'package:meta_generator/meta_generator.dart';
part 'point.g.dart';

@withMeta
class Point {
  final double x;
  final double y;
  const Point(this.x, this.y);
}
''',
        },
        outputs: {
          'pkg|lib/point.meta_generator.g.part': decodedMatches(allOf([
            contains('class PointMeta'),
            contains("static const String self = 'Point';"),
            contains('static const List<String> props = [x, y];'),
            isNot(contains('methods')),
          ])),
        },
      );
    });
  });

  group('freezed data class', () {
    test('reads fields from the single factory constructor', () async {
      await testBuilder(
        builder,
        {
          ..._pkg,
          'pkg|lib/user.dart': r'''
import 'package:meta_generator/meta_generator.dart';
part 'user.g.dart';

class _Freezed { const _Freezed(); }
const freezed = _Freezed();
mixin _$User {}

@freezed
@withMeta
class User with _$User {
  const factory User({
    required String id,
    required String username,
    String? bio,
  }) = _User;
}
class _User implements User {
  const _User({required this.id, required this.username, this.bio});
  final String id;
  final String username;
  final String? bio;
}
''',
        },
        outputs: {
          'pkg|lib/user.meta_generator.g.part': decodedMatches(allOf([
            contains('class UserMeta'),
            contains("static const String self = 'User';"),
            contains("static const String id = 'id';"),
            contains("static const String username = 'username';"),
            contains("static const String bio = 'bio';"),
            contains('static const List<String> props = [id, username, bio];'),
          ])),
        },
      );
    });
  });

  group('freezed union', () {
    test('emits one meta per case, named after the case type', () async {
      await testBuilder(
        builder,
        {
          ..._pkg,
          'pkg|lib/shape.dart': r'''
import 'package:meta_generator/meta_generator.dart';
part 'shape.g.dart';

class _Freezed { const _Freezed(); }
const freezed = _Freezed();
mixin _$Shape {}

@freezed
@withMeta
sealed class Shape with _$Shape {
  const factory Shape.circle({required double radius}) = Circle;
  const factory Shape.rect({required double w, required double h}) = Rect;
}
class Circle implements Shape {
  const Circle({required this.radius});
  final double radius;
}
class Rect implements Shape {
  const Rect({required this.w, required this.h});
  final double w;
  final double h;
}
''',
        },
        outputs: {
          'pkg|lib/shape.meta_generator.g.part': decodedMatches(allOf([
            contains('class CircleMeta'),
            contains("static const String self = 'Circle';"),
            contains("static const String radius = 'radius';"),
            contains('class RectMeta'),
            contains("static const String self = 'Rect';"),
            contains("static const String w = 'w';"),
            contains("static const String h = 'h';"),
            isNot(contains('class ShapeMeta')),
          ])),
        },
      );
    });
  });

}
