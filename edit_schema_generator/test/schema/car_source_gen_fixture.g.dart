// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_source_gen_fixture.dart';

// **************************************************************************
// EditSchemaSourceGenerator
// **************************************************************************

// Generated code. Do not modify by hand.
// ignore_for_file: dead_code, prefer_null_aware_operators, lines_longer_than_80_chars, unnecessary_cast, unnecessary_lambdas, unnecessary_parenthesis, unreachable_switch_case, unused_element, invalid_null_aware_operator

enum CarDirtyField {
  name,
  year,
  wheels,
  seats,
  color,
  tags,
  summary,
  engineName,
  horsepower,
  kw,
  battery,
}

enum CarDirtyGroup { body, inside, enginePower }

final _carNamePart = LensPart<Car, String>(
  get: (value) => value.name,
  set: (value, next) => value.copyWith(name: next),
  name: 'name',
);

Lens<String> carNameLens(CarLocation location) =>
    carLens(location).then(_carNamePart);

final _carYearPart = LensPart<Car, int>(
  get: (value) => value.year,
  set: (value, next) => value.copyWith(year: next),
  name: 'year',
);

Lens<int> carYearLens(CarLocation location) =>
    carLens(location).then(_carYearPart);

final _carWheelsPart = LensPart<Car, List<Wheel>>(
  get: (value) => value.wheels,
  set: (value, next) => value.copyWith(wheels: next),
  name: 'wheels',
);

Lens<List<Wheel>> carWheelsLens(CarLocation location) =>
    carLens(location).then(_carWheelsPart);

final _carSeatsPart = LensPart<Car, List<Seat>>(
  get: (value) => value.seats,
  set: (value, next) => value.copyWith(seats: next),
  name: 'seats',
);

Lens<List<Seat>> carSeatsLens(CarLocation location) =>
    carLens(location).then(_carSeatsPart);

final _carColorPart = LensPart<Car, String>(
  get: (value) => value.color,
  set: (value, next) => value.copyWith(color: next),
  name: 'color',
);

Lens<String> carColorLens(CarLocation location) =>
    carLens(location).then(_carColorPart);

final _carTagsPart = LensPart<Car, List<String>>(
  get: (value) => value.tags,
  set: (value, next) => value.copyWith(tags: next),
  name: 'tags',
);

Lens<List<String>> carTagsLens(CarLocation location) =>
    carLens(location).then(_carTagsPart);

final _carAsGasEnginePart = LensPart<Car, GasEngine>(
  get: (value) => value.engine as GasEngine,
  set: (value, next) => value.copyWith(engine: next),
  name: 'GasEngine',
);

final _carEngineNamePart = LensPart<GasEngine, String>(
  get: (value) => value.name,
  set: (value, next) => value.copyWith(name: next),
  name: 'engineName',
);

Lens<String> carEngineNameLens(CarLocation location) =>
    carLens(location).then(_carAsGasEnginePart).then(_carEngineNamePart);

final _carHorsepowerPart = LensPart<GasEngine, int>(
  get: (value) => value.horsepower,
  set: (value, next) => value.copyWith(horsepower: next),
  name: 'horsepower',
);

Lens<int> carHorsepowerLens(CarLocation location) =>
    carLens(location).then(_carAsGasEnginePart).then(_carHorsepowerPart);

final _carAsElectricEnginePart = LensPart<Car, ElectricEngine>(
  get: (value) => value.engine as ElectricEngine,
  set: (value, next) => value.copyWith(engine: next),
  name: 'ElectricEngine',
);

final _carKwPart = LensPart<ElectricEngine, int>(
  get: (value) => value.kw,
  set: (value, next) => value.copyWith(kw: next),
  name: 'kw',
);

Lens<int> carKwLens(CarLocation location) =>
    carLens(location).then(_carAsElectricEnginePart).then(_carKwPart);

