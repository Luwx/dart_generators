// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fleet_garage_fixture.dart';

// **************************************************************************
// EditSchemaSourceGenerator
// **************************************************************************

// Generated code. Do not modify by hand.
// ignore_for_file: dead_code, prefer_null_aware_operators, lines_longer_than_80_chars, unnecessary_cast, unnecessary_lambdas, unnecessary_parenthesis, unreachable_switch_case, unused_element, invalid_null_aware_operator, unused_local_variable, avoid_equals_and_hash_code_on_mutable_classes, no_literal_bool_comparisons

Lens<Fleet, Fleet> _garageRootLens() => Lens<Fleet, Fleet>(
  get: (root) => root as Fleet,
  set: (root, next) => next,
  name: 'garage',
);

enum GarageDirtyField {
  garageVehicleRegistrationPlate,
  garageVehicleRegistrationRegion,
  carColor,
  carYear,
  carSedanTrimLevel,
  carCoupeTopSpeed,
  carConvertibleRoofOpen,
  truckAxleCount,
  truckBoxBoxVolume,
  truckTankerCapacity,
  bikeElectric,
  bikeRoadGears,
  bikeCargoBaskets,
}

Lens<Fleet, Vehicle> garageVehicleLens(GarageLocation location) =>
    Lens<Fleet, Vehicle>(
      get: (root) {
        final container = root as Fleet;
        return switch (location.kind) {
          VehicleCategory.car => container.cars[location.slot],
          VehicleCategory.truck => container.trucks[location.slot],
          VehicleCategory.bike => container.bikes[location.slot],
        };
      },
      set: (root, nextValue) {
        final container = root as Fleet;
        return switch (location.kind) {
          VehicleCategory.car => () {
            final next = List<Car>.of(container.cars);
            next[location.slot] = nextValue as Car;
            return container.copyWith(cars: next);
          }(),
          VehicleCategory.truck => () {
            final next = List<Truck>.of(container.trucks);
            next[location.slot] = nextValue as Truck;
            return container.copyWith(trucks: next);
          }(),
          VehicleCategory.bike => () {
            final next = List<Bike>.of(container.bikes);
            next[location.slot] = nextValue as Bike;
            return container.copyWith(bikes: next);
          }(),
        };
      },
      canGet: (root) {
        final container = root as Fleet;
        return switch (location.kind) {
          VehicleCategory.car => location.slot < container.cars.length,
          VehicleCategory.truck => location.slot < container.trucks.length,
          VehicleCategory.bike => location.slot < container.bikes.length,
        };
      },
      name: 'garageVehicle[${location.kind}/${location.slot}]',
    );

List<Vehicle> garageVehiclesForKind(Fleet root, VehicleCategory kind) =>
    switch (kind) {
      VehicleCategory.car => root.cars.cast<Vehicle>(),
      VehicleCategory.truck => root.trucks.cast<Vehicle>(),
      VehicleCategory.bike => root.bikes.cast<Vehicle>(),
      _ => const <Vehicle>[],
    };

Fleet withGarageVehiclesForKind(
  Fleet root,
  VehicleCategory kind,
  List<Vehicle> values,
) => switch (kind) {
  VehicleCategory.car => root.copyWith(cars: values.cast<Car>()),
  VehicleCategory.truck => root.copyWith(trucks: values.cast<Truck>()),
  VehicleCategory.bike => root.copyWith(bikes: values.cast<Bike>()),
  _ => root,
};

Vehicle? garageVehicleAt(Fleet? root, GarageLocation location) {
  if (root == null) return null;
  final lens = garageVehicleLens(location);
  try {
    if (!lens.canGet(root)) return null;
    return lens.get(root);
  } on Object catch (_) {
    return null;
  }
}

int? garageVehicleIndexOf(Fleet? root, GarageLocation location) {
  if (root == null) return null;
  final list = garageVehiclesForKind(root, location.kind);
  final index = location.slot;
  return index < 0 || index >= list.length ? null : index;
}

GarageLocation? garageVehicleLocationAt(
  Fleet? root,
  VehicleCategory kind,
  int index,
) {
  if (root == null) return null;
  final list = garageVehiclesForKind(root, kind);
  if (index < 0 || index >= list.length) return null;
  return GarageLocation(kind: kind, slot: index);
}

Fleet addGarageVehicle(Fleet root, VehicleCategory kind, Vehicle value) =>
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

