> **Warning:** This package is not properly tested. Do not use it in production.

# lens_generator

A Dart source generator for edit UIs over immutable model trees.

## Problem

When every editable field in a settings UI requires a lens (get/set pair into the tree), a dirty-tracking enum member, a comparable projection, a restore function, and copy-on-write list helpers, the code becomes large and repetitive. It gets worse when models are sealed types or when one location address fans out across several independent lists.

## What it generates

You annotate a schema declaration:

```dart
@GenerateEditSchema()
final carSchema = editSchema<Car, CarLocation>(
  fields: [
    prop('name'),
    prop('tags', compare: deep()),
    union<GasEngine>('engine', fields: [
      prop('horsepower'),
    ]),
  ],
);
```

`build_runner` then emits:

- **Lens functions** - `carNameLens(location)`, `carHorsepowerLens(location)`, each a composable `Lens<T>` into the root.
- **Dirty field enum** - `CarDirtyField { name, tags, horsepower }`.
- **Comparable projections** - per-field functions used to decide whether a field is dirty (identity, deep-collection equality, or a custom closure).
- **`EditRoot` instance** - runtime object with `comparableFieldValue`, `restoreField`, and `hasSavedBacking`.
- **List mutation helpers** - `replaceTagsAt`, `addTags`, `removeTagsAt`, etc., for fields declared with `list(...)`.

## Authoring surfaces

| Constructor | Use |
|---|---|
| `editSchema<Root, Location>` | flat or union field list |
| `editTree<Root>` | nested tree with `child`, `list`, `sealed`, `dispatch` |
| `subtree<T>` | reusable node shared across multiple trees |
| `valueSchema<T>` | comparison-only projection, no lenses |
| `listSchema<Root, T>` | list mutation helpers only |

## Example

The schema declaration for a two-field model with one union case:

```dart
// schema.dart
part 'schema.g.dart';

Lens<Car> carLens(CarLocation loc) { /* provided by your app */ }

@GenerateEditSchema()
final carSchema = editSchema<Car, CarLocation>(
  fields: [
    prop('name'),
    prop('tags', compare: deep()),
    union<GasEngine>('engine', fields: [
      prop('horsepower'),
    ]),
  ],
);
```

What you would write by hand for those same three fields:

```dart
// lens parts
final _carNamePart       = LensPart<Car, String>(get: (v) => v.name,       set: (v, n) => v.copyWith(name: n),       name: 'name');
final _carTagsPart       = LensPart<Car, List<String>>(get: (v) => v.tags,  set: (v, n) => v.copyWith(tags: n),       name: 'tags');
final _carAsGasEnginePart = LensPart<Car, GasEngine>(get: (v) => v.engine as GasEngine, set: (v, n) => v.copyWith(engine: n), name: 'GasEngine');
final _carHorsepowerPart = LensPart<GasEngine, int>(get: (v) => v.horsepower, set: (v, n) => v.copyWith(horsepower: n), name: 'horsepower');

// lens functions
Lens<String>      carNameLens(CarLocation l)       => carLens(l).then(_carNamePart);
Lens<List<String>> carTagsLens(CarLocation l)      => carLens(l).then(_carTagsPart);
Lens<int>         carHorsepowerLens(CarLocation l) => carLens(l).then(_carAsGasEnginePart).then(_carHorsepowerPart);

// dirty enum
enum CarDirtyField { name, tags, horsepower }

// comparable projections
Object? comparableCarFieldValue(Car? value, CarDirtyField field) => switch (field) {
  CarDirtyField.name        => value?.name,
  CarDirtyField.tags        => value?.tags,  // deep equality applied by the caller
  CarDirtyField.horsepower  => switch (value) {
    null => null,
    _    => value.engine is GasEngine ? (value.engine as GasEngine).horsepower : null,
  },
};

// restore
Car restoreCarField({required Car current, required Car saved, required CarDirtyField field}) =>
  switch (field) {
    CarDirtyField.name       => current.copyWith(name: saved.name),
    CarDirtyField.tags       => current.copyWith(tags: saved.tags),
    CarDirtyField.horsepower => switch ((current.engine, saved.engine)) {
      (GasEngine() && final c, GasEngine() && final s) =>
        current.copyWith(engine: c.copyWith(horsepower: s.horsepower)),
      _ => current,
    },
  };

// GeneratedEditField entries (one per field, wires lens + dirty + fallback + adapter)
final carNameField       = GeneratedEditField<Car, CarLocation, String, Lens<String>>(...);
final carTagsField       = GeneratedEditField<Car, CarLocation, List<String>, Lens<List<String>>>(...);
final carHorsepowerField = GeneratedEditField<Car, CarLocation, int, Lens<int>>(...);
```

That is roughly 35 lines of typed, error-prone code for 3 fields. The schema replaces it with 8 lines. A real config tree with 30-40 fields and several union cases generates several hundred lines.
