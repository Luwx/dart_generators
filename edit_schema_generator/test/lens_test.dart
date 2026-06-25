import 'package:edit_schema_generator/edit_schema_generator.dart';
import 'package:test/test.dart';

final class _Root {
  const _Root(this.child);

  final _Child child;

  _Root copyWith({_Child? child}) => _Root(child ?? this.child);
}

final class _Child {
  const _Child(this.value);

  final int value;

  _Child copyWith({int? value}) => _Child(value ?? this.value);
}

void main() {
  test('Lens.then composes get, set, name, and canGet', () {
    final rootLens = Lens<_Root, _Child>(
      get: (root) => root.child,
      set: (root, value) => root.copyWith(child: value),
      name: 'child',
    );
    final valuePart = LensPart<_Child, int>(
      get: (source) => source.value,
      set: (source, value) => source.copyWith(value: value),
      name: 'value',
      canGet: (source) => source.value >= 0,
    );

    final lens = rootLens.then(valuePart);

    expect(lens.name, 'child.value');
    expect(lens.get(const _Root(_Child(3))), 3);
    expect(lens.canGet(const _Root(_Child(3))), isTrue);
    expect(lens.canGet(const _Root(_Child(-1))), isFalse);

    final updated = lens.set(const _Root(_Child(3)), 5);
    expect(updated.child.value, 5);
  });

  test('Lens equality is path-name based', () {
    Lens<_Root, int> lens(String name) =>
        Lens<_Root, int>(get: (_) => 1, set: (root, _) => root, name: name);

    expect(lens('a.b'), lens('a.b'));
    expect(lens('a.b'), isNot(lens('a.c')));
    expect({lens('a.b'), lens('a.b')}, hasLength(1));
  });
}
