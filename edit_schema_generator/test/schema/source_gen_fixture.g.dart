// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_gen_fixture.dart';

// **************************************************************************
// EditSchemaSourceGenerator
// **************************************************************************

// Generated code. Do not modify by hand.
// ignore_for_file: dead_code, prefer_null_aware_operators, lines_longer_than_80_chars, unnecessary_cast, unnecessary_lambdas, unnecessary_parenthesis, unreachable_switch_case, unused_element, invalid_null_aware_operator

enum FixtureNodeDirtyField { text, flag, items, mode, labels }

enum FixtureNodeDirtyGroup { modeAndFlag }

final _fixtureNodeAsTextVariantPart = LensPart<FixtureNode, TextVariant>(
  get: (value) => value.variant as TextVariant,
  canGet: (value) => value.variant is TextVariant,
  set: (value, next) => value.copyWith(variant: next),
  name: 'TextVariant',
);

final _fixtureNodeTextPart = LensPart<TextVariant, String>(
  get: (value) => value.text,
  set: (value, next) => value.copyWith(text: next),
  name: 'text',
);

Lens<String> fixtureNodeTextLens(FixtureLocation location) => fixtureNodeLens(
  location,
).then(_fixtureNodeAsTextVariantPart).then(_fixtureNodeTextPart);

final _fixtureNodeFlagPart = LensPart<TextVariant, bool?>(
  get: (value) => value.flag,
  set: (value, next) => value.copyWith(flag: next),
  name: 'flag',
);

Lens<bool?> fixtureNodeFlagLens(FixtureLocation location) => fixtureNodeLens(
  location,
).then(_fixtureNodeAsTextVariantPart).then(_fixtureNodeFlagPart);

final _fixtureNodeAsListVariantPart = LensPart<FixtureNode, ListVariant>(
  get: (value) => value.variant as ListVariant,
  canGet: (value) => value.variant is ListVariant,
  set: (value, next) => value.copyWith(variant: next),
  name: 'ListVariant',
);

final _fixtureNodeItemsPart = LensPart<ListVariant, List<String>>(
  get: (value) => value.items,
  set: (value, next) => value.copyWith(items: next),
  name: 'items',
);

Lens<List<String>> fixtureNodeItemsLens(FixtureLocation location) =>
    fixtureNodeLens(
      location,
    ).then(_fixtureNodeAsListVariantPart).then(_fixtureNodeItemsPart);

final _fixtureNodeModePart = LensPart<FixtureNode, String?>(
  get: (value) => value.mode,
  set: (value, next) => value.copyWith(mode: next),
  name: 'mode',
);

Lens<String?> fixtureNodeModeLens(FixtureLocation location) =>
    fixtureNodeLens(location).then(_fixtureNodeModePart);

final _fixtureNodeLabelsPart = LensPart<FixtureNode, List<String>>(
  get: (value) => value.labels,
  set: (value, next) => value.copyWith(labels: next),
  name: 'labels',
);

Lens<List<String>> fixtureNodeLabelsLens(FixtureLocation location) =>
    fixtureNodeLens(location).then(_fixtureNodeLabelsPart);

final fixtureNodeTextField =
    GeneratedEditField<FixtureNode, FixtureLocation, String, Lens<String>>(
      id: 'text',
      dirtyField: FixtureNodeDirtyField.text,
      lens: fixtureNodeTextLens,
      fallback: (value) => switch (value.variant) {
        TextVariant() && final caseValue => caseValue.text,
        _ => throw StateError('Fallback unavailable for field text'),
      },
      adapter: FieldAdapterSpec<String>.identity(),
    );

final fixtureNodeFlagField =
    GeneratedEditField<FixtureNode, FixtureLocation, bool?, Lens<bool?>>(
      id: 'flag',
      dirtyField: FixtureNodeDirtyField.flag,
      lens: fixtureNodeFlagLens,
      fallback: (value) => switch (value.variant) {
        TextVariant() && final caseValue => caseValue.flag,
        _ => throw StateError('Fallback unavailable for field flag'),
      },
      adapter: FieldAdapterSpec<bool?>.identity(),
    );

