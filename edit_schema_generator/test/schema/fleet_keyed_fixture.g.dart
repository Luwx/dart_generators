// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fleet_keyed_fixture.dart';

// **************************************************************************
// EditSchemaSourceGenerator
// **************************************************************************

// Generated code. Do not modify by hand.
// ignore_for_file: dead_code, prefer_null_aware_operators, lines_longer_than_80_chars, unnecessary_cast, unnecessary_lambdas, unnecessary_parenthesis, unreachable_switch_case, unused_element, invalid_null_aware_operator, unused_local_variable, avoid_equals_and_hash_code_on_mutable_classes, no_literal_bool_comparisons

Lens<Fleet> _keyedGarageRootLens() => Lens<Fleet>(
  get: (root) => root as Fleet,
  set: (root, next) => next,
  name: 'keyedGarage',
);

enum KeyedGarageDirtyField {
  keyedVehicleRegistrationPlate,
  keyedVehicleRegistrationRegion,
  carColor,
  carCoupeTopSpeed,
  truckAxleCount,
  bikeElectric,
}

final class KeyedGarageLocation {
  const KeyedGarageLocation({required this.kind, required this.editId});

  final VehicleCategory kind;
  final int editId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KeyedGarageLocation &&
          other.kind == kind &&
          other.editId == editId);

  @override
  int get hashCode => Object.hash(kind, editId);
}

int _keyedVehicleLensIndexOf(List<Vehicle> list, int key) {
  for (var i = 0; i < list.length; i++) {
    if (list[i].registration.editId == key) return i;
  }
  return -1;
}

Lens<Vehicle> keyedVehicleLens(KeyedGarageLocation location) => Lens<Vehicle>(
  get: (root) {
    final container = root as Fleet;
    return switch (location.kind) {
      VehicleCategory.car =>
        container.cars[_keyedVehicleLensIndexOf(
          container.cars,
          location.editId,
        )],
      VehicleCategory.truck =>
        container.trucks[_keyedVehicleLensIndexOf(
          container.trucks,
          location.editId,
        )],
      VehicleCategory.bike =>
        container.bikes[_keyedVehicleLensIndexOf(
          container.bikes,
          location.editId,
        )],
    };
  },
  set: (root, nextValue) {
    final container = root as Fleet;
    return switch (location.kind) {
      VehicleCategory.car => () {
        final index = _keyedVehicleLensIndexOf(container.cars, location.editId);
        if (index < 0) return container;
        final next = List<Car>.of(container.cars);
        next[index] = nextValue as Car;
        return container.copyWith(cars: next);
      }(),
      VehicleCategory.truck => () {
        final index = _keyedVehicleLensIndexOf(
          container.trucks,
          location.editId,
        );
        if (index < 0) return container;
        final next = List<Truck>.of(container.trucks);
        next[index] = nextValue as Truck;
        return container.copyWith(trucks: next);
      }(),
      VehicleCategory.bike => () {
        final index = _keyedVehicleLensIndexOf(
          container.bikes,
          location.editId,
        );
        if (index < 0) return container;
        final next = List<Bike>.of(container.bikes);
        next[index] = nextValue as Bike;
        return container.copyWith(bikes: next);
      }(),
    };
  },
  canGet: (root) {
    final container = root as Fleet;
    return switch (location.kind) {
      VehicleCategory.car =>
        _keyedVehicleLensIndexOf(container.cars, location.editId) >= 0,
      VehicleCategory.truck =>
        _keyedVehicleLensIndexOf(container.trucks, location.editId) >= 0,
      VehicleCategory.bike =>
        _keyedVehicleLensIndexOf(container.bikes, location.editId) >= 0,
    };
  },
  name: 'keyedVehicle[${location.kind}/#${location.editId}]',
);

List<Vehicle> keyedVehiclesForKind(Fleet root, VehicleCategory kind) =>
    switch (kind) {
      VehicleCategory.car => root.cars.cast<Vehicle>(),
      VehicleCategory.truck => root.trucks.cast<Vehicle>(),
      VehicleCategory.bike => root.bikes.cast<Vehicle>(),
      _ => const <Vehicle>[],
    };

