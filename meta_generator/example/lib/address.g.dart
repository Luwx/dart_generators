// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// MetaGenerator
// **************************************************************************

enum AddressField {
  street('String', false),
  city('String', false),
  country('String', false),
  postalCode('String', true),
  floor('int', false);

  final String typeName;
  final bool isNullable;

  const AddressField(this.typeName, this.isNullable);
}

class AddressMeta {
  static const List<AddressField> fields = AddressField.values;

  static String typeName(AddressField field) => field.typeName;

  static bool isNullable(AddressField field) => field.isNullable;

  static AddressField? fieldByName(String name) {
    for (final f in AddressField.values) {
      if (f.name == name) return f;
    }
    return null;
  }

  const AddressMeta._();
}