final _carBatteryPart = LensPart<ElectricEngine, int>(
  get: (value) => value.battery,
  set: (value, next) => value.copyWith(battery: next),
  name: 'battery',
);

Lens<int> carBatteryLens(CarLocation location) =>
    carLens(location).then(_carAsElectricEnginePart).then(_carBatteryPart);

final carNameField = GeneratedEditField<Car, CarLocation, String, Lens<String>>(
  id: 'name',
  dirtyField: CarDirtyField.name,
  lens: carNameLens,
  fallback: (value) => value.name,
  adapter: FieldAdapterSpec<String>.identity(),
);

final carYearField = GeneratedEditField<Car, CarLocation, int, Lens<int>>(
  id: 'year',
  dirtyField: CarDirtyField.year,
  lens: carYearLens,
  fallback: (value) => value.year,
  adapter: FieldAdapterSpec<int>.identity(),
);

final carWheelsField =
    GeneratedEditField<Car, CarLocation, List<Wheel>, Lens<List<Wheel>>>(
      id: 'wheels',
      dirtyField: CarDirtyField.wheels,
      lens: carWheelsLens,
      fallback: (value) => value.wheels,
      adapter: FieldAdapterSpec<List<Wheel>>.identity(),
    );

final carSeatsField =
    GeneratedEditField<Car, CarLocation, List<Seat>, Lens<List<Seat>>>(
      id: 'seats',
      dirtyField: CarDirtyField.seats,
      lens: carSeatsLens,
      fallback: (value) => value.seats,
      adapter: FieldAdapterSpec<List<Seat>>.identity(),
    );

final carColorField =
    GeneratedEditField<Car, CarLocation, String, Lens<String>>(
      id: 'color',
      dirtyField: CarDirtyField.color,
      lens: carColorLens,
      fallback: (value) => value.color,
      adapter: FieldAdapterSpec<String>.identity(),
    );

final carTagsField =
    GeneratedEditField<Car, CarLocation, List<String>, Lens<List<String>>>(
      id: 'tags',
      dirtyField: CarDirtyField.tags,
      lens: carTagsLens,
      fallback: (value) => value.tags,
      adapter: FieldAdapterSpec<List<String>>.identity(),
    );

final carEngineNameField =
    GeneratedEditField<Car, CarLocation, String, Lens<String>>(
      id: 'engineName',
      dirtyField: CarDirtyField.engineName,
      lens: carEngineNameLens,
      fallback: (value) => switch (value.engine) {
        GasEngine() && final caseValue => caseValue.name,
        _ => throw StateError('Fallback unavailable for field engineName'),
      },
      adapter: FieldAdapterSpec<String>.identity(),
    );

final carHorsepowerField = GeneratedEditField<Car, CarLocation, int, Lens<int>>(
  id: 'horsepower',
  dirtyField: CarDirtyField.horsepower,
  lens: carHorsepowerLens,
  fallback: (value) => switch (value.engine) {
    GasEngine() && final caseValue => caseValue.horsepower,
    _ => throw StateError('Fallback unavailable for field horsepower'),
  },
  adapter: FieldAdapterSpec<int>.identity(),
);

final carKwField = GeneratedEditField<Car, CarLocation, int, Lens<int>>(
  id: 'kw',
  dirtyField: CarDirtyField.kw,
  lens: carKwLens,
  fallback: (value) => switch (value.engine) {
    ElectricEngine() && final caseValue => caseValue.kw,
    _ => throw StateError('Fallback unavailable for field kw'),
  },
  adapter: FieldAdapterSpec<int>.identity(),
);

final carBatteryField = GeneratedEditField<Car, CarLocation, int, Lens<int>>(
  id: 'battery',
  dirtyField: CarDirtyField.battery,
  lens: carBatteryLens,
  fallback: (value) => switch (value.engine) {
    ElectricEngine() && final caseValue => caseValue.battery,
    _ => throw StateError('Fallback unavailable for field battery'),
  },
  adapter: FieldAdapterSpec<int>.identity(),
);