Fleet withKeyedVehiclesForKind(
  Fleet root,
  VehicleCategory kind,
  List<Vehicle> values,
) => switch (kind) {
  VehicleCategory.car => root.copyWith(cars: values.cast<Car>()),
  VehicleCategory.truck => root.copyWith(trucks: values.cast<Truck>()),
  VehicleCategory.bike => root.copyWith(bikes: values.cast<Bike>()),
  _ => root,
};

Vehicle? keyedVehicleAt(Fleet? root, KeyedGarageLocation location) {
  if (root == null) return null;
  final lens = keyedVehicleLens(location);
  try {
    if (!lens.canGet(root)) return null;
    return lens.get(root);
  } on Object catch (_) {
    return null;
  }
}

int? keyedVehicleIndexOf(Fleet? root, KeyedGarageLocation location) {
  if (root == null) return null;
  final list = keyedVehiclesForKind(root, location.kind);
  final index = _keyedVehicleLensIndexOf(list, location.editId);
  return index < 0 || index >= list.length ? null : index;
}

KeyedGarageLocation? keyedVehicleLocationAt(
  Fleet? root,
  VehicleCategory kind,
  int index,
) {
  if (root == null) return null;
  final list = keyedVehiclesForKind(root, kind);
  if (index < 0 || index >= list.length) return null;
  final key = list[index].registration.editId;
  if (key == null) return null;
  return KeyedGarageLocation(kind: kind, editId: key);
}

KeyedGarageLocation? keyedVehicleLocationOf(
  VehicleCategory kind,
  Vehicle value,
) {
  final key = value.registration.editId;
  if (key == null) return null;
  return KeyedGarageLocation(kind: kind, editId: key);
}

Fleet addKeyedVehicle(Fleet root, VehicleCategory kind, Vehicle value) =>
    switch (kind) {
      VehicleCategory.car => root.copyWith(
        cars: List<Car>.of(root.cars)..add(value as Car),
      ),
      VehicleCategory.truck => root.copyWith(
        trucks: List<Truck>.of(root.trucks)..add(value as Truck),
      ),
      VehicleCategory.bike => root.copyWith(
        bikes: List<Bike>.of(root.bikes)..add(value as Bike),
      ),
      _ => root,
    };

Fleet insertKeyedVehicleAt(
  Fleet root,
  VehicleCategory kind,
  int index,
  Vehicle value,
) {
  final list = keyedVehiclesForKind(root, kind);
  if (index < 0 || index > list.length) return root;
  return switch (kind) {
    VehicleCategory.car => root.copyWith(
      cars: List<Car>.of(root.cars)..insert(index, value as Car),
    ),
    VehicleCategory.truck => root.copyWith(
      trucks: List<Truck>.of(root.trucks)..insert(index, value as Truck),
    ),
    VehicleCategory.bike => root.copyWith(
      bikes: List<Bike>.of(root.bikes)..insert(index, value as Bike),
    ),
    _ => root,
  };
}

Fleet replaceKeyedVehicle(
  Fleet root,
  KeyedGarageLocation location,
  Vehicle value,
) {
  final index = keyedVehicleIndexOf(root, location);
  if (index == null) return root;
  return switch (location.kind) {
    VehicleCategory.car => root.copyWith(
      cars: List<Car>.of(root.cars)..[index] = value as Car,
    ),
    VehicleCategory.truck => root.copyWith(
      trucks: List<Truck>.of(root.trucks)..[index] = value as Truck,
    ),
    VehicleCategory.bike => root.copyWith(
      bikes: List<Bike>.of(root.bikes)..[index] = value as Bike,
    ),
    _ => root,
  };
}

