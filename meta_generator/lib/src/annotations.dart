/// Annotation to trigger metadata class generation for a Dart class.
///
/// Usage:
/// ```dart
/// @withMeta
/// class Person {
///   final String name;
///   final int age;
/// }
/// ```
///
/// Or alongside @freezed:
/// ```dart
/// @freezed
/// @withMeta
/// class Person with _$Person {
///   const factory Person({required String name, required int age}) = _Person;
/// }
/// ```
class WithMeta {
  const WithMeta();
}

/// Convenience constant for the [@WithMeta] annotation.
const withMeta = WithMeta();