Object? comparableCarFieldValue(Car? value, CarDirtyField field) =>
    switch (field) {
      CarDirtyField.name => value == null ? null : value.name,
      CarDirtyField.year => value == null ? null : value.year,
      CarDirtyField.wheels => value == null ? null : value.wheels,
      CarDirtyField.seats => value == null ? null : value.seats,
      CarDirtyField.color => value == null ? null : value.color,
      CarDirtyField.tags => value == null ? null : value.tags,
      CarDirtyField.summary => [value?.name, value?.year],
      CarDirtyField.engineName => switch (value) {
        null => null,
        _ => switch (value.engine) {
          GasEngine() && final caseValue => caseValue.name,
          _ => null,
        },
      },
      CarDirtyField.horsepower => switch (value) {
        null => null,
        _ => switch (value.engine) {
          GasEngine() && final caseValue => caseValue.horsepower,
          _ => null,
        },
      },
      CarDirtyField.kw => switch (value) {
        null => null,
        _ => switch (value.engine) {
          ElectricEngine() && final caseValue => caseValue.kw,
          _ => null,
        },
      },
      CarDirtyField.battery => switch (value) {
        null => null,
        _ => switch (value.engine) {
          ElectricEngine() && final caseValue => caseValue.battery,
          _ => null,
        },
      },
    };

Object? comparableCarGroupValue(Car? value, CarDirtyGroup group) =>
    switch (group) {
      CarDirtyGroup.body => [
        comparableCarFieldValue(value, CarDirtyField.name),
        comparableCarFieldValue(value, CarDirtyField.year),
        comparableCarFieldValue(value, CarDirtyField.color),
        comparableCarFieldValue(value, CarDirtyField.tags),
      ],
      CarDirtyGroup.inside => [
        comparableCarFieldValue(value, CarDirtyField.seats),
      ],
      CarDirtyGroup.enginePower => [
        comparableCarFieldValue(value, CarDirtyField.horsepower),
        comparableCarFieldValue(value, CarDirtyField.kw),
      ],
    };

Car restoreCarField({
  required Car current,
  required Car saved,
  required CarDirtyField field,
}) => switch (field) {
  CarDirtyField.name => current.copyWith(name: saved.name),
  CarDirtyField.year => current.copyWith(year: saved.year),
  CarDirtyField.wheels => current.copyWith(wheels: saved.wheels),
  CarDirtyField.seats => current.copyWith(seats: saved.seats),
  CarDirtyField.color => current.copyWith(color: saved.color),
  CarDirtyField.tags => current.copyWith(tags: saved.tags),
  CarDirtyField.summary => current,
  CarDirtyField.engineName => switch ((current.engine, saved.engine)) {
    (GasEngine() && final currentValue, GasEngine() && final savedValue) =>
      current.copyWith(engine: currentValue.copyWith(name: savedValue.name)),
    _ => current,
  },
  CarDirtyField.horsepower => switch ((current.engine, saved.engine)) {
    (GasEngine() && final currentValue, GasEngine() && final savedValue) =>
      current.copyWith(
        engine: currentValue.copyWith(horsepower: savedValue.horsepower),
      ),
    _ => current,
  },
  CarDirtyField.kw => switch ((current.engine, saved.engine)) {
    (
      ElectricEngine() && final currentValue,
      ElectricEngine() && final savedValue,
    ) =>
      current.copyWith(engine: currentValue.copyWith(kw: savedValue.kw)),
    _ => current,
  },
  CarDirtyField.battery => switch ((current.engine, saved.engine)) {
    (
      ElectricEngine() && final currentValue,
      ElectricEngine() && final savedValue,
    ) =>
      current.copyWith(
        engine: currentValue.copyWith(battery: savedValue.battery),
      ),
    _ => current,
  },
};

bool carHasSavedBacking(Car? saved) => saved != null;