Fleet updateKeyedVehicle(
  Fleet root,
  KeyedGarageLocation location,
  Vehicle Function(Vehicle value) update,
) {
  final value = keyedVehicleAt(root, location);
  if (value == null) return root;
  return replaceKeyedVehicle(root, location, update(value));
}

Fleet removeKeyedVehicle(Fleet root, KeyedGarageLocation location) {
  final index = keyedVehicleIndexOf(root, location);
  if (index == null) return root;
  return switch (location.kind) {
    VehicleCategory.car => root.copyWith(
      cars: List<Car>.of(root.cars)..removeAt(index),
    ),
    VehicleCategory.truck => root.copyWith(
      trucks: List<Truck>.of(root.trucks)..removeAt(index),
    ),
    VehicleCategory.bike => root.copyWith(
      bikes: List<Bike>.of(root.bikes)..removeAt(index),
    ),
    _ => root,
  };
}

Fleet moveKeyedVehicle(Fleet root, VehicleCategory kind, int from, int to) {
  final list = keyedVehiclesForKind(root, kind);
  if (from < 0 || from >= list.length) return root;
  final next = List<Vehicle>.of(list);
  final item = next.removeAt(from);
  next.insert(to.clamp(0, next.length), item);
  return withKeyedVehiclesForKind(root, kind, next);
}

final _keyedGarageKeyedVehicleRegistrationPart =
    LensPart<Vehicle, Registration>(
      get: (value) => value.registration,
      set: (value, next) => value.copyWithRegistration(next),
      name: 'registration',
    );

final _keyedGarageKeyedVehicleregistrationPlatePart =
    LensPart<Registration, String?>(
      get: (value) => value.plate,
      set: (value, next) => value.copyWith(plate: next),
      name: 'plate',
    );

final _keyedGarageKeyedVehicleregistrationRegionPart =
    LensPart<Registration, String?>(
      get: (value) => value.region,
      set: (value, next) => value.copyWith(region: next),
      name: 'region',
    );

final _keyedGarageCarCastPart = LensPart<Vehicle, Car>(
  get: (value) => value as Car,
  canGet: (value) => value is Car,
  set: (value, next) => next,
  name: 'Car',
);

final _keyedGarageCarColorPart = LensPart<Car, String>(
  get: (value) => value.color,
  set: (value, next) => value.copyWith(color: next),
  name: 'color',
);

final _keyedGarageAsSedanPart = LensPart<Car, Sedan>(
  get: (value) => value as Sedan,
  canGet: (value) => value is Sedan,
  set: (value, next) => next,
  name: 'Sedan',
);

final _keyedGarageAsCoupePart = LensPart<Car, Coupe>(
  get: (value) => value as Coupe,
  canGet: (value) => value is Coupe,
  set: (value, next) => next,
  name: 'Coupe',
);

final _keyedGarageCarcoupeTopSpeedPart = LensPart<Coupe, int?>(
  get: (value) => value.topSpeed,
  set: (value, next) => value.copyWith(topSpeed: next),
  name: 'topSpeed',
);

final _keyedGarageAsConvertiblePart = LensPart<Car, Convertible>(
  get: (value) => value as Convertible,
  canGet: (value) => value is Convertible,
  set: (value, next) => next,
  name: 'Convertible',
);

final _keyedGarageTruckCastPart = LensPart<Vehicle, Truck>(
  get: (value) => value as Truck,
  canGet: (value) => value is Truck,
  set: (value, next) => next,
  name: 'Truck',
);

final _keyedGarageTruckAxleCountPart = LensPart<Truck, int?>(
  get: (value) => value.axleCount,
  set: (value, next) => value.copyWith(axleCount: next),
  name: 'axleCount',
);

final _keyedGarageAsBoxTruckPart = LensPart<Truck, BoxTruck>(
  get: (value) => value as BoxTruck,
  canGet: (value) => value is BoxTruck,
  set: (value, next) => next,
  name: 'BoxTruck',
);

final _keyedGarageAsTankerPart = LensPart<Truck, Tanker>(
  get: (value) => value as Tanker,
  canGet: (value) => value is Tanker,
  set: (value, next) => next,
  name: 'Tanker',
);

