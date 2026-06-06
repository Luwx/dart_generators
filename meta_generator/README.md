# meta_generator

A `build_runner` code generator that produces `FooMeta` classes with field and method enums for any Dart class annotated with `@withMeta`. Compatible with `freezed`.

## What it generates

For a class `Foo`, the generator produces (into `foo.g.dart`):

- `FooField`: enhanced enum with one value per public field, carrying `typeName: String` and `isNullable: bool`
- `FooMethod`: enum with one value per public instance method
- `FooMeta`: static helpers `fields`, `methods`, `typeName(field)`, `isNullable(field)`, `fieldByName(name)`

## Setup

Add to `pubspec.yaml`:

```yaml
dependencies:
  meta_generator: ^0.1.0

dev_dependencies:
  build_runner: ^2.4.0
```

Add a `part` directive and annotate the class:

```dart
import 'package:meta_generator/meta_generator.dart';

part 'person.g.dart';

@withMeta
class Person {
  final String name;
  final int age;
  final String? email;

  const Person({required this.name, required this.age, this.email});

  String greeting() => 'Hello, $name!';
}
```

Run the generator:

```sh
dart run build_runner build
```

### With freezed

Apply both annotations (`@freezed` first):

```dart
@freezed
@withMeta
class Address with _$Address {
  const factory Address({
    required String street,
    required String city,
    String? postalCode,
  }) = _Address;
}
```

Fields are read from the primary factory constructor parameters, so the generated `AddressField` enum reflects the freezed model correctly.

## Usage

```dart
// Enumerate all fields
for (final field in PersonMeta.fields) {
  print('${field.name}: ${field.typeName}${field.isNullable ? '?' : ''}');
}

// Look up a field by name
final f = PersonMeta.fieldByName('email'); // PersonField.email

// Check nullability
PersonMeta.isNullable(PersonField.email); // true

// Enumerate methods
PersonMeta.methods; // [PersonMethod.greeting]
```
