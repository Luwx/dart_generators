import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta_generator/meta_generator.dart';

part 'address.freezed.dart';
part 'address.g.dart';

@freezed
@withMeta
class Address with _$Address {
  const factory Address({
    required String street,
    required String city,
    required String country,
    String? postalCode,
    @Default(0) int floor,
  }) = _Address;
}