final _keyedGarageBikeCastPart = LensPart<Vehicle, Bike>(
  get: (value) => value as Bike,
  canGet: (value) => value is Bike,
  set: (value, next) => next,
  name: 'Bike',
);

final _keyedGarageBikeElectricPart = LensPart<Bike, bool?>(
  get: (value) => value.electric,
  set: (value, next) => value.copyWith(electric: next),
  name: 'electric',
);

final _keyedGarageAsRoadBikePart = LensPart<Bike, RoadBike>(
  get: (value) => value as RoadBike,
  canGet: (value) => value is RoadBike,
  set: (value, next) => next,
  name: 'RoadBike',
);

final _keyedGarageAsCargoBikePart = LensPart<Bike, CargoBike>(
  get: (value) => value as CargoBike,
  canGet: (value) => value is CargoBike,
  set: (value, next) => next,
  name: 'CargoBike',
);

Lens<Registration> keyedVehicleRegistrationLens(KeyedGarageLocation location) =>
    keyedVehicleLens(location).then(_keyedGarageKeyedVehicleRegistrationPart);

Registration? keyedVehicleRegistrationAt(
  Fleet? root,
  KeyedGarageLocation location,
) {
  if (root == null) return null;
  final lens = keyedVehicleRegistrationLens(location);
  try {
    if (!lens.canGet(root)) return null;
    return lens.get(root);
  } on Object catch (_) {
    return null;
  }
}

Lens<String?> keyedVehicleRegistrationPlateLens(KeyedGarageLocation location) =>
    keyedVehicleLens(location)
        .then(_keyedGarageKeyedVehicleRegistrationPart)
        .then(_keyedGarageKeyedVehicleregistrationPlatePart);

Lens<String?> keyedVehicleRegistrationRegionLens(
  KeyedGarageLocation location,
) => keyedVehicleLens(location)
    .then(_keyedGarageKeyedVehicleRegistrationPart)
    .then(_keyedGarageKeyedVehicleregistrationRegionPart);

Lens<String> carColorLens(KeyedGarageLocation location) => keyedVehicleLens(
  location,
).then(_keyedGarageCarCastPart).then(_keyedGarageCarColorPart);

Lens<int?> carCoupeTopSpeedLens(KeyedGarageLocation location) =>
    keyedVehicleLens(location)
        .then(_keyedGarageCarCastPart)
        .then(_keyedGarageAsCoupePart)
        .then(_keyedGarageCarcoupeTopSpeedPart);

Lens<int?> truckAxleCountLens(KeyedGarageLocation location) => keyedVehicleLens(
  location,
).then(_keyedGarageTruckCastPart).then(_keyedGarageTruckAxleCountPart);

Lens<bool?> bikeElectricLens(KeyedGarageLocation location) => keyedVehicleLens(
  location,
).then(_keyedGarageBikeCastPart).then(_keyedGarageBikeElectricPart);