bool carFieldHasSavedBacking(Car? saved, CarDirtyField field) =>
    switch (field) {
      CarDirtyField.name => saved != null,
      CarDirtyField.year => saved != null,
      CarDirtyField.wheels => saved != null && (saved.wheels.isNotEmpty),
      CarDirtyField.seats => saved != null,
      CarDirtyField.color => saved != null,
      CarDirtyField.tags => saved != null,
      CarDirtyField.summary => saved != null && (saved.year > 0),
      CarDirtyField.engineName => saved != null,
      CarDirtyField.horsepower => saved != null,
      CarDirtyField.kw => saved != null,
      CarDirtyField.battery => saved != null,
    };

// Generated code. Do not modify by hand.
// ignore_for_file: dead_code, prefer_null_aware_operators, lines_longer_than_80_chars, unnecessary_cast, unnecessary_lambdas, unnecessary_parenthesis, unreachable_switch_case

Object? comparableWheelValue(Wheel? value) => [value?.size, value?.pressure];

// Generated code. Do not modify by hand.
// ignore_for_file: dead_code, prefer_null_aware_operators, lines_longer_than_80_chars, unnecessary_cast, unnecessary_lambdas, unnecessary_parenthesis, unreachable_switch_case

Object? comparableEngineValue(Engine? value) => switch (value) {
  GasEngine() && final v => ['gas', v.horsepower, v.turbo],
  ElectricEngine() && final v => ['electric', v.kw],
  _ => null,
};

// Generated code. Do not modify by hand.
// ignore_for_file: dead_code, prefer_null_aware_operators, lines_longer_than_80_chars, unnecessary_cast, unnecessary_lambdas, unnecessary_parenthesis, unreachable_switch_case

Car replaceWheelAt(Car root, int index, Wheel value) {
  final list = root.wheels;
  if (index < 0 || index >= list.length) return root;
  final next = List<Wheel>.of(list);
  next[index] = value;
  return root.copyWith(wheels: next);
}

Car updateWheelAt(Car root, int index, Wheel Function(Wheel value) update) {
  final list = root.wheels;
  if (index < 0 || index >= list.length) return root;
  final next = List<Wheel>.of(list);
  next[index] = update(next[index]);
  return root.copyWith(wheels: next);
}

Car insertWheelAt(Car root, int index, Wheel value) {
  final list = root.wheels;
  if (index < 0 || index > list.length) return root;
  final next = List<Wheel>.of(list)..insert(index, value);
  return root.copyWith(wheels: next);
}

Car addWheel(Car root, Wheel value) {
  final next = List<Wheel>.of(root.wheels)..add(value);
  return root.copyWith(wheels: next);
}

Car removeWheelAt(Car root, int index) {
  final list = root.wheels;
  if (index < 0 || index >= list.length) return root;
  final next = List<Wheel>.of(list)..removeAt(index);
  return root.copyWith(wheels: next);
}

Car duplicateWheelAt(Car root, int index) {
  final list = root.wheels;
  if (index < 0 || index >= list.length) return root;
  final next = List<Wheel>.of(list)..insert(index + 1, list[index]);
  return root.copyWith(wheels: next);
}

Car moveWheel(Car root, int from, int to) {
  final list = root.wheels;
  if (from < 0 || from >= list.length) return root;
  final next = List<Wheel>.of(list);
  final item = next.removeAt(from);
  next.insert(to.clamp(0, next.length), item);
  return root.copyWith(wheels: next);
}

// Generated code. Do not modify by hand.
// ignore_for_file: dead_code, prefer_null_aware_operators, lines_longer_than_80_chars, unnecessary_cast, unnecessary_lambdas, unnecessary_parenthesis, unreachable_switch_case

Object? comparableCarValue(Car? value) => [
  value?.name,
  (value?.wheels ?? const <Wheel>[]).map(comparableWheelValue).toList(),
  comparableEngineValue(value?.engine),
];