Fleet insertGarageVehicleAt(
  Fleet root,
  VehicleCategory kind,
  int index,
  Vehicle value,
) {
  final list = garageVehiclesForKind(root, kind);
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

Fleet replaceGarageVehicle(Fleet root, GarageLocation location, Vehicle value) {
  final index = garageVehicleIndexOf(root, location);
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

Fleet updateGarageVehicle(
  Fleet root,
  GarageLocation location,
  Vehicle Function(Vehicle value) update,
) {
  final value = garageVehicleAt(root, location);
  if (value == null) return root;
  return replaceGarageVehicle(root, location, update(value));
}

Fleet removeGarageVehicle(Fleet root, GarageLocation location) {
  final index = garageVehicleIndexOf(root, location);
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

Fleet moveGarageVehicle(Fleet root, VehicleCategory kind, int from, int to) {
  final list = garageVehiclesForKind(root, kind);
  if (from < 0 || from >= list.length) return root;
  final next = List<Vehicle>.of(list);
  final item = next.removeAt(from);
  next.insert(to.clamp(0, next.length), item);
  return withGarageVehiclesForKind(root, kind, next);
}

final _garageGarageVehicleRegistrationPart = LensPart<Vehicle, Registration>(
  get: (value) => value.registration,
  set: (value, next) => value.copyWithRegistration(next),
  name: 'registration',
);

final _garageGarageVehicleregistrationPlatePart =
    LensPart<Registration, String?>(
      get: (value) => value.plate,
      set: (value, next) => value.copyWith(plate: next),
      name: 'plate',
    );

final _garageGarageVehicleregistrationRegionPart =
    LensPart<Registration, String?>(
      get: (value) => value.region,
      set: (value, next) => value.copyWith(region: next),
      name: 'region',
    );

final _garageCarCastPart = LensPart<Vehicle, Car>(
  get: (value) => value as Car,
  canGet: (value) => value is Car,
  set: (value, next) => next,
  name: 'Car',
);

final _garageCarColorPart = LensPart<Car, String>(
  get: (value) => value.color,
  set: (value, next) => value.copyWith(color: next),
  name: 'color',
);

final _garageCarYearPart = LensPart<Car, int?>(
  get: (value) => value.year,
  set: (value, next) => value.copyWith(year: next),
  name: 'year',
);

final _garageAsSedanPart = LensPart<Car, Sedan>(
  get: (value) => value as Sedan,
  canGet: (value) => value is Sedan,
  set: (value, next) => next,
  name: 'Sedan',
);

final _garageCarsedanTrimPart = LensPart<Sedan, Trim>(
  get: (value) => value.trim,
  set: (value, next) => value.copyWith(trim: next),
  name: 'trim',
);

final _garageCarsedantrimLevelPart = LensPart<Trim, String?>(
  get: (value) => value.level,
  set: (value, next) => value.copyWith(level: next),
  name: 'level',
);

final _garageAsCoupePart = LensPart<Car, Coupe>(
  get: (value) => value as Coupe,
  canGet: (value) => value is Coupe,
  set: (value, next) => next,
  name: 'Coupe',
);

final _garageCarcoupeTopSpeedPart = LensPart<Coupe, int?>(
  get: (value) => value.topSpeed,
  set: (value, next) => value.copyWith(topSpeed: next),
  name: 'topSpeed',
);

final _garageAsConvertiblePart = LensPart<Car, Convertible>(
  get: (value) => value as Convertible,
  canGet: (value) => value is Convertible,
  set: (value, next) => next,
  name: 'Convertible',
);

final _garageCarconvertibleRoofOpenPart = LensPart<Convertible, bool?>(
  get: (value) => value.roofOpen,
  set: (value, next) => value.copyWith(roofOpen: next),
  name: 'roofOpen',
);

final _garageTruckCastPart = LensPart<Vehicle, Truck>(
  get: (value) => value as Truck,
  canGet: (value) => value is Truck,
  set: (value, next) => next,
  name: 'Truck',
);

final _garageTruckAxleCountPart = LensPart<Truck, int?>(
  get: (value) => value.axleCount,
  set: (value, next) => value.copyWith(axleCount: next),
  name: 'axleCount',
);

final _garageAsBoxTruckPart = LensPart<Truck, BoxTruck>(
  get: (value) => value as BoxTruck,
  canGet: (value) => value is BoxTruck,
  set: (value, next) => next,
  name: 'BoxTruck',
);

final _garageTruckboxBoxVolumePart = LensPart<BoxTruck, double?>(
  get: (value) => value.boxVolume,
  set: (value, next) => value.copyWith(boxVolume: next),
  name: 'boxVolume',
);

final _garageAsTankerPart = LensPart<Truck, Tanker>(
  get: (value) => value as Tanker,
  canGet: (value) => value is Tanker,
  set: (value, next) => next,
  name: 'Tanker',
);

final _garageTrucktankerCapacityPart = LensPart<Tanker, double?>(
  get: (value) => value.capacity,
  set: (value, next) => value.copyWith(capacity: next),
  name: 'capacity',
);

final _garageBikeCastPart = LensPart<Vehicle, Bike>(
  get: (value) => value as Bike,
  canGet: (value) => value is Bike,
  set: (value, next) => next,
  name: 'Bike',
);

final _garageBikeElectricPart = LensPart<Bike, bool?>(
  get: (value) => value.electric,
  set: (value, next) => value.copyWith(electric: next),
  name: 'electric',
);

final _garageAsRoadBikePart = LensPart<Bike, RoadBike>(
  get: (value) => value as RoadBike,
  canGet: (value) => value is RoadBike,
  set: (value, next) => next,
  name: 'RoadBike',
);

final _garageBikeroadGearsPart = LensPart<RoadBike, int?>(
  get: (value) => value.gears,
  set: (value, next) => value.copyWith(gears: next),
  name: 'gears',
);

final _garageAsCargoBikePart = LensPart<Bike, CargoBike>(
  get: (value) => value as CargoBike,
  canGet: (value) => value is CargoBike,
  set: (value, next) => next,
  name: 'CargoBike',
);

final _garageBikecargoBasketsPart = LensPart<CargoBike, int?>(
  get: (value) => value.baskets,
  set: (value, next) => value.copyWith(baskets: next),
  name: 'baskets',
);

Lens<Fleet, String?> garageVehicleRegistrationPlateLens(
  GarageLocation location,
) => garageVehicleLens(location)
    .then(_garageGarageVehicleRegistrationPart)
    .then(_garageGarageVehicleregistrationPlatePart);

Lens<Fleet, String?> garageVehicleRegistrationRegionLens(
  GarageLocation location,
) => garageVehicleLens(location)
    .then(_garageGarageVehicleRegistrationPart)
    .then(_garageGarageVehicleregistrationRegionPart);

Lens<Fleet, String> carColorLens(GarageLocation location) => garageVehicleLens(
  location,
).then(_garageCarCastPart).then(_garageCarColorPart);

Lens<Fleet, int?> carYearLens(GarageLocation location) => garageVehicleLens(
  location,
).then(_garageCarCastPart).then(_garageCarYearPart);

Lens<Fleet, String?> carSedanTrimLevelLens(GarageLocation location) =>
    garageVehicleLens(location)
        .then(_garageCarCastPart)
        .then(_garageAsSedanPart)
        .then(_garageCarsedanTrimPart)
        .then(_garageCarsedantrimLevelPart);

Lens<Fleet, int?> carCoupeTopSpeedLens(GarageLocation location) =>
    garageVehicleLens(location)
        .then(_garageCarCastPart)
        .then(_garageAsCoupePart)
        .then(_garageCarcoupeTopSpeedPart);

Lens<Fleet, bool?> carConvertibleRoofOpenLens(GarageLocation location) =>
    garageVehicleLens(location)
        .then(_garageCarCastPart)
        .then(_garageAsConvertiblePart)
        .then(_garageCarconvertibleRoofOpenPart);

Lens<Fleet, int?> truckAxleCountLens(GarageLocation location) =>
    garageVehicleLens(
      location,
    ).then(_garageTruckCastPart).then(_garageTruckAxleCountPart);

Lens<Fleet, double?> truckBoxBoxVolumeLens(GarageLocation location) =>
    garageVehicleLens(location)
        .then(_garageTruckCastPart)
        .then(_garageAsBoxTruckPart)
        .then(_garageTruckboxBoxVolumePart);

Lens<Fleet, double?> truckTankerCapacityLens(GarageLocation location) =>
    garageVehicleLens(location)
        .then(_garageTruckCastPart)
        .then(_garageAsTankerPart)
        .then(_garageTrucktankerCapacityPart);

Lens<Fleet, bool?> bikeElectricLens(GarageLocation location) =>
    garageVehicleLens(
      location,
    ).then(_garageBikeCastPart).then(_garageBikeElectricPart);

Lens<Fleet, int?> bikeRoadGearsLens(GarageLocation location) =>
    garageVehicleLens(location)
        .then(_garageBikeCastPart)
        .then(_garageAsRoadBikePart)
        .then(_garageBikeroadGearsPart);

Lens<Fleet, int?> bikeCargoBasketsLens(GarageLocation location) =>
    garageVehicleLens(location)
        .then(_garageBikeCastPart)
        .then(_garageAsCargoBikePart)
        .then(_garageBikecargoBasketsPart);

bool garageVehicleRegistrationPlateHasSavedBacking(
  Fleet? saved,
  GarageLocation location,
) {
  if (saved == null) return false;
  try {
    garageVehicleRegistrationPlateLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final garageVehicleRegistrationPlateField =
    GeneratedEditField<Fleet, GarageLocation, String?, Lens<Fleet, String?>>(
      id: 'garageVehicleRegistrationPlate',
      dirtyField: GarageDirtyField.garageVehicleRegistrationPlate,
      lens: garageVehicleRegistrationPlateLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool garageVehicleRegistrationRegionHasSavedBacking(
  Fleet? saved,
  GarageLocation location,
) {
  if (saved == null) return false;
  try {
    garageVehicleRegistrationRegionLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final garageVehicleRegistrationRegionField =
    GeneratedEditField<Fleet, GarageLocation, String?, Lens<Fleet, String?>>(
      id: 'garageVehicleRegistrationRegion',
      dirtyField: GarageDirtyField.garageVehicleRegistrationRegion,
      lens: garageVehicleRegistrationRegionLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool carColorHasSavedBacking(Fleet? saved, GarageLocation location) {
  if (saved == null) return false;
  try {
    carColorLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carColorField =
    GeneratedEditField<Fleet, GarageLocation, String, Lens<Fleet, String>>(
      id: 'carColor',
      dirtyField: GarageDirtyField.carColor,
      lens: carColorLens,
      fallback: null,
      adapter: FieldAdapterSpec<String>.identity(),
    );

bool carYearHasSavedBacking(Fleet? saved, GarageLocation location) {
  if (saved == null) return false;
  try {
    carYearLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carYearField =
    GeneratedEditField<Fleet, GarageLocation, int?, Lens<Fleet, int?>>(
      id: 'carYear',
      dirtyField: GarageDirtyField.carYear,
      lens: carYearLens,
      fallback: null,
      adapter: FieldAdapterSpec<int?>.identity(),
    );

bool carSedanTrimLevelHasSavedBacking(Fleet? saved, GarageLocation location) {
  if (saved == null) return false;
  try {
    carSedanTrimLevelLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carSedanTrimLevelField =
    GeneratedEditField<Fleet, GarageLocation, String?, Lens<Fleet, String?>>(
      id: 'carSedanTrimLevel',
      dirtyField: GarageDirtyField.carSedanTrimLevel,
      lens: carSedanTrimLevelLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool carCoupeTopSpeedHasSavedBacking(Fleet? saved, GarageLocation location) {
  if (saved == null) return false;
  try {
    carCoupeTopSpeedLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carCoupeTopSpeedField =
    GeneratedEditField<Fleet, GarageLocation, int?, Lens<Fleet, int?>>(
      id: 'carCoupeTopSpeed',
      dirtyField: GarageDirtyField.carCoupeTopSpeed,
      lens: carCoupeTopSpeedLens,
      fallback: null,
      adapter: FieldAdapterSpec<int?>.identity(),
    );

bool carConvertibleRoofOpenHasSavedBacking(
  Fleet? saved,
  GarageLocation location,
) {
  if (saved == null) return false;
  try {
    carConvertibleRoofOpenLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carConvertibleRoofOpenField =
    GeneratedEditField<Fleet, GarageLocation, bool?, Lens<Fleet, bool?>>(
      id: 'carConvertibleRoofOpen',
      dirtyField: GarageDirtyField.carConvertibleRoofOpen,
      lens: carConvertibleRoofOpenLens,
      fallback: null,
      adapter: FieldAdapterSpec<bool?>.identity(),
    );

bool truckAxleCountHasSavedBacking(Fleet? saved, GarageLocation location) {
  if (saved == null) return false;
  try {
    truckAxleCountLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final truckAxleCountField =
    GeneratedEditField<Fleet, GarageLocation, int?, Lens<Fleet, int?>>(
      id: 'truckAxleCount',
      dirtyField: GarageDirtyField.truckAxleCount,
      lens: truckAxleCountLens,
      fallback: null,
      adapter: FieldAdapterSpec<int?>.identity(),
    );

bool truckBoxBoxVolumeHasSavedBacking(Fleet? saved, GarageLocation location) {
  if (saved == null) return false;
  try {
    truckBoxBoxVolumeLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final truckBoxBoxVolumeField =
    GeneratedEditField<Fleet, GarageLocation, double?, Lens<Fleet, double?>>(
      id: 'truckBoxBoxVolume',
      dirtyField: GarageDirtyField.truckBoxBoxVolume,
      lens: truckBoxBoxVolumeLens,
      fallback: null,
      adapter: FieldAdapterSpec<double?>.identity(),
    );

bool truckTankerCapacityHasSavedBacking(Fleet? saved, GarageLocation location) {
  if (saved == null) return false;
  try {
    truckTankerCapacityLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final truckTankerCapacityField =
    GeneratedEditField<Fleet, GarageLocation, double?, Lens<Fleet, double?>>(
      id: 'truckTankerCapacity',
      dirtyField: GarageDirtyField.truckTankerCapacity,
      lens: truckTankerCapacityLens,
      fallback: null,
      adapter: FieldAdapterSpec<double?>.identity(),
    );

bool bikeElectricHasSavedBacking(Fleet? saved, GarageLocation location) {
  if (saved == null) return false;
  try {
    bikeElectricLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final bikeElectricField =
    GeneratedEditField<Fleet, GarageLocation, bool?, Lens<Fleet, bool?>>(
      id: 'bikeElectric',
      dirtyField: GarageDirtyField.bikeElectric,
      lens: bikeElectricLens,
      fallback: null,
      adapter: FieldAdapterSpec<bool?>.identity(),
    );

bool bikeRoadGearsHasSavedBacking(Fleet? saved, GarageLocation location) {
  if (saved == null) return false;
  try {
    bikeRoadGearsLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final bikeRoadGearsField =
    GeneratedEditField<Fleet, GarageLocation, int?, Lens<Fleet, int?>>(
      id: 'bikeRoadGears',
      dirtyField: GarageDirtyField.bikeRoadGears,
      lens: bikeRoadGearsLens,
      fallback: null,
      adapter: FieldAdapterSpec<int?>.identity(),
    );

bool bikeCargoBasketsHasSavedBacking(Fleet? saved, GarageLocation location) {
  if (saved == null) return false;
  try {
    bikeCargoBasketsLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final bikeCargoBasketsField =
    GeneratedEditField<Fleet, GarageLocation, int?, Lens<Fleet, int?>>(
      id: 'bikeCargoBaskets',
      dirtyField: GarageDirtyField.bikeCargoBaskets,
      lens: bikeCargoBasketsLens,
      fallback: null,
      adapter: FieldAdapterSpec<int?>.identity(),
    );

Object? comparableGarageFieldValue(Fleet? value, GarageDirtyField field) =>
    switch (field) {
      GarageDirtyField.garageVehicleRegistrationPlate => null,
      GarageDirtyField.garageVehicleRegistrationRegion => null,
      GarageDirtyField.carColor => null,
      GarageDirtyField.carYear => null,
      GarageDirtyField.carSedanTrimLevel => null,
      GarageDirtyField.carCoupeTopSpeed => null,
      GarageDirtyField.carConvertibleRoofOpen => null,
      GarageDirtyField.truckAxleCount => null,
      GarageDirtyField.truckBoxBoxVolume => null,
      GarageDirtyField.truckTankerCapacity => null,
      GarageDirtyField.bikeElectric => null,
      GarageDirtyField.bikeRoadGears => null,
      GarageDirtyField.bikeCargoBaskets => null,
    };

Object? comparableRegistrationValue(Registration? value) => [
  value?.plate,
  value?.region,
];

Object? comparableCarValue(Car? value) => switch (value) {
  Sedan() && final v => [
    v.color,
    v.year,
    'sedan',
    comparableTrimValue(v?.trim),
  ],
  Coupe() && final v => [v.color, v.year, 'coupe', v.topSpeed],
  Convertible() && final v => [
    v.color,
    v.year,
    'convertible',
    v.roofOpen ?? false,
  ],
  _ => null,
};

Object? comparableTrimValue(Trim? value) => [value?.level];

Object? comparableTruckValue(Truck? value) => switch (value) {
  BoxTruck() && final v => [v.axleCount, 'box', v.boxVolume],
  Tanker() && final v => [v.axleCount, 'tanker', v.capacity],
  _ => null,
};

Object? comparableBikeValue(Bike? value) => switch (value) {
  RoadBike() && final v => [v.electric, 'road', v.gears],
  CargoBike() && final v => [v.electric, 'cargo', v.baskets],
  _ => null,
};

Object? comparableFleetValue(Fleet? value) => [
  (value?.cars ?? const <Car>[]).map(comparableCarValue).toList(),
  (value?.trucks ?? const <Truck>[]).map(comparableTruckValue).toList(),
  (value?.bikes ?? const <Bike>[]).map(comparableBikeValue).toList(),
];
