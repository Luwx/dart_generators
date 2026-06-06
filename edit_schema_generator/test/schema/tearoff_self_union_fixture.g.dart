// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tearoff_self_union_fixture.dart';

// **************************************************************************
// EditSchemaSourceGenerator
// **************************************************************************

// Generated code. Do not modify by hand.
// ignore_for_file: dead_code, prefer_null_aware_operators, lines_longer_than_80_chars, unnecessary_cast, unnecessary_lambdas, unnecessary_parenthesis, unreachable_switch_case, unused_element, invalid_null_aware_operator

enum VariantDirtyField { text, items }

final _variantAsTextVariantPart = LensPart<FixtureVariant, TextVariant>(
  get: (value) => value as TextVariant,
  set: (value, next) => next,
  name: 'TextVariant',
);

final _variantTextPart = LensPart<TextVariant, String>(
  get: (value) => value.text,
  set: (value, next) => value.copyWith(text: next),
  name: 'text',
);

Lens<String> variantTextLens(FixtureLocation location) => fixtureVariantLens(
  location,
).then(_variantAsTextVariantPart).then(_variantTextPart);

final _variantAsListVariantPart = LensPart<FixtureVariant, ListVariant>(
  get: (value) => value as ListVariant,
  set: (value, next) => next,
  name: 'ListVariant',
);

final _variantItemsPart = LensPart<ListVariant, List<String>>(
  get: (value) => value.items,
  set: (value, next) => value.copyWith(items: next),
  name: 'items',
);

Lens<List<String>> variantItemsLens(FixtureLocation location) =>
    fixtureVariantLens(
      location,
    ).then(_variantAsListVariantPart).then(_variantItemsPart);

final variantTextField =
    GeneratedEditField<FixtureVariant, FixtureLocation, String, Lens<String>>(
      id: 'text',
      dirtyField: VariantDirtyField.text,
      lens: variantTextLens,
      fallback: (value) => switch (value) {
        TextVariant() && final caseValue => caseValue.text,
        _ => throw StateError('Fallback unavailable for field text'),
      },
      adapter: FieldAdapterSpec<String>.identity(),
    );

final variantItemsField =
    GeneratedEditField<
      FixtureVariant,
      FixtureLocation,
      List<String>,
      Lens<List<String>>
    >(
      id: 'items',
      dirtyField: VariantDirtyField.items,
      lens: variantItemsLens,
      fallback: (value) => switch (value) {
        ListVariant() && final caseValue => caseValue.items,
        _ => throw StateError('Fallback unavailable for field items'),
      },
      adapter: FieldAdapterSpec<List<String>>.identity(),
    );

Object? comparableVariantFieldValue(
  FixtureVariant? value,
  VariantDirtyField field,
) => switch (field) {
  VariantDirtyField.text => switch (value) {
    null => null,
    _ => switch (value) {
      TextVariant() && final caseValue => caseValue.text,
      _ => null,
    },
  },
  VariantDirtyField.items => switch (value) {
    null => null,
    _ => switch (value) {
      ListVariant() && final caseValue => caseValue.items,
      _ => null,
    },
  },
};

FixtureVariant restoreVariantField({
  required FixtureVariant current,
  required FixtureVariant saved,
  required VariantDirtyField field,
}) => switch (field) {
  VariantDirtyField.text => switch ((current, saved)) {
    (TextVariant() && final currentValue, TextVariant() && final savedValue) =>
      currentValue.copyWith(text: savedValue.text),
    _ => current,
  },
  VariantDirtyField.items => switch ((current, saved)) {
    (ListVariant() && final currentValue, ListVariant() && final savedValue) =>
      currentValue.copyWith(items: savedValue.items),
    _ => current,
  },
};

bool variantHasSavedBacking(FixtureVariant? saved) => saved != null;

// Generated code. Do not modify by hand.
// ignore_for_file: dead_code, prefer_null_aware_operators, lines_longer_than_80_chars, unnecessary_cast, unnecessary_lambdas, unnecessary_parenthesis, unreachable_switch_case, unused_element, invalid_null_aware_operator

enum TearoffNodeDirtyField { mode }

final _tearoffNodeModePart = LensPart<FixtureNode, String?>(
  get: (value) => readMode(value),
  set: (value, next) => writeMode(value, next),
  name: 'mode',
);

Lens<String?> tearoffNodeModeLens(FixtureLocation location) =>
    tearoffNodeLens(location).then(_tearoffNodeModePart);

final tearoffNodeModeField =
    GeneratedEditField<FixtureNode, FixtureLocation, String?, Lens<String?>>(
      id: 'mode',
      dirtyField: TearoffNodeDirtyField.mode,
      lens: tearoffNodeModeLens,
      fallback: (value) => readMode(value),
      adapter: FieldAdapterSpec<String?>.identity(),
    );

Object? comparableTearoffNodeFieldValue(
  FixtureNode? value,
  TearoffNodeDirtyField field,
) => switch (field) {
  TearoffNodeDirtyField.mode => value == null ? null : readMode(value),
};

FixtureNode restoreTearoffNodeField({
  required FixtureNode current,
  required FixtureNode saved,
  required TearoffNodeDirtyField field,
}) => switch (field) {
  TearoffNodeDirtyField.mode => writeMode(current, readMode(saved)),
};

bool tearoffNodeHasSavedBacking(FixtureNode? saved) => saved != null;
