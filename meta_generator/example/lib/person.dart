import 'package:meta_generator/meta_generator.dart';

part 'person.g.dart';

@withMeta
class Person {
  final String name;
  final int age;
  final String? email;
  final List<String> tags;

  const Person({
    required this.name,
    required this.age,
    this.email,
    this.tags = const [],
  });

  String greeting() => 'Hello, $name!';
  bool isAdult() => age >= 18;
  Person withName(String newName) => Person(name: newName, age: age, email: email, tags: tags);
}