final fixtureNodeItemsField =
    GeneratedEditField<
      FixtureNode,
      FixtureLocation,
      List<String>,
      Lens<List<String>>
    >(
      id: 'items',
      dirtyField: FixtureNodeDirtyField.items,
      lens: fixtureNodeItemsLens,
      fallback: (value) => switch (value.variant) {
        ListVariant() && final caseValue => caseValue.items,
        _ => throw StateError('Fallback unavailable for field items'),
      },
      adapter: FieldAdapterSpec<List<String>>.identity(),
    );

final fixtureNodeModeField =
    GeneratedEditField<FixtureNode, FixtureLocation, String?, Lens<String?>>(
      id: 'mode',
      dirtyField: FixtureNodeDirtyField.mode,
      lens: fixtureNodeModeLens,
      fallback: (value) => value.mode,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

final fixtureNodeLabelsField =
    GeneratedEditField<
      FixtureNode,
      FixtureLocation,
      List<String>,
      Lens<List<String>>
    >(
      id: 'labels',
      dirtyField: FixtureNodeDirtyField.labels,
      lens: fixtureNodeLabelsLens,
      fallback: (value) => value.labels,
      adapter: FieldAdapterSpec<List<String>>.identity(),
    );

Object? comparableFixtureNodeFieldValue(
  FixtureNode? value,
  FixtureNodeDirtyField field,
) => switch (field) {
  FixtureNodeDirtyField.text => switch (value) {
    null => null,
    _ => switch (value.variant) {
      TextVariant() && final caseValue => caseValue.text,
      _ => null,
    },
  },
  FixtureNodeDirtyField.flag =>
    value?.variant is TextVariant
        ? (value!.variant as TextVariant).effectiveFlag
        : null,
  FixtureNodeDirtyField.items => switch (value) {
    null => null,
    _ => switch (value.variant) {
      ListVariant() && final caseValue => caseValue.items,
      _ => null,
    },
  },
  FixtureNodeDirtyField.mode => value == null ? null : value.mode,
  FixtureNodeDirtyField.labels => value == null ? null : value.labels,
};

Object? comparableFixtureNodeGroupValue(
  FixtureNode? value,
  FixtureNodeDirtyGroup group,
) => switch (group) {
  FixtureNodeDirtyGroup.modeAndFlag => [
    comparableFixtureNodeFieldValue(value, FixtureNodeDirtyField.mode),
    comparableFixtureNodeFieldValue(value, FixtureNodeDirtyField.flag),
  ],
};

FixtureNode restoreFixtureNodeField({
  required FixtureNode current,
  required FixtureNode saved,
  required FixtureNodeDirtyField field,
}) => switch (field) {
  FixtureNodeDirtyField.text => switch ((current.variant, saved.variant)) {
    (TextVariant() && final currentValue, TextVariant() && final savedValue) =>
      current.copyWith(variant: currentValue.copyWith(text: savedValue.text)),
    _ => current,
  },
  FixtureNodeDirtyField.flag => switch ((current.variant, saved.variant)) {
    (TextVariant() && final currentValue, TextVariant() && final savedValue) =>
      current.copyWith(variant: currentValue.copyWith(flag: savedValue.flag)),
    _ => current,
  },
  FixtureNodeDirtyField.items => switch ((current.variant, saved.variant)) {
    (ListVariant() && final currentValue, ListVariant() && final savedValue) =>
      current.copyWith(variant: currentValue.copyWith(items: savedValue.items)),
    _ => current,
  },
  FixtureNodeDirtyField.mode => current.copyWith(mode: saved.mode),
  FixtureNodeDirtyField.labels => current.copyWith(labels: saved.labels),
};

bool fixtureNodeHasSavedBacking(FixtureNode? saved) => saved != null;