bool keyedVehicleRegistrationPlateHasSavedBacking(
  Fleet? saved,
  KeyedGarageLocation location,
) {
  if (saved == null) return false;
  try {
    keyedVehicleRegistrationPlateLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final keyedVehicleRegistrationPlateField =
    GeneratedEditField<Fleet, KeyedGarageLocation, String?, Lens<String?>>(
      id: 'keyedVehicleRegistrationPlate',
      dirtyField: KeyedGarageDirtyField.keyedVehicleRegistrationPlate,
      lens: keyedVehicleRegistrationPlateLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool keyedVehicleRegistrationRegionHasSavedBacking(
  Fleet? saved,
  KeyedGarageLocation location,
) {
  if (saved == null) return false;
  try {
    keyedVehicleRegistrationRegionLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final keyedVehicleRegistrationRegionField =
    GeneratedEditField<Fleet, KeyedGarageLocation, String?, Lens<String?>>(
      id: 'keyedVehicleRegistrationRegion',
      dirtyField: KeyedGarageDirtyField.keyedVehicleRegistrationRegion,
      lens: keyedVehicleRegistrationRegionLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool carColorHasSavedBacking(Fleet? saved, KeyedGarageLocation location) {
  if (saved == null) return false;
  try {
    carColorLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carColorField =
    GeneratedEditField<Fleet, KeyedGarageLocation, String, Lens<String>>(
      id: 'carColor',
      dirtyField: KeyedGarageDirtyField.carColor,
      lens: carColorLens,
      fallback: null,
      adapter: FieldAdapterSpec<String>.identity(),
    );

bool carCoupeTopSpeedHasSavedBacking(
  Fleet? saved,
  KeyedGarageLocation location,
) {
  if (saved == null) return false;
  try {
    carCoupeTopSpeedLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carCoupeTopSpeedField =
    GeneratedEditField<Fleet, KeyedGarageLocation, int?, Lens<int?>>(
      id: 'carCoupeTopSpeed',
      dirtyField: KeyedGarageDirtyField.carCoupeTopSpeed,
      lens: carCoupeTopSpeedLens,
      fallback: null,
      adapter: FieldAdapterSpec<int?>.identity(),
    );

bool truckAxleCountHasSavedBacking(Fleet? saved, KeyedGarageLocation location) {
  if (saved == null) return false;
  try {
    truckAxleCountLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final truckAxleCountField =
    GeneratedEditField<Fleet, KeyedGarageLocation, int?, Lens<int?>>(
      id: 'truckAxleCount',
      dirtyField: KeyedGarageDirtyField.truckAxleCount,
      lens: truckAxleCountLens,
      fallback: null,
      adapter: FieldAdapterSpec<int?>.identity(),
    );

bool bikeElectricHasSavedBacking(Fleet? saved, KeyedGarageLocation location) {
  if (saved == null) return false;
  try {
    bikeElectricLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final bikeElectricField =
    GeneratedEditField<Fleet, KeyedGarageLocation, bool?, Lens<bool?>>(
      id: 'bikeElectric',
      dirtyField: KeyedGarageDirtyField.bikeElectric,
      lens: bikeElectricLens,
      fallback: null,
      adapter: FieldAdapterSpec<bool?>.identity(),
    );

Object? comparableKeyedGarageFieldValue(
  Fleet? value,
  KeyedGarageDirtyField field,
) => switch (field) {
  KeyedGarageDirtyField.keyedVehicleRegistrationPlate => null,
  KeyedGarageDirtyField.keyedVehicleRegistrationRegion => null,
  KeyedGarageDirtyField.carColor => null,
  KeyedGarageDirtyField.carCoupeTopSpeed => null,
  KeyedGarageDirtyField.truckAxleCount => null,
  KeyedGarageDirtyField.bikeElectric => null,
};

Object? comparableRegistrationValue(Registration? value) => [
  value?.plate,
  value?.region,
];

Object? comparableCarValue(Car? value) => switch (value) {
  Sedan() && final v => [v.color, 'sedan'],
  Coupe() && final v => [v.color, 'coupe', v.topSpeed],
  Convertible() && final v => [v.color, 'convertible'],
  _ => null,
};

Object? comparableTruckValue(Truck? value) => switch (value) {
  BoxTruck() && final v => [v.axleCount, 'box'],
  Tanker() && final v => [v.axleCount, 'tanker'],
  _ => null,
};

Object? comparableBikeValue(Bike? value) => switch (value) {
  RoadBike() && final v => [v.electric, 'road'],
  CargoBike() && final v => [v.electric, 'cargo'],
  _ => null,
};

Object? comparableFleetValue(Fleet? value) => [
  (value?.cars ?? const <Car>[]).map(comparableCarValue).toList(),
  (value?.trucks ?? const <Truck>[]).map(comparableTruckValue).toList(),
  (value?.bikes ?? const <Bike>[]).map(comparableBikeValue).toList(),
];
