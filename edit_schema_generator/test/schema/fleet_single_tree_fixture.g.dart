// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fleet_single_tree_fixture.dart';

// **************************************************************************
// EditSchemaSourceGenerator
// **************************************************************************

// Generated code. Do not modify by hand.
// ignore_for_file: dead_code, prefer_null_aware_operators, lines_longer_than_80_chars, unnecessary_cast, unnecessary_lambdas, unnecessary_parenthesis, unreachable_switch_case, unused_element, invalid_null_aware_operator, unused_local_variable, avoid_equals_and_hash_code_on_mutable_classes

Lens<Fleet> _fleetRootLens() => Lens<Fleet>(
  get: (root) => root as Fleet,
  set: (root, next) => next,
  name: 'fleet',
);

enum FleetDirtyField {
  settingsAutoSync,
  settingsAlerts,
  settingsRegion,
  settingsEmergencyContacts,
  settingsNotificationsEmail,
  settingsNotificationsSms,
  settingsNotificationsWebhookUrl,
  carRegistrationPlate,
  carRegistrationVin,
  carRegistrationRegion,
  carRegistrationLocked,
  carRegistrationTags,
  carRegistrationNotes,
  carRegistrationPermitDetailAuthority,
  carRegistrationPermitDetailRevoked,
  carRegistrationPermitDetailParkingZone,
  carRegistrationPermitDetailParkingHours,
  carRegistrationPermitDetailTollAccount,
  carRegistrationPermitDetailTollBalance,
  carRegistrationPermitDetailAccessGateId,
  carRegistrationPermitDetailAccessGateManualKey,
  carRegistrationPermitDetailAccessGateAutoSensorModel,
  carRegistrationPermitDetailAccessGateAutoBackupId,
  carRegistrationPermitLabel,
  carRegistrationPermitPriority,
  carRegistrationPermitRepeat,
  carRegistrationPermitEnabled,
  carColor,
  carYear,
  carSedanTrimLevel,
  carSedanTrimLeather,
  carSedanTrimUpholsteryMaterial,
  carSedanTrimUpholsteryColor,
  carSedanTrimUpholsteryHeated,
  carSedanTrimUpholsteryRows,
  carCoupeTrimLevel,
  carCoupeTrimLeather,
  carCoupeTrimUpholsteryMaterial,
  carCoupeTrimUpholsteryColor,
  carCoupeTrimUpholsteryHeated,
  carCoupeTrimUpholsteryRows,
  carCoupeDrivetrainLabel,
  carCoupeDrivetrainFixedAxle,
  carCoupeDrivetrainRangeMinRatio,
  carCoupeDrivetrainRangeMaxRatio,
  carCoupeDrivetrainRangeLocking,
  carCoupeTopSpeed,
  carConvertibleTrimLevel,
  carConvertibleTrimLeather,
  carConvertibleTrimUpholsteryMaterial,
  carConvertibleTrimUpholsteryColor,
  carConvertibleTrimUpholsteryHeated,
  carConvertibleTrimUpholsteryRows,
  carConvertibleRoofOpen,
  truckRegistrationPlate,
  truckRegistrationVin,
  truckRegistrationRegion,
  truckRegistrationLocked,
  truckRegistrationTags,
  truckRegistrationNotes,
  truckRegistrationPermitDetailAuthority,
  truckRegistrationPermitDetailRevoked,
  truckRegistrationPermitDetailParkingZone,
  truckRegistrationPermitDetailParkingHours,
  truckRegistrationPermitDetailTollAccount,
  truckRegistrationPermitDetailTollBalance,
  truckRegistrationPermitDetailAccessGateId,
  truckRegistrationPermitDetailAccessGateManualKey,
  truckRegistrationPermitDetailAccessGateAutoSensorModel,
  truckRegistrationPermitDetailAccessGateAutoBackupId,
  truckRegistrationPermitLabel,
  truckRegistrationPermitPriority,
  truckRegistrationPermitRepeat,
  truckRegistrationPermitEnabled,
  truckAxleCount,
  truckBoxTrimLevel,
  truckBoxTrimLeather,
  truckBoxTrimUpholsteryMaterial,
  truckBoxTrimUpholsteryColor,
  truckBoxTrimUpholsteryHeated,
  truckBoxTrimUpholsteryRows,
  truckBoxBoxVolume,
  truckTankerCapacity,
  truckTankerHazmat,
  bikeRegistrationPlate,
  bikeRegistrationVin,
  bikeRegistrationRegion,
  bikeRegistrationLocked,
  bikeRegistrationTags,
  bikeRegistrationNotes,
  bikeRegistrationPermitDetailAuthority,
  bikeRegistrationPermitDetailRevoked,
  bikeRegistrationPermitDetailParkingZone,
  bikeRegistrationPermitDetailParkingHours,
  bikeRegistrationPermitDetailTollAccount,
  bikeRegistrationPermitDetailTollBalance,
  bikeRegistrationPermitDetailAccessGateId,
  bikeRegistrationPermitDetailAccessGateManualKey,
  bikeRegistrationPermitDetailAccessGateAutoSensorModel,
  bikeRegistrationPermitDetailAccessGateAutoBackupId,
  bikeRegistrationPermitLabel,
  bikeRegistrationPermitPriority,
  bikeRegistrationPermitRepeat,
  bikeRegistrationPermitEnabled,
  bikeElectric,
  bikeRoadGears,
  bikeCargoBaskets,
  bikeCargoAssist,
  policyConditions,
  policyLimitsMaxSpeed,
  policyLimitsMaxLoad,
  policyLimitsEscort,
  policyLimitsCurfew,
  policyLimitsInspectionDays,
  depotCapacity,
  depotBays,
  depotNightShift,
  depotNotes,
}

final class BikeLocation {
  const BikeLocation({required this.bikeIndex});

  final int bikeIndex;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BikeLocation && other.bikeIndex == bikeIndex);

  @override
  int get hashCode => bikeIndex.hashCode;
}

final class BikePermitGateLocation {
  const BikePermitGateLocation({
    required this.bikeIndex,
    required this.permitIndex,
    required this.gateIndex,
  });

  final int bikeIndex;
  final int permitIndex;
  final int gateIndex;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BikePermitGateLocation &&
          other.bikeIndex == bikeIndex &&
          other.permitIndex == permitIndex &&
          other.gateIndex == gateIndex);

  @override
  int get hashCode => Object.hash(bikeIndex, permitIndex, gateIndex);
}

final class BikePermitLocation {
  const BikePermitLocation({
    required this.bikeIndex,
    required this.permitIndex,
  });

  final int bikeIndex;
  final int permitIndex;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BikePermitLocation &&
          other.bikeIndex == bikeIndex &&
          other.permitIndex == permitIndex);

  @override
  int get hashCode => Object.hash(bikeIndex, permitIndex);
}

final class CarLocation {
  const CarLocation({required this.carIndex});

  final int carIndex;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CarLocation && other.carIndex == carIndex);

  @override
  int get hashCode => carIndex.hashCode;
}

final class CarPermitGateLocation {
  const CarPermitGateLocation({
    required this.carIndex,
    required this.permitIndex,
    required this.gateIndex,
  });

  final int carIndex;
  final int permitIndex;
  final int gateIndex;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CarPermitGateLocation &&
          other.carIndex == carIndex &&
          other.permitIndex == permitIndex &&
          other.gateIndex == gateIndex);

  @override
  int get hashCode => Object.hash(carIndex, permitIndex, gateIndex);
}

final class CarPermitLocation {
  const CarPermitLocation({required this.carIndex, required this.permitIndex});

  final int carIndex;
  final int permitIndex;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CarPermitLocation &&
          other.carIndex == carIndex &&
          other.permitIndex == permitIndex);

  @override
  int get hashCode => Object.hash(carIndex, permitIndex);
}

final class PolicyLocation {
  const PolicyLocation({required this.policyIndex});

  final int policyIndex;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PolicyLocation && other.policyIndex == policyIndex);

  @override
  int get hashCode => policyIndex.hashCode;
}

final class TruckLocation {
  const TruckLocation({required this.truckIndex});

  final int truckIndex;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TruckLocation && other.truckIndex == truckIndex);

  @override
  int get hashCode => truckIndex.hashCode;
}

final class TruckPermitGateLocation {
  const TruckPermitGateLocation({
    required this.truckIndex,
    required this.permitIndex,
    required this.gateIndex,
  });

  final int truckIndex;
  final int permitIndex;
  final int gateIndex;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TruckPermitGateLocation &&
          other.truckIndex == truckIndex &&
          other.permitIndex == permitIndex &&
          other.gateIndex == gateIndex);

  @override
  int get hashCode => Object.hash(truckIndex, permitIndex, gateIndex);
}

final class TruckPermitLocation {
  const TruckPermitLocation({
    required this.truckIndex,
    required this.permitIndex,
  });

  final int truckIndex;
  final int permitIndex;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TruckPermitLocation &&
          other.truckIndex == truckIndex &&
          other.permitIndex == permitIndex);

  @override
  int get hashCode => Object.hash(truckIndex, permitIndex);
}

final _fleetSettingsPart = LensPart<Fleet, FleetSettings>(
  get: (value) => value.settings,
  set: (value, next) => value.copyWith(settings: next),
  name: 'settings',
);

final _fleetSettingsAutoSyncPart = LensPart<FleetSettings, bool?>(
  get: (value) => value.autoSync,
  set: (value, next) => value.copyWith(autoSync: next),
  name: 'autoSync',
);

final _fleetSettingsAlertsPart = LensPart<FleetSettings, bool?>(
  get: (value) => value.alerts,
  set: (value, next) => value.copyWith(alerts: next),
  name: 'alerts',
);

final _fleetSettingsRegionPart = LensPart<FleetSettings, String?>(
  get: (value) => value.region,
  set: (value, next) => value.copyWith(region: next),
  name: 'region',
);

final _fleetSettingsEmergencyContactsPart =
    LensPart<FleetSettings, List<String>?>(
      get: (value) => value.emergencyContacts,
      set: (value, next) => value.copyWith(emergencyContacts: next),
      name: 'emergencyContacts',
    );

final _fleetSettingsNotificationsPart =
    LensPart<FleetSettings, NotificationSettings>(
      get: (value) => value.notifications,
      set: (value, next) => value.copyWith(notifications: next),
      name: 'notifications',
    );

final _fleetSettingsnotificationsEmailPart =
    LensPart<NotificationSettings, bool?>(
      get: (value) => value.email,
      set: (value, next) => value.copyWith(email: next),
      name: 'email',
    );

final _fleetSettingsnotificationsSmsPart =
    LensPart<NotificationSettings, bool?>(
      get: (value) => value.sms,
      set: (value, next) => value.copyWith(sms: next),
      name: 'sms',
    );

final _fleetSettingsnotificationsWebhookUrlPart =
    LensPart<NotificationSettings, String?>(
      get: (value) => value.webhookUrl,
      set: (value, next) => value.copyWith(webhookUrl: next),
      name: 'webhookUrl',
    );

LensPart<Fleet, Car> _fleetCarItemPart(int index) => LensPart<Fleet, Car>(
  get: (value) => value.cars[index],
  set: (value, nextValue) {
    if (index < 0 || index >= value.cars.length) return value;
    final next = List<Car>.of(value.cars);
    next[index] = nextValue;
    return value.copyWith(cars: next);
  },
  canGet: (value) => index >= 0 && index < value.cars.length,
  name: 'car[$index]',
);

Fleet replaceCarAt(Fleet root, int index, Car value) {
  final list = root.cars;
  if (index < 0 || index >= list.length) return root;
  final next = List<Car>.of(list);
  next[index] = value;
  return root.copyWith(cars: next);
}

Fleet updateCarAt(Fleet root, int index, Car Function(Car value) update) {
  final list = root.cars;
  if (index < 0 || index >= list.length) return root;
  final next = List<Car>.of(list);
  next[index] = update(next[index]);
  return root.copyWith(cars: next);
}

Fleet insertCarAt(Fleet root, int index, Car value) {
  final list = root.cars;
  if (index < 0 || index > list.length) return root;
  final next = List<Car>.of(list)..insert(index, value);
  return root.copyWith(cars: next);
}

Fleet addCar(Fleet root, Car value) {
  final next = List<Car>.of(root.cars)..add(value);
  return root.copyWith(cars: next);
}

Fleet removeCarAt(Fleet root, int index) {
  final list = root.cars;
  if (index < 0 || index >= list.length) return root;
  final next = List<Car>.of(list)..removeAt(index);
  return root.copyWith(cars: next);
}

Fleet duplicateCarAt(Fleet root, int index) {
  final list = root.cars;
  if (index < 0 || index >= list.length) return root;
  final next = List<Car>.of(list)..insert(index + 1, list[index]);
  return root.copyWith(cars: next);
}

Fleet moveCar(Fleet root, int from, int to) {
  final list = root.cars;
  if (from < 0 || from >= list.length) return root;
  final next = List<Car>.of(list);
  final item = next.removeAt(from);
  next.insert(to.clamp(0, next.length), item);
  return root.copyWith(cars: next);
}

final _fleetCarRegistrationPart = LensPart<Car, Registration>(
  get: (value) => value.registration,
  set: (value, next) => value.copyWith(registration: next),
  name: 'registration',
);

final _fleetCarregistrationPlatePart = LensPart<Registration, String?>(
  get: (value) => value.plate,
  set: (value, next) => value.copyWith(plate: next),
  name: 'plate',
);

final _fleetCarregistrationVinPart = LensPart<Registration, String?>(
  get: (value) => value.vin,
  set: (value, next) => value.copyWith(vin: next),
  name: 'vin',
);

final _fleetCarregistrationRegionPart = LensPart<Registration, String?>(
  get: (value) => value.region,
  set: (value, next) => value.copyWith(region: next),
  name: 'region',
);

final _fleetCarregistrationLockedPart = LensPart<Registration, bool?>(
  get: (value) => value.locked,
  set: (value, next) => value.copyWith(locked: next),
  name: 'locked',
);

final _fleetCarregistrationTagsPart = LensPart<Registration, List<String>>(
  get: (value) => value.tags,
  set: (value, next) => value.copyWith(tags: next),
  name: 'tags',
);

final _fleetCarregistrationNotesPart = LensPart<Registration, String?>(
  get: (value) => value.notes,
  set: (value, next) => value.copyWith(notes: next),
  name: 'notes',
);

LensPart<Registration, Permit> _fleetCarregistrationPermitsItemPart(
  int index,
) => LensPart<Registration, Permit>(
  get: (value) => value.permits[index],
  set: (value, nextValue) {
    if (index < 0 || index >= value.permits.length) return value;
    final next = List<Permit>.of(value.permits);
    next[index] = nextValue;
    return value.copyWith(permits: next);
  },
  canGet: (value) => index >= 0 && index < value.permits.length,
  name: 'permits[$index]',
);

Registration replacePermitAt(Registration root, int index, Permit value) {
  final list = root.permits;
  if (index < 0 || index >= list.length) return root;
  final next = List<Permit>.of(list);
  next[index] = value;
  return root.copyWith(permits: next);
}

Registration updatePermitAt(
  Registration root,
  int index,
  Permit Function(Permit value) update,
) {
  final list = root.permits;
  if (index < 0 || index >= list.length) return root;
  final next = List<Permit>.of(list);
  next[index] = update(next[index]);
  return root.copyWith(permits: next);
}

Registration insertPermitAt(Registration root, int index, Permit value) {
  final list = root.permits;
  if (index < 0 || index > list.length) return root;
  final next = List<Permit>.of(list)..insert(index, value);
  return root.copyWith(permits: next);
}

Registration addPermit(Registration root, Permit value) {
  final next = List<Permit>.of(root.permits)..add(value);
  return root.copyWith(permits: next);
}

Registration removePermitAt(Registration root, int index) {
  final list = root.permits;
  if (index < 0 || index >= list.length) return root;
  final next = List<Permit>.of(list)..removeAt(index);
  return root.copyWith(permits: next);
}

Registration duplicatePermitAt(Registration root, int index) {
  final list = root.permits;
  if (index < 0 || index >= list.length) return root;
  final next = List<Permit>.of(list)..insert(index + 1, list[index]);
  return root.copyWith(permits: next);
}

Registration movePermit(Registration root, int from, int to) {
  final list = root.permits;
  if (from < 0 || from >= list.length) return root;
  final next = List<Permit>.of(list);
  final item = next.removeAt(from);
  next.insert(to.clamp(0, next.length), item);
  return root.copyWith(permits: next);
}

final _fleetCarregistrationpermitDetailPart = LensPart<Permit, PermitDetail>(
  get: (value) => value.detail,
  set: (value, next) => value.copyWith(detail: next),
  name: 'detail',
);

final _fleetCarregistrationpermitDetailAuthorityPart =
    LensPart<PermitDetail, String?>(
      get: (value) => value.authority,
      set: (value, next) => value.copyWith(authority: next),
      name: 'authority',
    );

final _fleetCarregistrationpermitDetailRevokedPart =
    LensPart<PermitDetail, bool?>(
      get: (value) => value.revoked,
      set: (value, next) => value.copyWith(revoked: next),
      name: 'revoked',
    );

final _fleetCarregistrationpermitAsParkingPermitPart =
    LensPart<PermitDetail, ParkingPermit>(
      get: (value) => value as ParkingPermit,
      canGet: (value) => value is ParkingPermit,
      set: (value, next) => next,
      name: 'ParkingPermit',
    );

final _fleetCarregistrationpermitdetailparkingZonePart =
    LensPart<ParkingPermit, String>(
      get: (value) => value.zone,
      set: (value, next) => value.copyWith(zone: next),
      name: 'zone',
    );

final _fleetCarregistrationpermitdetailparkingHoursPart =
    LensPart<ParkingPermit, int?>(
      get: (value) => value.hours,
      set: (value, next) => value.copyWith(hours: next),
      name: 'hours',
    );

final _fleetCarregistrationpermitAsTollPermitPart =
    LensPart<PermitDetail, TollPermit>(
      get: (value) => value as TollPermit,
      canGet: (value) => value is TollPermit,
      set: (value, next) => next,
      name: 'TollPermit',
    );

final _fleetCarregistrationpermitdetailtollAccountPart =
    LensPart<TollPermit, String>(
      get: (value) => value.account,
      set: (value, next) => value.copyWith(account: next),
      name: 'account',
    );

final _fleetCarregistrationpermitdetailtollBalancePart =
    LensPart<TollPermit, double>(
      get: (value) => value.balance,
      set: (value, next) => value.copyWith(balance: next),
      name: 'balance',
    );

final _fleetCarregistrationpermitAsAccessPermitPart =
    LensPart<PermitDetail, AccessPermit>(
      get: (value) => value as AccessPermit,
      canGet: (value) => value is AccessPermit,
      set: (value, next) => next,
      name: 'AccessPermit',
    );

LensPart<AccessPermit, Gate>
_fleetCarregistrationpermitdetailaccessGatesItemPart(int index) =>
    LensPart<AccessPermit, Gate>(
      get: (value) => value.gates[index],
      set: (value, nextValue) {
        if (index < 0 || index >= value.gates.length) return value;
        final next = List<Gate>.of(value.gates);
        next[index] = nextValue;
        return value.copyWith(gates: next);
      },
      canGet: (value) => index >= 0 && index < value.gates.length,
      name: 'gates[$index]',
    );

AccessPermit replaceGateAt(AccessPermit root, int index, Gate value) {
  final list = root.gates;
  if (index < 0 || index >= list.length) return root;
  final next = List<Gate>.of(list);
  next[index] = value;
  return root.copyWith(gates: next);
}

AccessPermit updateGateAt(
  AccessPermit root,
  int index,
  Gate Function(Gate value) update,
) {
  final list = root.gates;
  if (index < 0 || index >= list.length) return root;
  final next = List<Gate>.of(list);
  next[index] = update(next[index]);
  return root.copyWith(gates: next);
}

AccessPermit insertGateAt(AccessPermit root, int index, Gate value) {
  final list = root.gates;
  if (index < 0 || index > list.length) return root;
  final next = List<Gate>.of(list)..insert(index, value);
  return root.copyWith(gates: next);
}

AccessPermit addGate(AccessPermit root, Gate value) {
  final next = List<Gate>.of(root.gates)..add(value);
  return root.copyWith(gates: next);
}

AccessPermit removeGateAt(AccessPermit root, int index) {
  final list = root.gates;
  if (index < 0 || index >= list.length) return root;
  final next = List<Gate>.of(list)..removeAt(index);
  return root.copyWith(gates: next);
}

AccessPermit duplicateGateAt(AccessPermit root, int index) {
  final list = root.gates;
  if (index < 0 || index >= list.length) return root;
  final next = List<Gate>.of(list)..insert(index + 1, list[index]);
  return root.copyWith(gates: next);
}

AccessPermit moveGate(AccessPermit root, int from, int to) {
  final list = root.gates;
  if (from < 0 || from >= list.length) return root;
  final next = List<Gate>.of(list);
  final item = next.removeAt(from);
  next.insert(to.clamp(0, next.length), item);
  return root.copyWith(gates: next);
}

final _fleetCarregistrationpermitdetailaccessgateIdPart =
    LensPart<Gate, String>(
      get: (value) => value.id,
      set: (value, next) => value.copyWith(id: next),
      name: 'id',
    );

final _fleetCarregistrationpermitdetailaccessgateAsManualGatePart =
    LensPart<Gate, ManualGate>(
      get: (value) => value as ManualGate,
      canGet: (value) => value is ManualGate,
      set: (value, next) => next,
      name: 'ManualGate',
    );

final _fleetCarregistrationpermitdetailaccessgatemanualKeyPart =
    LensPart<ManualGate, String?>(
      get: (value) => value.key,
      set: (value, next) => value.copyWith(key: next),
      name: 'key',
    );

final _fleetCarregistrationpermitdetailaccessgateAsAutoGatePart =
    LensPart<Gate, AutoGate>(
      get: (value) => value as AutoGate,
      canGet: (value) => value is AutoGate,
      set: (value, next) => next,
      name: 'AutoGate',
    );

final _fleetCarregistrationpermitdetailaccessgateautoSensorModelPart =
    LensPart<AutoGate, String?>(
      get: (value) => value.sensorModel,
      set: (value, next) => value.copyWith(sensorModel: next),
      name: 'sensorModel',
    );

final _fleetCarregistrationpermitdetailaccessgateautoBackupIdPart =
    LensPart<AutoGate, String?>(
      get: (value) => value.backupId,
      set: (value, next) => value.copyWith(backupId: next),
      name: 'backupId',
    );

final _fleetCarregistrationpermitLabelPart = LensPart<Permit, String?>(
  get: (value) => value.label,
  set: (value, next) => value.copyWith(label: next),
  name: 'label',
);

final _fleetCarregistrationpermitPriorityPart = LensPart<Permit, int?>(
  get: (value) => value.priority,
  set: (value, next) => value.copyWith(priority: next),
  name: 'priority',
);

final _fleetCarregistrationpermitRepeatPart = LensPart<Permit, int?>(
  get: (value) => value.repeat,
  set: (value, next) => value.copyWith(repeat: next),
  name: 'repeat',
);

final _fleetCarregistrationpermitEnabledPart = LensPart<Permit, bool?>(
  get: (value) => value.enabled,
  set: (value, next) => value.copyWith(enabled: next),
  name: 'enabled',
);

final _fleetCarColorPart = LensPart<Car, String>(
  get: (value) => value.color,
  set: (value, next) => value.copyWith(color: next),
  name: 'color',
);

final _fleetCarYearPart = LensPart<Car, int?>(
  get: (value) => value.year,
  set: (value, next) => value.copyWith(year: next),
  name: 'year',
);

final _fleetCarAsSedanPart = LensPart<Car, Sedan>(
  get: (value) => value as Sedan,
  canGet: (value) => value is Sedan,
  set: (value, next) => next,
  name: 'Sedan',
);

final _fleetCarsedanTrimPart = LensPart<Sedan, Trim>(
  get: (value) => value.trim,
  set: (value, next) => value.copyWith(trim: next),
  name: 'trim',
);

final _fleetCarsedantrimLevelPart = LensPart<Trim, String?>(
  get: (value) => value.level,
  set: (value, next) => value.copyWith(level: next),
  name: 'level',
);

final _fleetCarsedantrimLeatherPart = LensPart<Trim, bool?>(
  get: (value) => value.leather,
  set: (value, next) => value.copyWith(leather: next),
  name: 'leather',
);

final _fleetCarsedantrimUpholsteryPart = LensPart<Trim, Upholstery>(
  get: (value) => value.upholstery,
  set: (value, next) => value.copyWith(upholstery: next),
  name: 'upholstery',
);

final _fleetCarsedantrimupholsteryMaterialPart = LensPart<Upholstery, String?>(
  get: (value) => value.material,
  set: (value, next) => value.copyWith(material: next),
  name: 'material',
);

final _fleetCarsedantrimupholsteryColorPart = LensPart<Upholstery, String?>(
  get: (value) => value.color,
  set: (value, next) => value.copyWith(color: next),
  name: 'color',
);

final _fleetCarsedantrimupholsteryHeatedPart = LensPart<Upholstery, bool?>(
  get: (value) => value.heated,
  set: (value, next) => value.copyWith(heated: next),
  name: 'heated',
);

final _fleetCarsedantrimupholsteryRowsPart = LensPart<Upholstery, List<int>>(
  get: (value) => value.rows,
  set: (value, next) => value.copyWith(rows: next),
  name: 'rows',
);

final _fleetCarAsCoupePart = LensPart<Car, Coupe>(
  get: (value) => value as Coupe,
  canGet: (value) => value is Coupe,
  set: (value, next) => next,
  name: 'Coupe',
);

final _fleetCarcoupeTrimPart = LensPart<Coupe, Trim>(
  get: (value) => value.trim,
  set: (value, next) => value.copyWith(trim: next),
  name: 'trim',
);

final _fleetCarcoupetrimLevelPart = LensPart<Trim, String?>(
  get: (value) => value.level,
  set: (value, next) => value.copyWith(level: next),
  name: 'level',
);

final _fleetCarcoupetrimLeatherPart = LensPart<Trim, bool?>(
  get: (value) => value.leather,
  set: (value, next) => value.copyWith(leather: next),
  name: 'leather',
);

final _fleetCarcoupetrimUpholsteryPart = LensPart<Trim, Upholstery>(
  get: (value) => value.upholstery,
  set: (value, next) => value.copyWith(upholstery: next),
  name: 'upholstery',
);

final _fleetCarcoupetrimupholsteryMaterialPart = LensPart<Upholstery, String?>(
  get: (value) => value.material,
  set: (value, next) => value.copyWith(material: next),
  name: 'material',
);

final _fleetCarcoupetrimupholsteryColorPart = LensPart<Upholstery, String?>(
  get: (value) => value.color,
  set: (value, next) => value.copyWith(color: next),
  name: 'color',
);

final _fleetCarcoupetrimupholsteryHeatedPart = LensPart<Upholstery, bool?>(
  get: (value) => value.heated,
  set: (value, next) => value.copyWith(heated: next),
  name: 'heated',
);

final _fleetCarcoupetrimupholsteryRowsPart = LensPart<Upholstery, List<int>>(
  get: (value) => value.rows,
  set: (value, next) => value.copyWith(rows: next),
  name: 'rows',
);

final _fleetCarcoupeDrivetrainPart = LensPart<Coupe, Drivetrain>(
  get: (value) => value.drivetrain,
  set: (value, next) => value.copyWith(drivetrain: next),
  name: 'drivetrain',
);

final _fleetCarcoupedrivetrainLabelPart = LensPart<Drivetrain, String?>(
  get: (value) => value.label,
  set: (value, next) => value.copyWith(label: next),
  name: 'label',
);

final _fleetCarcoupedrivetrainAsFixedDrivePart =
    LensPart<Drivetrain, FixedDrive>(
      get: (value) => value as FixedDrive,
      canGet: (value) => value is FixedDrive,
      set: (value, next) => next,
      name: 'FixedDrive',
    );

final _fleetCarcoupedrivetrainfixedAxlePart = LensPart<FixedDrive, String>(
  get: (value) => value.axle,
  set: (value, next) => value.copyWith(axle: next),
  name: 'axle',
);

final _fleetCarcoupedrivetrainAsRangeDrivePart =
    LensPart<Drivetrain, RangeDrive>(
      get: (value) => value as RangeDrive,
      canGet: (value) => value is RangeDrive,
      set: (value, next) => next,
      name: 'RangeDrive',
    );

final _fleetCarcoupedrivetrainrangeMinRatioPart = LensPart<RangeDrive, double>(
  get: (value) => value.minRatio,
  set: (value, next) => value.copyWith(minRatio: next),
  name: 'minRatio',
);

final _fleetCarcoupedrivetrainrangeMaxRatioPart = LensPart<RangeDrive, double>(
  get: (value) => value.maxRatio,
  set: (value, next) => value.copyWith(maxRatio: next),
  name: 'maxRatio',
);

final _fleetCarcoupedrivetrainrangeLockingPart = LensPart<RangeDrive, bool>(
  get: (value) => value.locking,
  set: (value, next) => value.copyWith(locking: next),
  name: 'locking',
);

final _fleetCarcoupeTopSpeedPart = LensPart<Coupe, int?>(
  get: (value) => value.topSpeed,
  set: (value, next) => value.copyWith(topSpeed: next),
  name: 'topSpeed',
);

final _fleetCarAsConvertiblePart = LensPart<Car, Convertible>(
  get: (value) => value as Convertible,
  canGet: (value) => value is Convertible,
  set: (value, next) => next,
  name: 'Convertible',
);

final _fleetCarconvertibleTrimPart = LensPart<Convertible, Trim>(
  get: (value) => value.trim,
  set: (value, next) => value.copyWith(trim: next),
  name: 'trim',
);

final _fleetCarconvertibletrimLevelPart = LensPart<Trim, String?>(
  get: (value) => value.level,
  set: (value, next) => value.copyWith(level: next),
  name: 'level',
);

final _fleetCarconvertibletrimLeatherPart = LensPart<Trim, bool?>(
  get: (value) => value.leather,
  set: (value, next) => value.copyWith(leather: next),
  name: 'leather',
);

final _fleetCarconvertibletrimUpholsteryPart = LensPart<Trim, Upholstery>(
  get: (value) => value.upholstery,
  set: (value, next) => value.copyWith(upholstery: next),
  name: 'upholstery',
);

final _fleetCarconvertibletrimupholsteryMaterialPart =
    LensPart<Upholstery, String?>(
      get: (value) => value.material,
      set: (value, next) => value.copyWith(material: next),
      name: 'material',
    );

final _fleetCarconvertibletrimupholsteryColorPart =
    LensPart<Upholstery, String?>(
      get: (value) => value.color,
      set: (value, next) => value.copyWith(color: next),
      name: 'color',
    );

final _fleetCarconvertibletrimupholsteryHeatedPart =
    LensPart<Upholstery, bool?>(
      get: (value) => value.heated,
      set: (value, next) => value.copyWith(heated: next),
      name: 'heated',
    );

final _fleetCarconvertibletrimupholsteryRowsPart =
    LensPart<Upholstery, List<int>>(
      get: (value) => value.rows,
      set: (value, next) => value.copyWith(rows: next),
      name: 'rows',
    );

final _fleetCarconvertibleRoofOpenPart = LensPart<Convertible, bool?>(
  get: (value) => value.roofOpen,
  set: (value, next) => value.copyWith(roofOpen: next),
  name: 'roofOpen',
);

LensPart<Fleet, Truck> _fleetTruckItemPart(int index) => LensPart<Fleet, Truck>(
  get: (value) => value.trucks[index],
  set: (value, nextValue) {
    if (index < 0 || index >= value.trucks.length) return value;
    final next = List<Truck>.of(value.trucks);
    next[index] = nextValue;
    return value.copyWith(trucks: next);
  },
  canGet: (value) => index >= 0 && index < value.trucks.length,
  name: 'truck[$index]',
);

Fleet replaceTruckAt(Fleet root, int index, Truck value) {
  final list = root.trucks;
  if (index < 0 || index >= list.length) return root;
  final next = List<Truck>.of(list);
  next[index] = value;
  return root.copyWith(trucks: next);
}

Fleet updateTruckAt(Fleet root, int index, Truck Function(Truck value) update) {
  final list = root.trucks;
  if (index < 0 || index >= list.length) return root;
  final next = List<Truck>.of(list);
  next[index] = update(next[index]);
  return root.copyWith(trucks: next);
}

Fleet insertTruckAt(Fleet root, int index, Truck value) {
  final list = root.trucks;
  if (index < 0 || index > list.length) return root;
  final next = List<Truck>.of(list)..insert(index, value);
  return root.copyWith(trucks: next);
}

Fleet addTruck(Fleet root, Truck value) {
  final next = List<Truck>.of(root.trucks)..add(value);
  return root.copyWith(trucks: next);
}

Fleet removeTruckAt(Fleet root, int index) {
  final list = root.trucks;
  if (index < 0 || index >= list.length) return root;
  final next = List<Truck>.of(list)..removeAt(index);
  return root.copyWith(trucks: next);
}

Fleet duplicateTruckAt(Fleet root, int index) {
  final list = root.trucks;
  if (index < 0 || index >= list.length) return root;
  final next = List<Truck>.of(list)..insert(index + 1, list[index]);
  return root.copyWith(trucks: next);
}

Fleet moveTruck(Fleet root, int from, int to) {
  final list = root.trucks;
  if (from < 0 || from >= list.length) return root;
  final next = List<Truck>.of(list);
  final item = next.removeAt(from);
  next.insert(to.clamp(0, next.length), item);
  return root.copyWith(trucks: next);
}

final _fleetTruckRegistrationPart = LensPart<Truck, Registration>(
  get: (value) => value.registration,
  set: (value, next) => value.copyWith(registration: next),
  name: 'registration',
);

final _fleetTruckregistrationPlatePart = LensPart<Registration, String?>(
  get: (value) => value.plate,
  set: (value, next) => value.copyWith(plate: next),
  name: 'plate',
);

final _fleetTruckregistrationVinPart = LensPart<Registration, String?>(
  get: (value) => value.vin,
  set: (value, next) => value.copyWith(vin: next),
  name: 'vin',
);

final _fleetTruckregistrationRegionPart = LensPart<Registration, String?>(
  get: (value) => value.region,
  set: (value, next) => value.copyWith(region: next),
  name: 'region',
);

final _fleetTruckregistrationLockedPart = LensPart<Registration, bool?>(
  get: (value) => value.locked,
  set: (value, next) => value.copyWith(locked: next),
  name: 'locked',
);

final _fleetTruckregistrationTagsPart = LensPart<Registration, List<String>>(
  get: (value) => value.tags,
  set: (value, next) => value.copyWith(tags: next),
  name: 'tags',
);

final _fleetTruckregistrationNotesPart = LensPart<Registration, String?>(
  get: (value) => value.notes,
  set: (value, next) => value.copyWith(notes: next),
  name: 'notes',
);

LensPart<Registration, Permit> _fleetTruckregistrationPermitsItemPart(
  int index,
) => LensPart<Registration, Permit>(
  get: (value) => value.permits[index],
  set: (value, nextValue) {
    if (index < 0 || index >= value.permits.length) return value;
    final next = List<Permit>.of(value.permits);
    next[index] = nextValue;
    return value.copyWith(permits: next);
  },
  canGet: (value) => index >= 0 && index < value.permits.length,
  name: 'permits[$index]',
);

final _fleetTruckregistrationpermitDetailPart = LensPart<Permit, PermitDetail>(
  get: (value) => value.detail,
  set: (value, next) => value.copyWith(detail: next),
  name: 'detail',
);

final _fleetTruckregistrationpermitDetailAuthorityPart =
    LensPart<PermitDetail, String?>(
      get: (value) => value.authority,
      set: (value, next) => value.copyWith(authority: next),
      name: 'authority',
    );

final _fleetTruckregistrationpermitDetailRevokedPart =
    LensPart<PermitDetail, bool?>(
      get: (value) => value.revoked,
      set: (value, next) => value.copyWith(revoked: next),
      name: 'revoked',
    );

final _fleetTruckregistrationpermitAsParkingPermitPart =
    LensPart<PermitDetail, ParkingPermit>(
      get: (value) => value as ParkingPermit,
      canGet: (value) => value is ParkingPermit,
      set: (value, next) => next,
      name: 'ParkingPermit',
    );

final _fleetTruckregistrationpermitdetailparkingZonePart =
    LensPart<ParkingPermit, String>(
      get: (value) => value.zone,
      set: (value, next) => value.copyWith(zone: next),
      name: 'zone',
    );

final _fleetTruckregistrationpermitdetailparkingHoursPart =
    LensPart<ParkingPermit, int?>(
      get: (value) => value.hours,
      set: (value, next) => value.copyWith(hours: next),
      name: 'hours',
    );

final _fleetTruckregistrationpermitAsTollPermitPart =
    LensPart<PermitDetail, TollPermit>(
      get: (value) => value as TollPermit,
      canGet: (value) => value is TollPermit,
      set: (value, next) => next,
      name: 'TollPermit',
    );

final _fleetTruckregistrationpermitdetailtollAccountPart =
    LensPart<TollPermit, String>(
      get: (value) => value.account,
      set: (value, next) => value.copyWith(account: next),
      name: 'account',
    );

final _fleetTruckregistrationpermitdetailtollBalancePart =
    LensPart<TollPermit, double>(
      get: (value) => value.balance,
      set: (value, next) => value.copyWith(balance: next),
      name: 'balance',
    );

final _fleetTruckregistrationpermitAsAccessPermitPart =
    LensPart<PermitDetail, AccessPermit>(
      get: (value) => value as AccessPermit,
      canGet: (value) => value is AccessPermit,
      set: (value, next) => next,
      name: 'AccessPermit',
    );

LensPart<AccessPermit, Gate>
_fleetTruckregistrationpermitdetailaccessGatesItemPart(int index) =>
    LensPart<AccessPermit, Gate>(
      get: (value) => value.gates[index],
      set: (value, nextValue) {
        if (index < 0 || index >= value.gates.length) return value;
        final next = List<Gate>.of(value.gates);
        next[index] = nextValue;
        return value.copyWith(gates: next);
      },
      canGet: (value) => index >= 0 && index < value.gates.length,
      name: 'gates[$index]',
    );

final _fleetTruckregistrationpermitdetailaccessgateIdPart =
    LensPart<Gate, String>(
      get: (value) => value.id,
      set: (value, next) => value.copyWith(id: next),
      name: 'id',
    );

final _fleetTruckregistrationpermitdetailaccessgateAsManualGatePart =
    LensPart<Gate, ManualGate>(
      get: (value) => value as ManualGate,
      canGet: (value) => value is ManualGate,
      set: (value, next) => next,
      name: 'ManualGate',
    );

final _fleetTruckregistrationpermitdetailaccessgatemanualKeyPart =
    LensPart<ManualGate, String?>(
      get: (value) => value.key,
      set: (value, next) => value.copyWith(key: next),
      name: 'key',
    );

final _fleetTruckregistrationpermitdetailaccessgateAsAutoGatePart =
    LensPart<Gate, AutoGate>(
      get: (value) => value as AutoGate,
      canGet: (value) => value is AutoGate,
      set: (value, next) => next,
      name: 'AutoGate',
    );

final _fleetTruckregistrationpermitdetailaccessgateautoSensorModelPart =
    LensPart<AutoGate, String?>(
      get: (value) => value.sensorModel,
      set: (value, next) => value.copyWith(sensorModel: next),
      name: 'sensorModel',
    );

final _fleetTruckregistrationpermitdetailaccessgateautoBackupIdPart =
    LensPart<AutoGate, String?>(
      get: (value) => value.backupId,
      set: (value, next) => value.copyWith(backupId: next),
      name: 'backupId',
    );

final _fleetTruckregistrationpermitLabelPart = LensPart<Permit, String?>(
  get: (value) => value.label,
  set: (value, next) => value.copyWith(label: next),
  name: 'label',
);

final _fleetTruckregistrationpermitPriorityPart = LensPart<Permit, int?>(
  get: (value) => value.priority,
  set: (value, next) => value.copyWith(priority: next),
  name: 'priority',
);

final _fleetTruckregistrationpermitRepeatPart = LensPart<Permit, int?>(
  get: (value) => value.repeat,
  set: (value, next) => value.copyWith(repeat: next),
  name: 'repeat',
);

final _fleetTruckregistrationpermitEnabledPart = LensPart<Permit, bool?>(
  get: (value) => value.enabled,
  set: (value, next) => value.copyWith(enabled: next),
  name: 'enabled',
);

final _fleetTruckAxleCountPart = LensPart<Truck, int?>(
  get: (value) => value.axleCount,
  set: (value, next) => value.copyWith(axleCount: next),
  name: 'axleCount',
);

final _fleetTruckAsBoxTruckPart = LensPart<Truck, BoxTruck>(
  get: (value) => value as BoxTruck,
  canGet: (value) => value is BoxTruck,
  set: (value, next) => next,
  name: 'BoxTruck',
);

final _fleetTruckboxTrimPart = LensPart<BoxTruck, Trim>(
  get: (value) => value.trim,
  set: (value, next) => value.copyWith(trim: next),
  name: 'trim',
);

final _fleetTruckboxtrimLevelPart = LensPart<Trim, String?>(
  get: (value) => value.level,
  set: (value, next) => value.copyWith(level: next),
  name: 'level',
);

final _fleetTruckboxtrimLeatherPart = LensPart<Trim, bool?>(
  get: (value) => value.leather,
  set: (value, next) => value.copyWith(leather: next),
  name: 'leather',
);

final _fleetTruckboxtrimUpholsteryPart = LensPart<Trim, Upholstery>(
  get: (value) => value.upholstery,
  set: (value, next) => value.copyWith(upholstery: next),
  name: 'upholstery',
);

final _fleetTruckboxtrimupholsteryMaterialPart = LensPart<Upholstery, String?>(
  get: (value) => value.material,
  set: (value, next) => value.copyWith(material: next),
  name: 'material',
);

final _fleetTruckboxtrimupholsteryColorPart = LensPart<Upholstery, String?>(
  get: (value) => value.color,
  set: (value, next) => value.copyWith(color: next),
  name: 'color',
);

final _fleetTruckboxtrimupholsteryHeatedPart = LensPart<Upholstery, bool?>(
  get: (value) => value.heated,
  set: (value, next) => value.copyWith(heated: next),
  name: 'heated',
);

final _fleetTruckboxtrimupholsteryRowsPart = LensPart<Upholstery, List<int>>(
  get: (value) => value.rows,
  set: (value, next) => value.copyWith(rows: next),
  name: 'rows',
);

final _fleetTruckboxBoxVolumePart = LensPart<BoxTruck, double?>(
  get: (value) => value.boxVolume,
  set: (value, next) => value.copyWith(boxVolume: next),
  name: 'boxVolume',
);

final _fleetTruckAsTankerPart = LensPart<Truck, Tanker>(
  get: (value) => value as Tanker,
  canGet: (value) => value is Tanker,
  set: (value, next) => next,
  name: 'Tanker',
);

final _fleetTrucktankerCapacityPart = LensPart<Tanker, double?>(
  get: (value) => value.capacity,
  set: (value, next) => value.copyWith(capacity: next),
  name: 'capacity',
);

final _fleetTrucktankerHazmatPart = LensPart<Tanker, bool?>(
  get: (value) => value.hazmat,
  set: (value, next) => value.copyWith(hazmat: next),
  name: 'hazmat',
);

LensPart<Fleet, Bike> _fleetBikeItemPart(int index) => LensPart<Fleet, Bike>(
  get: (value) => value.bikes[index],
  set: (value, nextValue) {
    if (index < 0 || index >= value.bikes.length) return value;
    final next = List<Bike>.of(value.bikes);
    next[index] = nextValue;
    return value.copyWith(bikes: next);
  },
  canGet: (value) => index >= 0 && index < value.bikes.length,
  name: 'bike[$index]',
);

Fleet replaceBikeAt(Fleet root, int index, Bike value) {
  final list = root.bikes;
  if (index < 0 || index >= list.length) return root;
  final next = List<Bike>.of(list);
  next[index] = value;
  return root.copyWith(bikes: next);
}

Fleet updateBikeAt(Fleet root, int index, Bike Function(Bike value) update) {
  final list = root.bikes;
  if (index < 0 || index >= list.length) return root;
  final next = List<Bike>.of(list);
  next[index] = update(next[index]);
  return root.copyWith(bikes: next);
}

Fleet insertBikeAt(Fleet root, int index, Bike value) {
  final list = root.bikes;
  if (index < 0 || index > list.length) return root;
  final next = List<Bike>.of(list)..insert(index, value);
  return root.copyWith(bikes: next);
}

Fleet addBike(Fleet root, Bike value) {
  final next = List<Bike>.of(root.bikes)..add(value);
  return root.copyWith(bikes: next);
}

Fleet removeBikeAt(Fleet root, int index) {
  final list = root.bikes;
  if (index < 0 || index >= list.length) return root;
  final next = List<Bike>.of(list)..removeAt(index);
  return root.copyWith(bikes: next);
}

Fleet duplicateBikeAt(Fleet root, int index) {
  final list = root.bikes;
  if (index < 0 || index >= list.length) return root;
  final next = List<Bike>.of(list)..insert(index + 1, list[index]);
  return root.copyWith(bikes: next);
}

Fleet moveBike(Fleet root, int from, int to) {
  final list = root.bikes;
  if (from < 0 || from >= list.length) return root;
  final next = List<Bike>.of(list);
  final item = next.removeAt(from);
  next.insert(to.clamp(0, next.length), item);
  return root.copyWith(bikes: next);
}

final _fleetBikeRegistrationPart = LensPart<Bike, Registration>(
  get: (value) => value.registration,
  set: (value, next) => value.copyWith(registration: next),
  name: 'registration',
);

final _fleetBikeregistrationPlatePart = LensPart<Registration, String?>(
  get: (value) => value.plate,
  set: (value, next) => value.copyWith(plate: next),
  name: 'plate',
);

final _fleetBikeregistrationVinPart = LensPart<Registration, String?>(
  get: (value) => value.vin,
  set: (value, next) => value.copyWith(vin: next),
  name: 'vin',
);

final _fleetBikeregistrationRegionPart = LensPart<Registration, String?>(
  get: (value) => value.region,
  set: (value, next) => value.copyWith(region: next),
  name: 'region',
);

final _fleetBikeregistrationLockedPart = LensPart<Registration, bool?>(
  get: (value) => value.locked,
  set: (value, next) => value.copyWith(locked: next),
  name: 'locked',
);

final _fleetBikeregistrationTagsPart = LensPart<Registration, List<String>>(
  get: (value) => value.tags,
  set: (value, next) => value.copyWith(tags: next),
  name: 'tags',
);

final _fleetBikeregistrationNotesPart = LensPart<Registration, String?>(
  get: (value) => value.notes,
  set: (value, next) => value.copyWith(notes: next),
  name: 'notes',
);

LensPart<Registration, Permit> _fleetBikeregistrationPermitsItemPart(
  int index,
) => LensPart<Registration, Permit>(
  get: (value) => value.permits[index],
  set: (value, nextValue) {
    if (index < 0 || index >= value.permits.length) return value;
    final next = List<Permit>.of(value.permits);
    next[index] = nextValue;
    return value.copyWith(permits: next);
  },
  canGet: (value) => index >= 0 && index < value.permits.length,
  name: 'permits[$index]',
);

final _fleetBikeregistrationpermitDetailPart = LensPart<Permit, PermitDetail>(
  get: (value) => value.detail,
  set: (value, next) => value.copyWith(detail: next),
  name: 'detail',
);

final _fleetBikeregistrationpermitDetailAuthorityPart =
    LensPart<PermitDetail, String?>(
      get: (value) => value.authority,
      set: (value, next) => value.copyWith(authority: next),
      name: 'authority',
    );

final _fleetBikeregistrationpermitDetailRevokedPart =
    LensPart<PermitDetail, bool?>(
      get: (value) => value.revoked,
      set: (value, next) => value.copyWith(revoked: next),
      name: 'revoked',
    );

final _fleetBikeregistrationpermitAsParkingPermitPart =
    LensPart<PermitDetail, ParkingPermit>(
      get: (value) => value as ParkingPermit,
      canGet: (value) => value is ParkingPermit,
      set: (value, next) => next,
      name: 'ParkingPermit',
    );

final _fleetBikeregistrationpermitdetailparkingZonePart =
    LensPart<ParkingPermit, String>(
      get: (value) => value.zone,
      set: (value, next) => value.copyWith(zone: next),
      name: 'zone',
    );

final _fleetBikeregistrationpermitdetailparkingHoursPart =
    LensPart<ParkingPermit, int?>(
      get: (value) => value.hours,
      set: (value, next) => value.copyWith(hours: next),
      name: 'hours',
    );

final _fleetBikeregistrationpermitAsTollPermitPart =
    LensPart<PermitDetail, TollPermit>(
      get: (value) => value as TollPermit,
      canGet: (value) => value is TollPermit,
      set: (value, next) => next,
      name: 'TollPermit',
    );

final _fleetBikeregistrationpermitdetailtollAccountPart =
    LensPart<TollPermit, String>(
      get: (value) => value.account,
      set: (value, next) => value.copyWith(account: next),
      name: 'account',
    );

final _fleetBikeregistrationpermitdetailtollBalancePart =
    LensPart<TollPermit, double>(
      get: (value) => value.balance,
      set: (value, next) => value.copyWith(balance: next),
      name: 'balance',
    );

final _fleetBikeregistrationpermitAsAccessPermitPart =
    LensPart<PermitDetail, AccessPermit>(
      get: (value) => value as AccessPermit,
      canGet: (value) => value is AccessPermit,
      set: (value, next) => next,
      name: 'AccessPermit',
    );

LensPart<AccessPermit, Gate>
_fleetBikeregistrationpermitdetailaccessGatesItemPart(int index) =>
    LensPart<AccessPermit, Gate>(
      get: (value) => value.gates[index],
      set: (value, nextValue) {
        if (index < 0 || index >= value.gates.length) return value;
        final next = List<Gate>.of(value.gates);
        next[index] = nextValue;
        return value.copyWith(gates: next);
      },
      canGet: (value) => index >= 0 && index < value.gates.length,
      name: 'gates[$index]',
    );

final _fleetBikeregistrationpermitdetailaccessgateIdPart =
    LensPart<Gate, String>(
      get: (value) => value.id,
      set: (value, next) => value.copyWith(id: next),
      name: 'id',
    );

final _fleetBikeregistrationpermitdetailaccessgateAsManualGatePart =
    LensPart<Gate, ManualGate>(
      get: (value) => value as ManualGate,
      canGet: (value) => value is ManualGate,
      set: (value, next) => next,
      name: 'ManualGate',
    );

final _fleetBikeregistrationpermitdetailaccessgatemanualKeyPart =
    LensPart<ManualGate, String?>(
      get: (value) => value.key,
      set: (value, next) => value.copyWith(key: next),
      name: 'key',
    );

final _fleetBikeregistrationpermitdetailaccessgateAsAutoGatePart =
    LensPart<Gate, AutoGate>(
      get: (value) => value as AutoGate,
      canGet: (value) => value is AutoGate,
      set: (value, next) => next,
      name: 'AutoGate',
    );

final _fleetBikeregistrationpermitdetailaccessgateautoSensorModelPart =
    LensPart<AutoGate, String?>(
      get: (value) => value.sensorModel,
      set: (value, next) => value.copyWith(sensorModel: next),
      name: 'sensorModel',
    );

final _fleetBikeregistrationpermitdetailaccessgateautoBackupIdPart =
    LensPart<AutoGate, String?>(
      get: (value) => value.backupId,
      set: (value, next) => value.copyWith(backupId: next),
      name: 'backupId',
    );

final _fleetBikeregistrationpermitLabelPart = LensPart<Permit, String?>(
  get: (value) => value.label,
  set: (value, next) => value.copyWith(label: next),
  name: 'label',
);

final _fleetBikeregistrationpermitPriorityPart = LensPart<Permit, int?>(
  get: (value) => value.priority,
  set: (value, next) => value.copyWith(priority: next),
  name: 'priority',
);

final _fleetBikeregistrationpermitRepeatPart = LensPart<Permit, int?>(
  get: (value) => value.repeat,
  set: (value, next) => value.copyWith(repeat: next),
  name: 'repeat',
);

final _fleetBikeregistrationpermitEnabledPart = LensPart<Permit, bool?>(
  get: (value) => value.enabled,
  set: (value, next) => value.copyWith(enabled: next),
  name: 'enabled',
);

final _fleetBikeElectricPart = LensPart<Bike, bool?>(
  get: (value) => value.electric,
  set: (value, next) => value.copyWith(electric: next),
  name: 'electric',
);

final _fleetBikeAsRoadBikePart = LensPart<Bike, RoadBike>(
  get: (value) => value as RoadBike,
  canGet: (value) => value is RoadBike,
  set: (value, next) => next,
  name: 'RoadBike',
);

final _fleetBikeroadGearsPart = LensPart<RoadBike, int?>(
  get: (value) => value.gears,
  set: (value, next) => value.copyWith(gears: next),
  name: 'gears',
);

final _fleetBikeAsCargoBikePart = LensPart<Bike, CargoBike>(
  get: (value) => value as CargoBike,
  canGet: (value) => value is CargoBike,
  set: (value, next) => next,
  name: 'CargoBike',
);

final _fleetBikecargoBasketsPart = LensPart<CargoBike, int?>(
  get: (value) => value.baskets,
  set: (value, next) => value.copyWith(baskets: next),
  name: 'baskets',
);

final _fleetBikecargoAssistPart = LensPart<CargoBike, bool?>(
  get: (value) => value.assist,
  set: (value, next) => value.copyWith(assist: next),
  name: 'assist',
);

LensPart<Fleet, Policy> _fleetPoliciesItemPart(int index) =>
    LensPart<Fleet, Policy>(
      get: (value) => value.policies[index],
      set: (value, nextValue) {
        if (index < 0 || index >= value.policies.length) return value;
        final next = List<Policy>.of(value.policies);
        next[index] = nextValue;
        return value.copyWith(policies: next);
      },
      canGet: (value) => index >= 0 && index < value.policies.length,
      name: 'policies[$index]',
    );

Fleet replacePolicyAt(Fleet root, int index, Policy value) {
  final list = root.policies;
  if (index < 0 || index >= list.length) return root;
  final next = List<Policy>.of(list);
  next[index] = value;
  return root.copyWith(policies: next);
}

Fleet updatePolicyAt(
  Fleet root,
  int index,
  Policy Function(Policy value) update,
) {
  final list = root.policies;
  if (index < 0 || index >= list.length) return root;
  final next = List<Policy>.of(list);
  next[index] = update(next[index]);
  return root.copyWith(policies: next);
}

Fleet insertPolicyAt(Fleet root, int index, Policy value) {
  final list = root.policies;
  if (index < 0 || index > list.length) return root;
  final next = List<Policy>.of(list)..insert(index, value);
  return root.copyWith(policies: next);
}

Fleet addPolicy(Fleet root, Policy value) {
  final next = List<Policy>.of(root.policies)..add(value);
  return root.copyWith(policies: next);
}

Fleet removePolicyAt(Fleet root, int index) {
  final list = root.policies;
  if (index < 0 || index >= list.length) return root;
  final next = List<Policy>.of(list)..removeAt(index);
  return root.copyWith(policies: next);
}

Fleet duplicatePolicyAt(Fleet root, int index) {
  final list = root.policies;
  if (index < 0 || index >= list.length) return root;
  final next = List<Policy>.of(list)..insert(index + 1, list[index]);
  return root.copyWith(policies: next);
}

Fleet movePolicy(Fleet root, int from, int to) {
  final list = root.policies;
  if (from < 0 || from >= list.length) return root;
  final next = List<Policy>.of(list);
  final item = next.removeAt(from);
  next.insert(to.clamp(0, next.length), item);
  return root.copyWith(policies: next);
}

final _fleetPolicyConditionsPart = LensPart<Policy, PolicyCondition?>(
  get: (value) => value.conditions,
  set: (value, next) => value.copyWith(conditions: next),
  name: 'conditions',
);

final _fleetPolicyLimitsPart = LensPart<Policy, PolicyLimits>(
  get: (value) => value.limits,
  set: (value, next) => value.copyWith(limits: next),
  name: 'limits',
);

final _fleetPolicylimitsMaxSpeedPart = LensPart<PolicyLimits, int?>(
  get: (value) => value.maxSpeed,
  set: (value, next) => value.copyWith(maxSpeed: next),
  name: 'maxSpeed',
);

final _fleetPolicylimitsMaxLoadPart = LensPart<PolicyLimits, double?>(
  get: (value) => value.maxLoad,
  set: (value, next) => value.copyWith(maxLoad: next),
  name: 'maxLoad',
);

final _fleetPolicylimitsEscortPart = LensPart<PolicyLimits, bool?>(
  get: (value) => value.escort,
  set: (value, next) => value.copyWith(escort: next),
  name: 'escort',
);

final _fleetPolicylimitsCurfewPart = LensPart<PolicyLimits, int?>(
  get: (value) => value.curfew,
  set: (value, next) => value.copyWith(curfew: next),
  name: 'curfew',
);

final _fleetPolicylimitsInspectionDaysPart = LensPart<PolicyLimits, int?>(
  get: (value) => value.inspectionDays,
  set: (value, next) => value.copyWith(inspectionDays: next),
  name: 'inspectionDays',
);

Lens<DepotSettings> depotSettingsLens(VehicleCategory category) =>
    Lens<DepotSettings>(
      get: (root) {
        final container = root as Fleet;
        return switch (category) {
          VehicleCategory.car => container.carDepot ?? const DepotSettings(),
          VehicleCategory.truck =>
            container.truckDepot ?? const DepotSettings(),
          VehicleCategory.bike => container.bikeDepot ?? const DepotSettings(),
          _ => const DepotSettings(),
        };
      },
      set: (root, next) {
        final container = root as Fleet;
        return switch (category) {
          VehicleCategory.car =>
            next.isEmpty
                ? container.copyWith(carDepot: null)
                : container.copyWith(carDepot: next),
          VehicleCategory.truck =>
            next.isEmpty
                ? container.copyWith(truckDepot: null)
                : container.copyWith(truckDepot: next),
          VehicleCategory.bike =>
            next.isEmpty
                ? container.copyWith(bikeDepot: null)
                : container.copyWith(bikeDepot: next),
          _ => container,
        };
      },
      name: 'depot[${category.name}]',
    );

final _fleetDepotCapacityPart = LensPart<DepotSettings, int?>(
  get: (value) => value.capacity,
  set: (value, next) => value.copyWith(capacity: next),
  name: 'capacity',
);

final _fleetDepotBaysPart = LensPart<DepotSettings, int?>(
  get: (value) => value.bays,
  set: (value, next) => value.copyWith(bays: next),
  name: 'bays',
);

final _fleetDepotNightShiftPart = LensPart<DepotSettings, bool?>(
  get: (value) => value.nightShift,
  set: (value, next) => value.copyWith(nightShift: next),
  name: 'nightShift',
);

final _fleetDepotNotesPart = LensPart<DepotSettings, String?>(
  get: (value) => value.notes,
  set: (value, next) => value.copyWith(notes: next),
  name: 'notes',
);

Lens<bool?> settingsAutoSyncLens() =>
    _fleetRootLens().then(_fleetSettingsPart).then(_fleetSettingsAutoSyncPart);

Lens<bool?> settingsAlertsLens() =>
    _fleetRootLens().then(_fleetSettingsPart).then(_fleetSettingsAlertsPart);

Lens<String?> settingsRegionLens() =>
    _fleetRootLens().then(_fleetSettingsPart).then(_fleetSettingsRegionPart);

Lens<List<String>?> settingsEmergencyContactsLens() => _fleetRootLens()
    .then(_fleetSettingsPart)
    .then(_fleetSettingsEmergencyContactsPart);

Lens<bool?> settingsNotificationsEmailLens() => _fleetRootLens()
    .then(_fleetSettingsPart)
    .then(_fleetSettingsNotificationsPart)
    .then(_fleetSettingsnotificationsEmailPart);

Lens<bool?> settingsNotificationsSmsLens() => _fleetRootLens()
    .then(_fleetSettingsPart)
    .then(_fleetSettingsNotificationsPart)
    .then(_fleetSettingsnotificationsSmsPart);

Lens<String?> settingsNotificationsWebhookUrlLens() => _fleetRootLens()
    .then(_fleetSettingsPart)
    .then(_fleetSettingsNotificationsPart)
    .then(_fleetSettingsnotificationsWebhookUrlPart);

Lens<String?> carRegistrationPlateLens(CarLocation location) => _fleetRootLens()
    .then(_fleetCarItemPart(location.carIndex))
    .then(_fleetCarRegistrationPart)
    .then(_fleetCarregistrationPlatePart);

Lens<String?> carRegistrationVinLens(CarLocation location) => _fleetRootLens()
    .then(_fleetCarItemPart(location.carIndex))
    .then(_fleetCarRegistrationPart)
    .then(_fleetCarregistrationVinPart);

Lens<String?> carRegistrationRegionLens(CarLocation location) =>
    _fleetRootLens()
        .then(_fleetCarItemPart(location.carIndex))
        .then(_fleetCarRegistrationPart)
        .then(_fleetCarregistrationRegionPart);

Lens<bool?> carRegistrationLockedLens(CarLocation location) => _fleetRootLens()
    .then(_fleetCarItemPart(location.carIndex))
    .then(_fleetCarRegistrationPart)
    .then(_fleetCarregistrationLockedPart);

Lens<List<String>> carRegistrationTagsLens(CarLocation location) =>
    _fleetRootLens()
        .then(_fleetCarItemPart(location.carIndex))
        .then(_fleetCarRegistrationPart)
        .then(_fleetCarregistrationTagsPart);

Lens<String?> carRegistrationNotesLens(CarLocation location) => _fleetRootLens()
    .then(_fleetCarItemPart(location.carIndex))
    .then(_fleetCarRegistrationPart)
    .then(_fleetCarregistrationNotesPart);

Lens<String?> carRegistrationPermitDetailAuthorityLens(
  CarPermitLocation location,
) => _fleetRootLens()
    .then(_fleetCarItemPart(location.carIndex))
    .then(_fleetCarRegistrationPart)
    .then(_fleetCarregistrationPermitsItemPart(location.permitIndex))
    .then(_fleetCarregistrationpermitDetailPart)
    .then(_fleetCarregistrationpermitDetailAuthorityPart);

Lens<bool?> carRegistrationPermitDetailRevokedLens(
  CarPermitLocation location,
) => _fleetRootLens()
    .then(_fleetCarItemPart(location.carIndex))
    .then(_fleetCarRegistrationPart)
    .then(_fleetCarregistrationPermitsItemPart(location.permitIndex))
    .then(_fleetCarregistrationpermitDetailPart)
    .then(_fleetCarregistrationpermitDetailRevokedPart);

Lens<String> carRegistrationPermitDetailParkingZoneLens(
  CarPermitLocation location,
) => _fleetRootLens()
    .then(_fleetCarItemPart(location.carIndex))
    .then(_fleetCarRegistrationPart)
    .then(_fleetCarregistrationPermitsItemPart(location.permitIndex))
    .then(_fleetCarregistrationpermitDetailPart)
    .then(_fleetCarregistrationpermitAsParkingPermitPart)
    .then(_fleetCarregistrationpermitdetailparkingZonePart);

Lens<int?> carRegistrationPermitDetailParkingHoursLens(
  CarPermitLocation location,
) => _fleetRootLens()
    .then(_fleetCarItemPart(location.carIndex))
    .then(_fleetCarRegistrationPart)
    .then(_fleetCarregistrationPermitsItemPart(location.permitIndex))
    .then(_fleetCarregistrationpermitDetailPart)
    .then(_fleetCarregistrationpermitAsParkingPermitPart)
    .then(_fleetCarregistrationpermitdetailparkingHoursPart);

Lens<String> carRegistrationPermitDetailTollAccountLens(
  CarPermitLocation location,
) => _fleetRootLens()
    .then(_fleetCarItemPart(location.carIndex))
    .then(_fleetCarRegistrationPart)
    .then(_fleetCarregistrationPermitsItemPart(location.permitIndex))
    .then(_fleetCarregistrationpermitDetailPart)
    .then(_fleetCarregistrationpermitAsTollPermitPart)
    .then(_fleetCarregistrationpermitdetailtollAccountPart);

Lens<double> carRegistrationPermitDetailTollBalanceLens(
  CarPermitLocation location,
) => _fleetRootLens()
    .then(_fleetCarItemPart(location.carIndex))
    .then(_fleetCarRegistrationPart)
    .then(_fleetCarregistrationPermitsItemPart(location.permitIndex))
    .then(_fleetCarregistrationpermitDetailPart)
    .then(_fleetCarregistrationpermitAsTollPermitPart)
    .then(_fleetCarregistrationpermitdetailtollBalancePart);

Lens<String> carRegistrationPermitDetailAccessGateIdLens(
  CarPermitGateLocation location,
) => _fleetRootLens()
    .then(_fleetCarItemPart(location.carIndex))
    .then(_fleetCarRegistrationPart)
    .then(_fleetCarregistrationPermitsItemPart(location.permitIndex))
    .then(_fleetCarregistrationpermitDetailPart)
    .then(_fleetCarregistrationpermitAsAccessPermitPart)
    .then(
      _fleetCarregistrationpermitdetailaccessGatesItemPart(location.gateIndex),
    )
    .then(_fleetCarregistrationpermitdetailaccessgateIdPart);

Lens<String?> carRegistrationPermitDetailAccessGateManualKeyLens(
  CarPermitGateLocation location,
) => _fleetRootLens()
    .then(_fleetCarItemPart(location.carIndex))
    .then(_fleetCarRegistrationPart)
    .then(_fleetCarregistrationPermitsItemPart(location.permitIndex))
    .then(_fleetCarregistrationpermitDetailPart)
    .then(_fleetCarregistrationpermitAsAccessPermitPart)
    .then(
      _fleetCarregistrationpermitdetailaccessGatesItemPart(location.gateIndex),
    )
    .then(_fleetCarregistrationpermitdetailaccessgateAsManualGatePart)
    .then(_fleetCarregistrationpermitdetailaccessgatemanualKeyPart);

Lens<String?> carRegistrationPermitDetailAccessGateAutoSensorModelLens(
  CarPermitGateLocation location,
) => _fleetRootLens()
    .then(_fleetCarItemPart(location.carIndex))
    .then(_fleetCarRegistrationPart)
    .then(_fleetCarregistrationPermitsItemPart(location.permitIndex))
    .then(_fleetCarregistrationpermitDetailPart)
    .then(_fleetCarregistrationpermitAsAccessPermitPart)
    .then(
      _fleetCarregistrationpermitdetailaccessGatesItemPart(location.gateIndex),
    )
    .then(_fleetCarregistrationpermitdetailaccessgateAsAutoGatePart)
    .then(_fleetCarregistrationpermitdetailaccessgateautoSensorModelPart);

Lens<String?> carRegistrationPermitDetailAccessGateAutoBackupIdLens(
  CarPermitGateLocation location,
) => _fleetRootLens()
    .then(_fleetCarItemPart(location.carIndex))
    .then(_fleetCarRegistrationPart)
    .then(_fleetCarregistrationPermitsItemPart(location.permitIndex))
    .then(_fleetCarregistrationpermitDetailPart)
    .then(_fleetCarregistrationpermitAsAccessPermitPart)
    .then(
      _fleetCarregistrationpermitdetailaccessGatesItemPart(location.gateIndex),
    )
    .then(_fleetCarregistrationpermitdetailaccessgateAsAutoGatePart)
    .then(_fleetCarregistrationpermitdetailaccessgateautoBackupIdPart);

Lens<String?> carRegistrationPermitLabelLens(CarPermitLocation location) =>
    _fleetRootLens()
        .then(_fleetCarItemPart(location.carIndex))
        .then(_fleetCarRegistrationPart)
        .then(_fleetCarregistrationPermitsItemPart(location.permitIndex))
        .then(_fleetCarregistrationpermitLabelPart);

Lens<int?> carRegistrationPermitPriorityLens(CarPermitLocation location) =>
    _fleetRootLens()
        .then(_fleetCarItemPart(location.carIndex))
        .then(_fleetCarRegistrationPart)
        .then(_fleetCarregistrationPermitsItemPart(location.permitIndex))
        .then(_fleetCarregistrationpermitPriorityPart);

Lens<int?> carRegistrationPermitRepeatLens(CarPermitLocation location) =>
    _fleetRootLens()
        .then(_fleetCarItemPart(location.carIndex))
        .then(_fleetCarRegistrationPart)
        .then(_fleetCarregistrationPermitsItemPart(location.permitIndex))
        .then(_fleetCarregistrationpermitRepeatPart);

Lens<bool?> carRegistrationPermitEnabledLens(CarPermitLocation location) =>
    _fleetRootLens()
        .then(_fleetCarItemPart(location.carIndex))
        .then(_fleetCarRegistrationPart)
        .then(_fleetCarregistrationPermitsItemPart(location.permitIndex))
        .then(_fleetCarregistrationpermitEnabledPart);

Lens<String> carColorLens(CarLocation location) => _fleetRootLens()
    .then(_fleetCarItemPart(location.carIndex))
    .then(_fleetCarColorPart);

Lens<int?> carYearLens(CarLocation location) => _fleetRootLens()
    .then(_fleetCarItemPart(location.carIndex))
    .then(_fleetCarYearPart);

Lens<String?> carSedanTrimLevelLens(CarLocation location) => _fleetRootLens()
    .then(_fleetCarItemPart(location.carIndex))
    .then(_fleetCarAsSedanPart)
    .then(_fleetCarsedanTrimPart)
    .then(_fleetCarsedantrimLevelPart);

Lens<bool?> carSedanTrimLeatherLens(CarLocation location) => _fleetRootLens()
    .then(_fleetCarItemPart(location.carIndex))
    .then(_fleetCarAsSedanPart)
    .then(_fleetCarsedanTrimPart)
    .then(_fleetCarsedantrimLeatherPart);

Lens<String?> carSedanTrimUpholsteryMaterialLens(CarLocation location) =>
    _fleetRootLens()
        .then(_fleetCarItemPart(location.carIndex))
        .then(_fleetCarAsSedanPart)
        .then(_fleetCarsedanTrimPart)
        .then(_fleetCarsedantrimUpholsteryPart)
        .then(_fleetCarsedantrimupholsteryMaterialPart);

Lens<String?> carSedanTrimUpholsteryColorLens(CarLocation location) =>
    _fleetRootLens()
        .then(_fleetCarItemPart(location.carIndex))
        .then(_fleetCarAsSedanPart)
        .then(_fleetCarsedanTrimPart)
        .then(_fleetCarsedantrimUpholsteryPart)
        .then(_fleetCarsedantrimupholsteryColorPart);

Lens<bool?> carSedanTrimUpholsteryHeatedLens(CarLocation location) =>
    _fleetRootLens()
        .then(_fleetCarItemPart(location.carIndex))
        .then(_fleetCarAsSedanPart)
        .then(_fleetCarsedanTrimPart)
        .then(_fleetCarsedantrimUpholsteryPart)
        .then(_fleetCarsedantrimupholsteryHeatedPart);

Lens<List<int>> carSedanTrimUpholsteryRowsLens(CarLocation location) =>
    _fleetRootLens()
        .then(_fleetCarItemPart(location.carIndex))
        .then(_fleetCarAsSedanPart)
        .then(_fleetCarsedanTrimPart)
        .then(_fleetCarsedantrimUpholsteryPart)
        .then(_fleetCarsedantrimupholsteryRowsPart);

Lens<String?> carCoupeTrimLevelLens(CarLocation location) => _fleetRootLens()
    .then(_fleetCarItemPart(location.carIndex))
    .then(_fleetCarAsCoupePart)
    .then(_fleetCarcoupeTrimPart)
    .then(_fleetCarcoupetrimLevelPart);

Lens<bool?> carCoupeTrimLeatherLens(CarLocation location) => _fleetRootLens()
    .then(_fleetCarItemPart(location.carIndex))
    .then(_fleetCarAsCoupePart)
    .then(_fleetCarcoupeTrimPart)
    .then(_fleetCarcoupetrimLeatherPart);

Lens<String?> carCoupeTrimUpholsteryMaterialLens(CarLocation location) =>
    _fleetRootLens()
        .then(_fleetCarItemPart(location.carIndex))
        .then(_fleetCarAsCoupePart)
        .then(_fleetCarcoupeTrimPart)
        .then(_fleetCarcoupetrimUpholsteryPart)
        .then(_fleetCarcoupetrimupholsteryMaterialPart);

Lens<String?> carCoupeTrimUpholsteryColorLens(CarLocation location) =>
    _fleetRootLens()
        .then(_fleetCarItemPart(location.carIndex))
        .then(_fleetCarAsCoupePart)
        .then(_fleetCarcoupeTrimPart)
        .then(_fleetCarcoupetrimUpholsteryPart)
        .then(_fleetCarcoupetrimupholsteryColorPart);

Lens<bool?> carCoupeTrimUpholsteryHeatedLens(CarLocation location) =>
    _fleetRootLens()
        .then(_fleetCarItemPart(location.carIndex))
        .then(_fleetCarAsCoupePart)
        .then(_fleetCarcoupeTrimPart)
        .then(_fleetCarcoupetrimUpholsteryPart)
        .then(_fleetCarcoupetrimupholsteryHeatedPart);

Lens<List<int>> carCoupeTrimUpholsteryRowsLens(CarLocation location) =>
    _fleetRootLens()
        .then(_fleetCarItemPart(location.carIndex))
        .then(_fleetCarAsCoupePart)
        .then(_fleetCarcoupeTrimPart)
        .then(_fleetCarcoupetrimUpholsteryPart)
        .then(_fleetCarcoupetrimupholsteryRowsPart);

Lens<String?> carCoupeDrivetrainLabelLens(CarLocation location) =>
    _fleetRootLens()
        .then(_fleetCarItemPart(location.carIndex))
        .then(_fleetCarAsCoupePart)
        .then(_fleetCarcoupeDrivetrainPart)
        .then(_fleetCarcoupedrivetrainLabelPart);

Lens<String> carCoupeDrivetrainFixedAxleLens(CarLocation location) =>
    _fleetRootLens()
        .then(_fleetCarItemPart(location.carIndex))
        .then(_fleetCarAsCoupePart)
        .then(_fleetCarcoupeDrivetrainPart)
        .then(_fleetCarcoupedrivetrainAsFixedDrivePart)
        .then(_fleetCarcoupedrivetrainfixedAxlePart);

Lens<double> carCoupeDrivetrainRangeMinRatioLens(CarLocation location) =>
    _fleetRootLens()
        .then(_fleetCarItemPart(location.carIndex))
        .then(_fleetCarAsCoupePart)
        .then(_fleetCarcoupeDrivetrainPart)
        .then(_fleetCarcoupedrivetrainAsRangeDrivePart)
        .then(_fleetCarcoupedrivetrainrangeMinRatioPart);

Lens<double> carCoupeDrivetrainRangeMaxRatioLens(CarLocation location) =>
    _fleetRootLens()
        .then(_fleetCarItemPart(location.carIndex))
        .then(_fleetCarAsCoupePart)
        .then(_fleetCarcoupeDrivetrainPart)
        .then(_fleetCarcoupedrivetrainAsRangeDrivePart)
        .then(_fleetCarcoupedrivetrainrangeMaxRatioPart);

Lens<bool> carCoupeDrivetrainRangeLockingLens(CarLocation location) =>
    _fleetRootLens()
        .then(_fleetCarItemPart(location.carIndex))
        .then(_fleetCarAsCoupePart)
        .then(_fleetCarcoupeDrivetrainPart)
        .then(_fleetCarcoupedrivetrainAsRangeDrivePart)
        .then(_fleetCarcoupedrivetrainrangeLockingPart);

Lens<int?> carCoupeTopSpeedLens(CarLocation location) => _fleetRootLens()
    .then(_fleetCarItemPart(location.carIndex))
    .then(_fleetCarAsCoupePart)
    .then(_fleetCarcoupeTopSpeedPart);

Lens<String?> carConvertibleTrimLevelLens(CarLocation location) =>
    _fleetRootLens()
        .then(_fleetCarItemPart(location.carIndex))
        .then(_fleetCarAsConvertiblePart)
        .then(_fleetCarconvertibleTrimPart)
        .then(_fleetCarconvertibletrimLevelPart);

Lens<bool?> carConvertibleTrimLeatherLens(CarLocation location) =>
    _fleetRootLens()
        .then(_fleetCarItemPart(location.carIndex))
        .then(_fleetCarAsConvertiblePart)
        .then(_fleetCarconvertibleTrimPart)
        .then(_fleetCarconvertibletrimLeatherPart);

Lens<String?> carConvertibleTrimUpholsteryMaterialLens(CarLocation location) =>
    _fleetRootLens()
        .then(_fleetCarItemPart(location.carIndex))
        .then(_fleetCarAsConvertiblePart)
        .then(_fleetCarconvertibleTrimPart)
        .then(_fleetCarconvertibletrimUpholsteryPart)
        .then(_fleetCarconvertibletrimupholsteryMaterialPart);

Lens<String?> carConvertibleTrimUpholsteryColorLens(CarLocation location) =>
    _fleetRootLens()
        .then(_fleetCarItemPart(location.carIndex))
        .then(_fleetCarAsConvertiblePart)
        .then(_fleetCarconvertibleTrimPart)
        .then(_fleetCarconvertibletrimUpholsteryPart)
        .then(_fleetCarconvertibletrimupholsteryColorPart);

Lens<bool?> carConvertibleTrimUpholsteryHeatedLens(CarLocation location) =>
    _fleetRootLens()
        .then(_fleetCarItemPart(location.carIndex))
        .then(_fleetCarAsConvertiblePart)
        .then(_fleetCarconvertibleTrimPart)
        .then(_fleetCarconvertibletrimUpholsteryPart)
        .then(_fleetCarconvertibletrimupholsteryHeatedPart);

Lens<List<int>> carConvertibleTrimUpholsteryRowsLens(CarLocation location) =>
    _fleetRootLens()
        .then(_fleetCarItemPart(location.carIndex))
        .then(_fleetCarAsConvertiblePart)
        .then(_fleetCarconvertibleTrimPart)
        .then(_fleetCarconvertibletrimUpholsteryPart)
        .then(_fleetCarconvertibletrimupholsteryRowsPart);

Lens<bool?> carConvertibleRoofOpenLens(CarLocation location) => _fleetRootLens()
    .then(_fleetCarItemPart(location.carIndex))
    .then(_fleetCarAsConvertiblePart)
    .then(_fleetCarconvertibleRoofOpenPart);

Lens<String?> truckRegistrationPlateLens(TruckLocation location) =>
    _fleetRootLens()
        .then(_fleetTruckItemPart(location.truckIndex))
        .then(_fleetTruckRegistrationPart)
        .then(_fleetTruckregistrationPlatePart);

Lens<String?> truckRegistrationVinLens(TruckLocation location) =>
    _fleetRootLens()
        .then(_fleetTruckItemPart(location.truckIndex))
        .then(_fleetTruckRegistrationPart)
        .then(_fleetTruckregistrationVinPart);

Lens<String?> truckRegistrationRegionLens(TruckLocation location) =>
    _fleetRootLens()
        .then(_fleetTruckItemPart(location.truckIndex))
        .then(_fleetTruckRegistrationPart)
        .then(_fleetTruckregistrationRegionPart);

Lens<bool?> truckRegistrationLockedLens(TruckLocation location) =>
    _fleetRootLens()
        .then(_fleetTruckItemPart(location.truckIndex))
        .then(_fleetTruckRegistrationPart)
        .then(_fleetTruckregistrationLockedPart);

Lens<List<String>> truckRegistrationTagsLens(TruckLocation location) =>
    _fleetRootLens()
        .then(_fleetTruckItemPart(location.truckIndex))
        .then(_fleetTruckRegistrationPart)
        .then(_fleetTruckregistrationTagsPart);

Lens<String?> truckRegistrationNotesLens(TruckLocation location) =>
    _fleetRootLens()
        .then(_fleetTruckItemPart(location.truckIndex))
        .then(_fleetTruckRegistrationPart)
        .then(_fleetTruckregistrationNotesPart);

Lens<String?> truckRegistrationPermitDetailAuthorityLens(
  TruckPermitLocation location,
) => _fleetRootLens()
    .then(_fleetTruckItemPart(location.truckIndex))
    .then(_fleetTruckRegistrationPart)
    .then(_fleetTruckregistrationPermitsItemPart(location.permitIndex))
    .then(_fleetTruckregistrationpermitDetailPart)
    .then(_fleetTruckregistrationpermitDetailAuthorityPart);

Lens<bool?> truckRegistrationPermitDetailRevokedLens(
  TruckPermitLocation location,
) => _fleetRootLens()
    .then(_fleetTruckItemPart(location.truckIndex))
    .then(_fleetTruckRegistrationPart)
    .then(_fleetTruckregistrationPermitsItemPart(location.permitIndex))
    .then(_fleetTruckregistrationpermitDetailPart)
    .then(_fleetTruckregistrationpermitDetailRevokedPart);

Lens<String> truckRegistrationPermitDetailParkingZoneLens(
  TruckPermitLocation location,
) => _fleetRootLens()
    .then(_fleetTruckItemPart(location.truckIndex))
    .then(_fleetTruckRegistrationPart)
    .then(_fleetTruckregistrationPermitsItemPart(location.permitIndex))
    .then(_fleetTruckregistrationpermitDetailPart)
    .then(_fleetTruckregistrationpermitAsParkingPermitPart)
    .then(_fleetTruckregistrationpermitdetailparkingZonePart);

Lens<int?> truckRegistrationPermitDetailParkingHoursLens(
  TruckPermitLocation location,
) => _fleetRootLens()
    .then(_fleetTruckItemPart(location.truckIndex))
    .then(_fleetTruckRegistrationPart)
    .then(_fleetTruckregistrationPermitsItemPart(location.permitIndex))
    .then(_fleetTruckregistrationpermitDetailPart)
    .then(_fleetTruckregistrationpermitAsParkingPermitPart)
    .then(_fleetTruckregistrationpermitdetailparkingHoursPart);

Lens<String> truckRegistrationPermitDetailTollAccountLens(
  TruckPermitLocation location,
) => _fleetRootLens()
    .then(_fleetTruckItemPart(location.truckIndex))
    .then(_fleetTruckRegistrationPart)
    .then(_fleetTruckregistrationPermitsItemPart(location.permitIndex))
    .then(_fleetTruckregistrationpermitDetailPart)
    .then(_fleetTruckregistrationpermitAsTollPermitPart)
    .then(_fleetTruckregistrationpermitdetailtollAccountPart);

Lens<double> truckRegistrationPermitDetailTollBalanceLens(
  TruckPermitLocation location,
) => _fleetRootLens()
    .then(_fleetTruckItemPart(location.truckIndex))
    .then(_fleetTruckRegistrationPart)
    .then(_fleetTruckregistrationPermitsItemPart(location.permitIndex))
    .then(_fleetTruckregistrationpermitDetailPart)
    .then(_fleetTruckregistrationpermitAsTollPermitPart)
    .then(_fleetTruckregistrationpermitdetailtollBalancePart);

Lens<String> truckRegistrationPermitDetailAccessGateIdLens(
  TruckPermitGateLocation location,
) => _fleetRootLens()
    .then(_fleetTruckItemPart(location.truckIndex))
    .then(_fleetTruckRegistrationPart)
    .then(_fleetTruckregistrationPermitsItemPart(location.permitIndex))
    .then(_fleetTruckregistrationpermitDetailPart)
    .then(_fleetTruckregistrationpermitAsAccessPermitPart)
    .then(
      _fleetTruckregistrationpermitdetailaccessGatesItemPart(
        location.gateIndex,
      ),
    )
    .then(_fleetTruckregistrationpermitdetailaccessgateIdPart);

Lens<String?> truckRegistrationPermitDetailAccessGateManualKeyLens(
  TruckPermitGateLocation location,
) => _fleetRootLens()
    .then(_fleetTruckItemPart(location.truckIndex))
    .then(_fleetTruckRegistrationPart)
    .then(_fleetTruckregistrationPermitsItemPart(location.permitIndex))
    .then(_fleetTruckregistrationpermitDetailPart)
    .then(_fleetTruckregistrationpermitAsAccessPermitPart)
    .then(
      _fleetTruckregistrationpermitdetailaccessGatesItemPart(
        location.gateIndex,
      ),
    )
    .then(_fleetTruckregistrationpermitdetailaccessgateAsManualGatePart)
    .then(_fleetTruckregistrationpermitdetailaccessgatemanualKeyPart);

Lens<String?> truckRegistrationPermitDetailAccessGateAutoSensorModelLens(
  TruckPermitGateLocation location,
) => _fleetRootLens()
    .then(_fleetTruckItemPart(location.truckIndex))
    .then(_fleetTruckRegistrationPart)
    .then(_fleetTruckregistrationPermitsItemPart(location.permitIndex))
    .then(_fleetTruckregistrationpermitDetailPart)
    .then(_fleetTruckregistrationpermitAsAccessPermitPart)
    .then(
      _fleetTruckregistrationpermitdetailaccessGatesItemPart(
        location.gateIndex,
      ),
    )
    .then(_fleetTruckregistrationpermitdetailaccessgateAsAutoGatePart)
    .then(_fleetTruckregistrationpermitdetailaccessgateautoSensorModelPart);

Lens<String?> truckRegistrationPermitDetailAccessGateAutoBackupIdLens(
  TruckPermitGateLocation location,
) => _fleetRootLens()
    .then(_fleetTruckItemPart(location.truckIndex))
    .then(_fleetTruckRegistrationPart)
    .then(_fleetTruckregistrationPermitsItemPart(location.permitIndex))
    .then(_fleetTruckregistrationpermitDetailPart)
    .then(_fleetTruckregistrationpermitAsAccessPermitPart)
    .then(
      _fleetTruckregistrationpermitdetailaccessGatesItemPart(
        location.gateIndex,
      ),
    )
    .then(_fleetTruckregistrationpermitdetailaccessgateAsAutoGatePart)
    .then(_fleetTruckregistrationpermitdetailaccessgateautoBackupIdPart);

Lens<String?> truckRegistrationPermitLabelLens(TruckPermitLocation location) =>
    _fleetRootLens()
        .then(_fleetTruckItemPart(location.truckIndex))
        .then(_fleetTruckRegistrationPart)
        .then(_fleetTruckregistrationPermitsItemPart(location.permitIndex))
        .then(_fleetTruckregistrationpermitLabelPart);

Lens<int?> truckRegistrationPermitPriorityLens(TruckPermitLocation location) =>
    _fleetRootLens()
        .then(_fleetTruckItemPart(location.truckIndex))
        .then(_fleetTruckRegistrationPart)
        .then(_fleetTruckregistrationPermitsItemPart(location.permitIndex))
        .then(_fleetTruckregistrationpermitPriorityPart);

Lens<int?> truckRegistrationPermitRepeatLens(TruckPermitLocation location) =>
    _fleetRootLens()
        .then(_fleetTruckItemPart(location.truckIndex))
        .then(_fleetTruckRegistrationPart)
        .then(_fleetTruckregistrationPermitsItemPart(location.permitIndex))
        .then(_fleetTruckregistrationpermitRepeatPart);

Lens<bool?> truckRegistrationPermitEnabledLens(TruckPermitLocation location) =>
    _fleetRootLens()
        .then(_fleetTruckItemPart(location.truckIndex))
        .then(_fleetTruckRegistrationPart)
        .then(_fleetTruckregistrationPermitsItemPart(location.permitIndex))
        .then(_fleetTruckregistrationpermitEnabledPart);

Lens<int?> truckAxleCountLens(TruckLocation location) => _fleetRootLens()
    .then(_fleetTruckItemPart(location.truckIndex))
    .then(_fleetTruckAxleCountPart);

Lens<String?> truckBoxTrimLevelLens(TruckLocation location) => _fleetRootLens()
    .then(_fleetTruckItemPart(location.truckIndex))
    .then(_fleetTruckAsBoxTruckPart)
    .then(_fleetTruckboxTrimPart)
    .then(_fleetTruckboxtrimLevelPart);

Lens<bool?> truckBoxTrimLeatherLens(TruckLocation location) => _fleetRootLens()
    .then(_fleetTruckItemPart(location.truckIndex))
    .then(_fleetTruckAsBoxTruckPart)
    .then(_fleetTruckboxTrimPart)
    .then(_fleetTruckboxtrimLeatherPart);

Lens<String?> truckBoxTrimUpholsteryMaterialLens(TruckLocation location) =>
    _fleetRootLens()
        .then(_fleetTruckItemPart(location.truckIndex))
        .then(_fleetTruckAsBoxTruckPart)
        .then(_fleetTruckboxTrimPart)
        .then(_fleetTruckboxtrimUpholsteryPart)
        .then(_fleetTruckboxtrimupholsteryMaterialPart);

Lens<String?> truckBoxTrimUpholsteryColorLens(TruckLocation location) =>
    _fleetRootLens()
        .then(_fleetTruckItemPart(location.truckIndex))
        .then(_fleetTruckAsBoxTruckPart)
        .then(_fleetTruckboxTrimPart)
        .then(_fleetTruckboxtrimUpholsteryPart)
        .then(_fleetTruckboxtrimupholsteryColorPart);

Lens<bool?> truckBoxTrimUpholsteryHeatedLens(TruckLocation location) =>
    _fleetRootLens()
        .then(_fleetTruckItemPart(location.truckIndex))
        .then(_fleetTruckAsBoxTruckPart)
        .then(_fleetTruckboxTrimPart)
        .then(_fleetTruckboxtrimUpholsteryPart)
        .then(_fleetTruckboxtrimupholsteryHeatedPart);

Lens<List<int>> truckBoxTrimUpholsteryRowsLens(TruckLocation location) =>
    _fleetRootLens()
        .then(_fleetTruckItemPart(location.truckIndex))
        .then(_fleetTruckAsBoxTruckPart)
        .then(_fleetTruckboxTrimPart)
        .then(_fleetTruckboxtrimUpholsteryPart)
        .then(_fleetTruckboxtrimupholsteryRowsPart);

Lens<double?> truckBoxBoxVolumeLens(TruckLocation location) => _fleetRootLens()
    .then(_fleetTruckItemPart(location.truckIndex))
    .then(_fleetTruckAsBoxTruckPart)
    .then(_fleetTruckboxBoxVolumePart);

Lens<double?> truckTankerCapacityLens(TruckLocation location) =>
    _fleetRootLens()
        .then(_fleetTruckItemPart(location.truckIndex))
        .then(_fleetTruckAsTankerPart)
        .then(_fleetTrucktankerCapacityPart);

Lens<bool?> truckTankerHazmatLens(TruckLocation location) => _fleetRootLens()
    .then(_fleetTruckItemPart(location.truckIndex))
    .then(_fleetTruckAsTankerPart)
    .then(_fleetTrucktankerHazmatPart);

Lens<String?> bikeRegistrationPlateLens(BikeLocation location) =>
    _fleetRootLens()
        .then(_fleetBikeItemPart(location.bikeIndex))
        .then(_fleetBikeRegistrationPart)
        .then(_fleetBikeregistrationPlatePart);

Lens<String?> bikeRegistrationVinLens(BikeLocation location) => _fleetRootLens()
    .then(_fleetBikeItemPart(location.bikeIndex))
    .then(_fleetBikeRegistrationPart)
    .then(_fleetBikeregistrationVinPart);

Lens<String?> bikeRegistrationRegionLens(BikeLocation location) =>
    _fleetRootLens()
        .then(_fleetBikeItemPart(location.bikeIndex))
        .then(_fleetBikeRegistrationPart)
        .then(_fleetBikeregistrationRegionPart);

Lens<bool?> bikeRegistrationLockedLens(BikeLocation location) =>
    _fleetRootLens()
        .then(_fleetBikeItemPart(location.bikeIndex))
        .then(_fleetBikeRegistrationPart)
        .then(_fleetBikeregistrationLockedPart);

Lens<List<String>> bikeRegistrationTagsLens(BikeLocation location) =>
    _fleetRootLens()
        .then(_fleetBikeItemPart(location.bikeIndex))
        .then(_fleetBikeRegistrationPart)
        .then(_fleetBikeregistrationTagsPart);

Lens<String?> bikeRegistrationNotesLens(BikeLocation location) =>
    _fleetRootLens()
        .then(_fleetBikeItemPart(location.bikeIndex))
        .then(_fleetBikeRegistrationPart)
        .then(_fleetBikeregistrationNotesPart);

Lens<String?> bikeRegistrationPermitDetailAuthorityLens(
  BikePermitLocation location,
) => _fleetRootLens()
    .then(_fleetBikeItemPart(location.bikeIndex))
    .then(_fleetBikeRegistrationPart)
    .then(_fleetBikeregistrationPermitsItemPart(location.permitIndex))
    .then(_fleetBikeregistrationpermitDetailPart)
    .then(_fleetBikeregistrationpermitDetailAuthorityPart);

Lens<bool?> bikeRegistrationPermitDetailRevokedLens(
  BikePermitLocation location,
) => _fleetRootLens()
    .then(_fleetBikeItemPart(location.bikeIndex))
    .then(_fleetBikeRegistrationPart)
    .then(_fleetBikeregistrationPermitsItemPart(location.permitIndex))
    .then(_fleetBikeregistrationpermitDetailPart)
    .then(_fleetBikeregistrationpermitDetailRevokedPart);

Lens<String> bikeRegistrationPermitDetailParkingZoneLens(
  BikePermitLocation location,
) => _fleetRootLens()
    .then(_fleetBikeItemPart(location.bikeIndex))
    .then(_fleetBikeRegistrationPart)
    .then(_fleetBikeregistrationPermitsItemPart(location.permitIndex))
    .then(_fleetBikeregistrationpermitDetailPart)
    .then(_fleetBikeregistrationpermitAsParkingPermitPart)
    .then(_fleetBikeregistrationpermitdetailparkingZonePart);

Lens<int?> bikeRegistrationPermitDetailParkingHoursLens(
  BikePermitLocation location,
) => _fleetRootLens()
    .then(_fleetBikeItemPart(location.bikeIndex))
    .then(_fleetBikeRegistrationPart)
    .then(_fleetBikeregistrationPermitsItemPart(location.permitIndex))
    .then(_fleetBikeregistrationpermitDetailPart)
    .then(_fleetBikeregistrationpermitAsParkingPermitPart)
    .then(_fleetBikeregistrationpermitdetailparkingHoursPart);

Lens<String> bikeRegistrationPermitDetailTollAccountLens(
  BikePermitLocation location,
) => _fleetRootLens()
    .then(_fleetBikeItemPart(location.bikeIndex))
    .then(_fleetBikeRegistrationPart)
    .then(_fleetBikeregistrationPermitsItemPart(location.permitIndex))
    .then(_fleetBikeregistrationpermitDetailPart)
    .then(_fleetBikeregistrationpermitAsTollPermitPart)
    .then(_fleetBikeregistrationpermitdetailtollAccountPart);

Lens<double> bikeRegistrationPermitDetailTollBalanceLens(
  BikePermitLocation location,
) => _fleetRootLens()
    .then(_fleetBikeItemPart(location.bikeIndex))
    .then(_fleetBikeRegistrationPart)
    .then(_fleetBikeregistrationPermitsItemPart(location.permitIndex))
    .then(_fleetBikeregistrationpermitDetailPart)
    .then(_fleetBikeregistrationpermitAsTollPermitPart)
    .then(_fleetBikeregistrationpermitdetailtollBalancePart);

Lens<String> bikeRegistrationPermitDetailAccessGateIdLens(
  BikePermitGateLocation location,
) => _fleetRootLens()
    .then(_fleetBikeItemPart(location.bikeIndex))
    .then(_fleetBikeRegistrationPart)
    .then(_fleetBikeregistrationPermitsItemPart(location.permitIndex))
    .then(_fleetBikeregistrationpermitDetailPart)
    .then(_fleetBikeregistrationpermitAsAccessPermitPart)
    .then(
      _fleetBikeregistrationpermitdetailaccessGatesItemPart(location.gateIndex),
    )
    .then(_fleetBikeregistrationpermitdetailaccessgateIdPart);

Lens<String?> bikeRegistrationPermitDetailAccessGateManualKeyLens(
  BikePermitGateLocation location,
) => _fleetRootLens()
    .then(_fleetBikeItemPart(location.bikeIndex))
    .then(_fleetBikeRegistrationPart)
    .then(_fleetBikeregistrationPermitsItemPart(location.permitIndex))
    .then(_fleetBikeregistrationpermitDetailPart)
    .then(_fleetBikeregistrationpermitAsAccessPermitPart)
    .then(
      _fleetBikeregistrationpermitdetailaccessGatesItemPart(location.gateIndex),
    )
    .then(_fleetBikeregistrationpermitdetailaccessgateAsManualGatePart)
    .then(_fleetBikeregistrationpermitdetailaccessgatemanualKeyPart);

Lens<String?> bikeRegistrationPermitDetailAccessGateAutoSensorModelLens(
  BikePermitGateLocation location,
) => _fleetRootLens()
    .then(_fleetBikeItemPart(location.bikeIndex))
    .then(_fleetBikeRegistrationPart)
    .then(_fleetBikeregistrationPermitsItemPart(location.permitIndex))
    .then(_fleetBikeregistrationpermitDetailPart)
    .then(_fleetBikeregistrationpermitAsAccessPermitPart)
    .then(
      _fleetBikeregistrationpermitdetailaccessGatesItemPart(location.gateIndex),
    )
    .then(_fleetBikeregistrationpermitdetailaccessgateAsAutoGatePart)
    .then(_fleetBikeregistrationpermitdetailaccessgateautoSensorModelPart);

Lens<String?> bikeRegistrationPermitDetailAccessGateAutoBackupIdLens(
  BikePermitGateLocation location,
) => _fleetRootLens()
    .then(_fleetBikeItemPart(location.bikeIndex))
    .then(_fleetBikeRegistrationPart)
    .then(_fleetBikeregistrationPermitsItemPart(location.permitIndex))
    .then(_fleetBikeregistrationpermitDetailPart)
    .then(_fleetBikeregistrationpermitAsAccessPermitPart)
    .then(
      _fleetBikeregistrationpermitdetailaccessGatesItemPart(location.gateIndex),
    )
    .then(_fleetBikeregistrationpermitdetailaccessgateAsAutoGatePart)
    .then(_fleetBikeregistrationpermitdetailaccessgateautoBackupIdPart);

Lens<String?> bikeRegistrationPermitLabelLens(BikePermitLocation location) =>
    _fleetRootLens()
        .then(_fleetBikeItemPart(location.bikeIndex))
        .then(_fleetBikeRegistrationPart)
        .then(_fleetBikeregistrationPermitsItemPart(location.permitIndex))
        .then(_fleetBikeregistrationpermitLabelPart);

Lens<int?> bikeRegistrationPermitPriorityLens(BikePermitLocation location) =>
    _fleetRootLens()
        .then(_fleetBikeItemPart(location.bikeIndex))
        .then(_fleetBikeRegistrationPart)
        .then(_fleetBikeregistrationPermitsItemPart(location.permitIndex))
        .then(_fleetBikeregistrationpermitPriorityPart);

Lens<int?> bikeRegistrationPermitRepeatLens(BikePermitLocation location) =>
    _fleetRootLens()
        .then(_fleetBikeItemPart(location.bikeIndex))
        .then(_fleetBikeRegistrationPart)
        .then(_fleetBikeregistrationPermitsItemPart(location.permitIndex))
        .then(_fleetBikeregistrationpermitRepeatPart);

Lens<bool?> bikeRegistrationPermitEnabledLens(BikePermitLocation location) =>
    _fleetRootLens()
        .then(_fleetBikeItemPart(location.bikeIndex))
        .then(_fleetBikeRegistrationPart)
        .then(_fleetBikeregistrationPermitsItemPart(location.permitIndex))
        .then(_fleetBikeregistrationpermitEnabledPart);

Lens<bool?> bikeElectricLens(BikeLocation location) => _fleetRootLens()
    .then(_fleetBikeItemPart(location.bikeIndex))
    .then(_fleetBikeElectricPart);

Lens<int?> bikeRoadGearsLens(BikeLocation location) => _fleetRootLens()
    .then(_fleetBikeItemPart(location.bikeIndex))
    .then(_fleetBikeAsRoadBikePart)
    .then(_fleetBikeroadGearsPart);

Lens<int?> bikeCargoBasketsLens(BikeLocation location) => _fleetRootLens()
    .then(_fleetBikeItemPart(location.bikeIndex))
    .then(_fleetBikeAsCargoBikePart)
    .then(_fleetBikecargoBasketsPart);

Lens<bool?> bikeCargoAssistLens(BikeLocation location) => _fleetRootLens()
    .then(_fleetBikeItemPart(location.bikeIndex))
    .then(_fleetBikeAsCargoBikePart)
    .then(_fleetBikecargoAssistPart);

Lens<PolicyCondition?> policyConditionsLens(PolicyLocation location) =>
    _fleetRootLens()
        .then(_fleetPoliciesItemPart(location.policyIndex))
        .then(_fleetPolicyConditionsPart);

Lens<int?> policyLimitsMaxSpeedLens(PolicyLocation location) => _fleetRootLens()
    .then(_fleetPoliciesItemPart(location.policyIndex))
    .then(_fleetPolicyLimitsPart)
    .then(_fleetPolicylimitsMaxSpeedPart);

Lens<double?> policyLimitsMaxLoadLens(PolicyLocation location) =>
    _fleetRootLens()
        .then(_fleetPoliciesItemPart(location.policyIndex))
        .then(_fleetPolicyLimitsPart)
        .then(_fleetPolicylimitsMaxLoadPart);

Lens<bool?> policyLimitsEscortLens(PolicyLocation location) => _fleetRootLens()
    .then(_fleetPoliciesItemPart(location.policyIndex))
    .then(_fleetPolicyLimitsPart)
    .then(_fleetPolicylimitsEscortPart);

Lens<int?> policyLimitsCurfewLens(PolicyLocation location) => _fleetRootLens()
    .then(_fleetPoliciesItemPart(location.policyIndex))
    .then(_fleetPolicyLimitsPart)
    .then(_fleetPolicylimitsCurfewPart);

Lens<int?> policyLimitsInspectionDaysLens(PolicyLocation location) =>
    _fleetRootLens()
        .then(_fleetPoliciesItemPart(location.policyIndex))
        .then(_fleetPolicyLimitsPart)
        .then(_fleetPolicylimitsInspectionDaysPart);

Lens<int?> depotCapacityLens(VehicleCategory category) =>
    depotSettingsLens(category).then(_fleetDepotCapacityPart);

Lens<int?> depotBaysLens(VehicleCategory category) =>
    depotSettingsLens(category).then(_fleetDepotBaysPart);

Lens<bool?> depotNightShiftLens(VehicleCategory category) =>
    depotSettingsLens(category).then(_fleetDepotNightShiftPart);

Lens<String?> depotNotesLens(VehicleCategory category) =>
    depotSettingsLens(category).then(_fleetDepotNotesPart);

bool settingsAutoSyncHasSavedBacking(Fleet? saved) {
  if (saved == null) return false;
  try {
    settingsAutoSyncLens().get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final settingsAutoSyncField = GeneratedEditField<Fleet, (), bool?, Lens<bool?>>(
  id: 'settingsAutoSync',
  dirtyField: FleetDirtyField.settingsAutoSync,
  lens: (location) => settingsAutoSyncLens(),
  fallback: null,
  adapter: FieldAdapterSpec<bool?>.identity(),
);

bool settingsAlertsHasSavedBacking(Fleet? saved) {
  if (saved == null) return false;
  try {
    settingsAlertsLens().get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final settingsAlertsField = GeneratedEditField<Fleet, (), bool?, Lens<bool?>>(
  id: 'settingsAlerts',
  dirtyField: FleetDirtyField.settingsAlerts,
  lens: (location) => settingsAlertsLens(),
  fallback: null,
  adapter: FieldAdapterSpec<bool?>.identity(),
);

bool settingsRegionHasSavedBacking(Fleet? saved) {
  if (saved == null) return false;
  try {
    settingsRegionLens().get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final settingsRegionField =
    GeneratedEditField<Fleet, (), String?, Lens<String?>>(
      id: 'settingsRegion',
      dirtyField: FleetDirtyField.settingsRegion,
      lens: (location) => settingsRegionLens(),
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool settingsEmergencyContactsHasSavedBacking(Fleet? saved) {
  if (saved == null) return false;
  try {
    settingsEmergencyContactsLens().get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final settingsEmergencyContactsField =
    GeneratedEditField<Fleet, (), List<String>?, Lens<List<String>?>>(
      id: 'settingsEmergencyContacts',
      dirtyField: FleetDirtyField.settingsEmergencyContacts,
      lens: (location) => settingsEmergencyContactsLens(),
      fallback: null,
      adapter: FieldAdapterSpec<List<String>?>.identity(),
    );

bool settingsNotificationsEmailHasSavedBacking(Fleet? saved) {
  if (saved == null) return false;
  try {
    settingsNotificationsEmailLens().get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final settingsNotificationsEmailField =
    GeneratedEditField<Fleet, (), bool?, Lens<bool?>>(
      id: 'settingsNotificationsEmail',
      dirtyField: FleetDirtyField.settingsNotificationsEmail,
      lens: (location) => settingsNotificationsEmailLens(),
      fallback: null,
      adapter: FieldAdapterSpec<bool?>.identity(),
    );

bool settingsNotificationsSmsHasSavedBacking(Fleet? saved) {
  if (saved == null) return false;
  try {
    settingsNotificationsSmsLens().get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final settingsNotificationsSmsField =
    GeneratedEditField<Fleet, (), bool?, Lens<bool?>>(
      id: 'settingsNotificationsSms',
      dirtyField: FleetDirtyField.settingsNotificationsSms,
      lens: (location) => settingsNotificationsSmsLens(),
      fallback: null,
      adapter: FieldAdapterSpec<bool?>.identity(),
    );

bool settingsNotificationsWebhookUrlHasSavedBacking(Fleet? saved) {
  if (saved == null) return false;
  try {
    settingsNotificationsWebhookUrlLens().get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final settingsNotificationsWebhookUrlField =
    GeneratedEditField<Fleet, (), String?, Lens<String?>>(
      id: 'settingsNotificationsWebhookUrl',
      dirtyField: FleetDirtyField.settingsNotificationsWebhookUrl,
      lens: (location) => settingsNotificationsWebhookUrlLens(),
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool carRegistrationPlateHasSavedBacking(Fleet? saved, CarLocation location) {
  if (saved == null) return false;
  try {
    carRegistrationPlateLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carRegistrationPlateField =
    GeneratedEditField<Fleet, CarLocation, String?, Lens<String?>>(
      id: 'carRegistrationPlate',
      dirtyField: FleetDirtyField.carRegistrationPlate,
      lens: carRegistrationPlateLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool carRegistrationVinHasSavedBacking(Fleet? saved, CarLocation location) {
  if (saved == null) return false;
  try {
    carRegistrationVinLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carRegistrationVinField =
    GeneratedEditField<Fleet, CarLocation, String?, Lens<String?>>(
      id: 'carRegistrationVin',
      dirtyField: FleetDirtyField.carRegistrationVin,
      lens: carRegistrationVinLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool carRegistrationRegionHasSavedBacking(Fleet? saved, CarLocation location) {
  if (saved == null) return false;
  try {
    carRegistrationRegionLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carRegistrationRegionField =
    GeneratedEditField<Fleet, CarLocation, String?, Lens<String?>>(
      id: 'carRegistrationRegion',
      dirtyField: FleetDirtyField.carRegistrationRegion,
      lens: carRegistrationRegionLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool carRegistrationLockedHasSavedBacking(Fleet? saved, CarLocation location) {
  if (saved == null) return false;
  try {
    carRegistrationLockedLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carRegistrationLockedField =
    GeneratedEditField<Fleet, CarLocation, bool?, Lens<bool?>>(
      id: 'carRegistrationLocked',
      dirtyField: FleetDirtyField.carRegistrationLocked,
      lens: carRegistrationLockedLens,
      fallback: null,
      adapter: FieldAdapterSpec<bool?>.identity(),
    );

bool carRegistrationTagsHasSavedBacking(Fleet? saved, CarLocation location) {
  if (saved == null) return false;
  try {
    carRegistrationTagsLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carRegistrationTagsField =
    GeneratedEditField<Fleet, CarLocation, List<String>, Lens<List<String>>>(
      id: 'carRegistrationTags',
      dirtyField: FleetDirtyField.carRegistrationTags,
      lens: carRegistrationTagsLens,
      fallback: null,
      adapter: FieldAdapterSpec<List<String>>.identity(),
    );

bool carRegistrationNotesHasSavedBacking(Fleet? saved, CarLocation location) {
  if (saved == null) return false;
  try {
    carRegistrationNotesLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carRegistrationNotesField =
    GeneratedEditField<Fleet, CarLocation, String?, Lens<String?>>(
      id: 'carRegistrationNotes',
      dirtyField: FleetDirtyField.carRegistrationNotes,
      lens: carRegistrationNotesLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool carRegistrationPermitDetailAuthorityHasSavedBacking(
  Fleet? saved,
  CarPermitLocation location,
) {
  if (saved == null) return false;
  try {
    carRegistrationPermitDetailAuthorityLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carRegistrationPermitDetailAuthorityField =
    GeneratedEditField<Fleet, CarPermitLocation, String?, Lens<String?>>(
      id: 'carRegistrationPermitDetailAuthority',
      dirtyField: FleetDirtyField.carRegistrationPermitDetailAuthority,
      lens: carRegistrationPermitDetailAuthorityLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool carRegistrationPermitDetailRevokedHasSavedBacking(
  Fleet? saved,
  CarPermitLocation location,
) {
  if (saved == null) return false;
  try {
    carRegistrationPermitDetailRevokedLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carRegistrationPermitDetailRevokedField =
    GeneratedEditField<Fleet, CarPermitLocation, bool?, Lens<bool?>>(
      id: 'carRegistrationPermitDetailRevoked',
      dirtyField: FleetDirtyField.carRegistrationPermitDetailRevoked,
      lens: carRegistrationPermitDetailRevokedLens,
      fallback: null,
      adapter: FieldAdapterSpec<bool?>.identity(),
    );

bool carRegistrationPermitDetailParkingZoneHasSavedBacking(
  Fleet? saved,
  CarPermitLocation location,
) {
  if (saved == null) return false;
  try {
    carRegistrationPermitDetailParkingZoneLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carRegistrationPermitDetailParkingZoneField =
    GeneratedEditField<Fleet, CarPermitLocation, String, Lens<String>>(
      id: 'carRegistrationPermitDetailParkingZone',
      dirtyField: FleetDirtyField.carRegistrationPermitDetailParkingZone,
      lens: carRegistrationPermitDetailParkingZoneLens,
      fallback: null,
      adapter: FieldAdapterSpec<String>.identity(),
    );

bool carRegistrationPermitDetailParkingHoursHasSavedBacking(
  Fleet? saved,
  CarPermitLocation location,
) {
  if (saved == null) return false;
  try {
    carRegistrationPermitDetailParkingHoursLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carRegistrationPermitDetailParkingHoursField =
    GeneratedEditField<Fleet, CarPermitLocation, int?, Lens<int?>>(
      id: 'carRegistrationPermitDetailParkingHours',
      dirtyField: FleetDirtyField.carRegistrationPermitDetailParkingHours,
      lens: carRegistrationPermitDetailParkingHoursLens,
      fallback: null,
      adapter: FieldAdapterSpec<int?>.identity(),
    );

bool carRegistrationPermitDetailTollAccountHasSavedBacking(
  Fleet? saved,
  CarPermitLocation location,
) {
  if (saved == null) return false;
  try {
    carRegistrationPermitDetailTollAccountLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carRegistrationPermitDetailTollAccountField =
    GeneratedEditField<Fleet, CarPermitLocation, String, Lens<String>>(
      id: 'carRegistrationPermitDetailTollAccount',
      dirtyField: FleetDirtyField.carRegistrationPermitDetailTollAccount,
      lens: carRegistrationPermitDetailTollAccountLens,
      fallback: null,
      adapter: FieldAdapterSpec<String>.identity(),
    );

bool carRegistrationPermitDetailTollBalanceHasSavedBacking(
  Fleet? saved,
  CarPermitLocation location,
) {
  if (saved == null) return false;
  try {
    carRegistrationPermitDetailTollBalanceLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carRegistrationPermitDetailTollBalanceField =
    GeneratedEditField<Fleet, CarPermitLocation, double, Lens<double>>(
      id: 'carRegistrationPermitDetailTollBalance',
      dirtyField: FleetDirtyField.carRegistrationPermitDetailTollBalance,
      lens: carRegistrationPermitDetailTollBalanceLens,
      fallback: null,
      adapter: FieldAdapterSpec<double>.identity(),
    );

bool carRegistrationPermitDetailAccessGateIdHasSavedBacking(
  Fleet? saved,
  CarPermitGateLocation location,
) {
  if (saved == null) return false;
  try {
    carRegistrationPermitDetailAccessGateIdLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carRegistrationPermitDetailAccessGateIdField =
    GeneratedEditField<Fleet, CarPermitGateLocation, String, Lens<String>>(
      id: 'carRegistrationPermitDetailAccessGateId',
      dirtyField: FleetDirtyField.carRegistrationPermitDetailAccessGateId,
      lens: carRegistrationPermitDetailAccessGateIdLens,
      fallback: null,
      adapter: FieldAdapterSpec<String>.identity(),
    );

bool carRegistrationPermitDetailAccessGateManualKeyHasSavedBacking(
  Fleet? saved,
  CarPermitGateLocation location,
) {
  if (saved == null) return false;
  try {
    carRegistrationPermitDetailAccessGateManualKeyLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carRegistrationPermitDetailAccessGateManualKeyField =
    GeneratedEditField<Fleet, CarPermitGateLocation, String?, Lens<String?>>(
      id: 'carRegistrationPermitDetailAccessGateManualKey',
      dirtyField:
          FleetDirtyField.carRegistrationPermitDetailAccessGateManualKey,
      lens: carRegistrationPermitDetailAccessGateManualKeyLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool carRegistrationPermitDetailAccessGateAutoSensorModelHasSavedBacking(
  Fleet? saved,
  CarPermitGateLocation location,
) {
  if (saved == null) return false;
  try {
    carRegistrationPermitDetailAccessGateAutoSensorModelLens(
      location,
    ).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carRegistrationPermitDetailAccessGateAutoSensorModelField =
    GeneratedEditField<Fleet, CarPermitGateLocation, String?, Lens<String?>>(
      id: 'carRegistrationPermitDetailAccessGateAutoSensorModel',
      dirtyField:
          FleetDirtyField.carRegistrationPermitDetailAccessGateAutoSensorModel,
      lens: carRegistrationPermitDetailAccessGateAutoSensorModelLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool carRegistrationPermitDetailAccessGateAutoBackupIdHasSavedBacking(
  Fleet? saved,
  CarPermitGateLocation location,
) {
  if (saved == null) return false;
  try {
    carRegistrationPermitDetailAccessGateAutoBackupIdLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carRegistrationPermitDetailAccessGateAutoBackupIdField =
    GeneratedEditField<Fleet, CarPermitGateLocation, String?, Lens<String?>>(
      id: 'carRegistrationPermitDetailAccessGateAutoBackupId',
      dirtyField:
          FleetDirtyField.carRegistrationPermitDetailAccessGateAutoBackupId,
      lens: carRegistrationPermitDetailAccessGateAutoBackupIdLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool carRegistrationPermitLabelHasSavedBacking(
  Fleet? saved,
  CarPermitLocation location,
) {
  if (saved == null) return false;
  try {
    carRegistrationPermitLabelLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carRegistrationPermitLabelField =
    GeneratedEditField<Fleet, CarPermitLocation, String?, Lens<String?>>(
      id: 'carRegistrationPermitLabel',
      dirtyField: FleetDirtyField.carRegistrationPermitLabel,
      lens: carRegistrationPermitLabelLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool carRegistrationPermitPriorityHasSavedBacking(
  Fleet? saved,
  CarPermitLocation location,
) {
  if (saved == null) return false;
  try {
    carRegistrationPermitPriorityLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carRegistrationPermitPriorityField =
    GeneratedEditField<Fleet, CarPermitLocation, int?, Lens<int?>>(
      id: 'carRegistrationPermitPriority',
      dirtyField: FleetDirtyField.carRegistrationPermitPriority,
      lens: carRegistrationPermitPriorityLens,
      fallback: null,
      adapter: FieldAdapterSpec<int?>.identity(),
    );

bool carRegistrationPermitRepeatHasSavedBacking(
  Fleet? saved,
  CarPermitLocation location,
) {
  if (saved == null) return false;
  try {
    carRegistrationPermitRepeatLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carRegistrationPermitRepeatField =
    GeneratedEditField<Fleet, CarPermitLocation, int?, Lens<int?>>(
      id: 'carRegistrationPermitRepeat',
      dirtyField: FleetDirtyField.carRegistrationPermitRepeat,
      lens: carRegistrationPermitRepeatLens,
      fallback: null,
      adapter: FieldAdapterSpec<int?>.identity(),
    );

bool carRegistrationPermitEnabledHasSavedBacking(
  Fleet? saved,
  CarPermitLocation location,
) {
  if (saved == null) return false;
  try {
    carRegistrationPermitEnabledLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carRegistrationPermitEnabledField =
    GeneratedEditField<Fleet, CarPermitLocation, bool?, Lens<bool?>>(
      id: 'carRegistrationPermitEnabled',
      dirtyField: FleetDirtyField.carRegistrationPermitEnabled,
      lens: carRegistrationPermitEnabledLens,
      fallback: null,
      adapter: FieldAdapterSpec<bool?>.identity(),
    );

bool carColorHasSavedBacking(Fleet? saved, CarLocation location) {
  if (saved == null) return false;
  try {
    carColorLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carColorField =
    GeneratedEditField<Fleet, CarLocation, String, Lens<String>>(
      id: 'carColor',
      dirtyField: FleetDirtyField.carColor,
      lens: carColorLens,
      fallback: null,
      adapter: FieldAdapterSpec<String>.identity(),
    );

bool carYearHasSavedBacking(Fleet? saved, CarLocation location) {
  if (saved == null) return false;
  try {
    carYearLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carYearField = GeneratedEditField<Fleet, CarLocation, int?, Lens<int?>>(
  id: 'carYear',
  dirtyField: FleetDirtyField.carYear,
  lens: carYearLens,
  fallback: null,
  adapter: FieldAdapterSpec<int?>.identity(),
);

bool carSedanTrimLevelHasSavedBacking(Fleet? saved, CarLocation location) {
  if (saved == null) return false;
  try {
    carSedanTrimLevelLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carSedanTrimLevelField =
    GeneratedEditField<Fleet, CarLocation, String?, Lens<String?>>(
      id: 'carSedanTrimLevel',
      dirtyField: FleetDirtyField.carSedanTrimLevel,
      lens: carSedanTrimLevelLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool carSedanTrimLeatherHasSavedBacking(Fleet? saved, CarLocation location) {
  if (saved == null) return false;
  try {
    carSedanTrimLeatherLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carSedanTrimLeatherField =
    GeneratedEditField<Fleet, CarLocation, bool?, Lens<bool?>>(
      id: 'carSedanTrimLeather',
      dirtyField: FleetDirtyField.carSedanTrimLeather,
      lens: carSedanTrimLeatherLens,
      fallback: null,
      adapter: FieldAdapterSpec<bool?>.identity(),
    );

bool carSedanTrimUpholsteryMaterialHasSavedBacking(
  Fleet? saved,
  CarLocation location,
) {
  if (saved == null) return false;
  try {
    carSedanTrimUpholsteryMaterialLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carSedanTrimUpholsteryMaterialField =
    GeneratedEditField<Fleet, CarLocation, String?, Lens<String?>>(
      id: 'carSedanTrimUpholsteryMaterial',
      dirtyField: FleetDirtyField.carSedanTrimUpholsteryMaterial,
      lens: carSedanTrimUpholsteryMaterialLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool carSedanTrimUpholsteryColorHasSavedBacking(
  Fleet? saved,
  CarLocation location,
) {
  if (saved == null) return false;
  try {
    carSedanTrimUpholsteryColorLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carSedanTrimUpholsteryColorField =
    GeneratedEditField<Fleet, CarLocation, String?, Lens<String?>>(
      id: 'carSedanTrimUpholsteryColor',
      dirtyField: FleetDirtyField.carSedanTrimUpholsteryColor,
      lens: carSedanTrimUpholsteryColorLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool carSedanTrimUpholsteryHeatedHasSavedBacking(
  Fleet? saved,
  CarLocation location,
) {
  if (saved == null) return false;
  try {
    carSedanTrimUpholsteryHeatedLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carSedanTrimUpholsteryHeatedField =
    GeneratedEditField<Fleet, CarLocation, bool?, Lens<bool?>>(
      id: 'carSedanTrimUpholsteryHeated',
      dirtyField: FleetDirtyField.carSedanTrimUpholsteryHeated,
      lens: carSedanTrimUpholsteryHeatedLens,
      fallback: null,
      adapter: FieldAdapterSpec<bool?>.identity(),
    );

bool carSedanTrimUpholsteryRowsHasSavedBacking(
  Fleet? saved,
  CarLocation location,
) {
  if (saved == null) return false;
  try {
    carSedanTrimUpholsteryRowsLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carSedanTrimUpholsteryRowsField =
    GeneratedEditField<Fleet, CarLocation, List<int>, Lens<List<int>>>(
      id: 'carSedanTrimUpholsteryRows',
      dirtyField: FleetDirtyField.carSedanTrimUpholsteryRows,
      lens: carSedanTrimUpholsteryRowsLens,
      fallback: null,
      adapter: FieldAdapterSpec<List<int>>.identity(),
    );

bool carCoupeTrimLevelHasSavedBacking(Fleet? saved, CarLocation location) {
  if (saved == null) return false;
  try {
    carCoupeTrimLevelLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carCoupeTrimLevelField =
    GeneratedEditField<Fleet, CarLocation, String?, Lens<String?>>(
      id: 'carCoupeTrimLevel',
      dirtyField: FleetDirtyField.carCoupeTrimLevel,
      lens: carCoupeTrimLevelLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool carCoupeTrimLeatherHasSavedBacking(Fleet? saved, CarLocation location) {
  if (saved == null) return false;
  try {
    carCoupeTrimLeatherLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carCoupeTrimLeatherField =
    GeneratedEditField<Fleet, CarLocation, bool?, Lens<bool?>>(
      id: 'carCoupeTrimLeather',
      dirtyField: FleetDirtyField.carCoupeTrimLeather,
      lens: carCoupeTrimLeatherLens,
      fallback: null,
      adapter: FieldAdapterSpec<bool?>.identity(),
    );

bool carCoupeTrimUpholsteryMaterialHasSavedBacking(
  Fleet? saved,
  CarLocation location,
) {
  if (saved == null) return false;
  try {
    carCoupeTrimUpholsteryMaterialLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carCoupeTrimUpholsteryMaterialField =
    GeneratedEditField<Fleet, CarLocation, String?, Lens<String?>>(
      id: 'carCoupeTrimUpholsteryMaterial',
      dirtyField: FleetDirtyField.carCoupeTrimUpholsteryMaterial,
      lens: carCoupeTrimUpholsteryMaterialLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool carCoupeTrimUpholsteryColorHasSavedBacking(
  Fleet? saved,
  CarLocation location,
) {
  if (saved == null) return false;
  try {
    carCoupeTrimUpholsteryColorLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carCoupeTrimUpholsteryColorField =
    GeneratedEditField<Fleet, CarLocation, String?, Lens<String?>>(
      id: 'carCoupeTrimUpholsteryColor',
      dirtyField: FleetDirtyField.carCoupeTrimUpholsteryColor,
      lens: carCoupeTrimUpholsteryColorLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool carCoupeTrimUpholsteryHeatedHasSavedBacking(
  Fleet? saved,
  CarLocation location,
) {
  if (saved == null) return false;
  try {
    carCoupeTrimUpholsteryHeatedLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carCoupeTrimUpholsteryHeatedField =
    GeneratedEditField<Fleet, CarLocation, bool?, Lens<bool?>>(
      id: 'carCoupeTrimUpholsteryHeated',
      dirtyField: FleetDirtyField.carCoupeTrimUpholsteryHeated,
      lens: carCoupeTrimUpholsteryHeatedLens,
      fallback: null,
      adapter: FieldAdapterSpec<bool?>.identity(),
    );

bool carCoupeTrimUpholsteryRowsHasSavedBacking(
  Fleet? saved,
  CarLocation location,
) {
  if (saved == null) return false;
  try {
    carCoupeTrimUpholsteryRowsLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carCoupeTrimUpholsteryRowsField =
    GeneratedEditField<Fleet, CarLocation, List<int>, Lens<List<int>>>(
      id: 'carCoupeTrimUpholsteryRows',
      dirtyField: FleetDirtyField.carCoupeTrimUpholsteryRows,
      lens: carCoupeTrimUpholsteryRowsLens,
      fallback: null,
      adapter: FieldAdapterSpec<List<int>>.identity(),
    );

bool carCoupeDrivetrainLabelHasSavedBacking(
  Fleet? saved,
  CarLocation location,
) {
  if (saved == null) return false;
  try {
    carCoupeDrivetrainLabelLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carCoupeDrivetrainLabelField =
    GeneratedEditField<Fleet, CarLocation, String?, Lens<String?>>(
      id: 'carCoupeDrivetrainLabel',
      dirtyField: FleetDirtyField.carCoupeDrivetrainLabel,
      lens: carCoupeDrivetrainLabelLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool carCoupeDrivetrainFixedAxleHasSavedBacking(
  Fleet? saved,
  CarLocation location,
) {
  if (saved == null) return false;
  try {
    carCoupeDrivetrainFixedAxleLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carCoupeDrivetrainFixedAxleField =
    GeneratedEditField<Fleet, CarLocation, String, Lens<String>>(
      id: 'carCoupeDrivetrainFixedAxle',
      dirtyField: FleetDirtyField.carCoupeDrivetrainFixedAxle,
      lens: carCoupeDrivetrainFixedAxleLens,
      fallback: null,
      adapter: FieldAdapterSpec<String>.identity(),
    );

bool carCoupeDrivetrainRangeMinRatioHasSavedBacking(
  Fleet? saved,
  CarLocation location,
) {
  if (saved == null) return false;
  try {
    carCoupeDrivetrainRangeMinRatioLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carCoupeDrivetrainRangeMinRatioField =
    GeneratedEditField<Fleet, CarLocation, double, Lens<double>>(
      id: 'carCoupeDrivetrainRangeMinRatio',
      dirtyField: FleetDirtyField.carCoupeDrivetrainRangeMinRatio,
      lens: carCoupeDrivetrainRangeMinRatioLens,
      fallback: null,
      adapter: FieldAdapterSpec<double>.identity(),
    );

bool carCoupeDrivetrainRangeMaxRatioHasSavedBacking(
  Fleet? saved,
  CarLocation location,
) {
  if (saved == null) return false;
  try {
    carCoupeDrivetrainRangeMaxRatioLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carCoupeDrivetrainRangeMaxRatioField =
    GeneratedEditField<Fleet, CarLocation, double, Lens<double>>(
      id: 'carCoupeDrivetrainRangeMaxRatio',
      dirtyField: FleetDirtyField.carCoupeDrivetrainRangeMaxRatio,
      lens: carCoupeDrivetrainRangeMaxRatioLens,
      fallback: null,
      adapter: FieldAdapterSpec<double>.identity(),
    );

bool carCoupeDrivetrainRangeLockingHasSavedBacking(
  Fleet? saved,
  CarLocation location,
) {
  if (saved == null) return false;
  try {
    carCoupeDrivetrainRangeLockingLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carCoupeDrivetrainRangeLockingField =
    GeneratedEditField<Fleet, CarLocation, bool, Lens<bool>>(
      id: 'carCoupeDrivetrainRangeLocking',
      dirtyField: FleetDirtyField.carCoupeDrivetrainRangeLocking,
      lens: carCoupeDrivetrainRangeLockingLens,
      fallback: null,
      adapter: FieldAdapterSpec<bool>.identity(),
    );

bool carCoupeTopSpeedHasSavedBacking(Fleet? saved, CarLocation location) {
  if (saved == null) return false;
  try {
    carCoupeTopSpeedLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carCoupeTopSpeedField =
    GeneratedEditField<Fleet, CarLocation, int?, Lens<int?>>(
      id: 'carCoupeTopSpeed',
      dirtyField: FleetDirtyField.carCoupeTopSpeed,
      lens: carCoupeTopSpeedLens,
      fallback: null,
      adapter: FieldAdapterSpec<int?>.identity(),
    );

bool carConvertibleTrimLevelHasSavedBacking(
  Fleet? saved,
  CarLocation location,
) {
  if (saved == null) return false;
  try {
    carConvertibleTrimLevelLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carConvertibleTrimLevelField =
    GeneratedEditField<Fleet, CarLocation, String?, Lens<String?>>(
      id: 'carConvertibleTrimLevel',
      dirtyField: FleetDirtyField.carConvertibleTrimLevel,
      lens: carConvertibleTrimLevelLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool carConvertibleTrimLeatherHasSavedBacking(
  Fleet? saved,
  CarLocation location,
) {
  if (saved == null) return false;
  try {
    carConvertibleTrimLeatherLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carConvertibleTrimLeatherField =
    GeneratedEditField<Fleet, CarLocation, bool?, Lens<bool?>>(
      id: 'carConvertibleTrimLeather',
      dirtyField: FleetDirtyField.carConvertibleTrimLeather,
      lens: carConvertibleTrimLeatherLens,
      fallback: null,
      adapter: FieldAdapterSpec<bool?>.identity(),
    );

bool carConvertibleTrimUpholsteryMaterialHasSavedBacking(
  Fleet? saved,
  CarLocation location,
) {
  if (saved == null) return false;
  try {
    carConvertibleTrimUpholsteryMaterialLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carConvertibleTrimUpholsteryMaterialField =
    GeneratedEditField<Fleet, CarLocation, String?, Lens<String?>>(
      id: 'carConvertibleTrimUpholsteryMaterial',
      dirtyField: FleetDirtyField.carConvertibleTrimUpholsteryMaterial,
      lens: carConvertibleTrimUpholsteryMaterialLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool carConvertibleTrimUpholsteryColorHasSavedBacking(
  Fleet? saved,
  CarLocation location,
) {
  if (saved == null) return false;
  try {
    carConvertibleTrimUpholsteryColorLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carConvertibleTrimUpholsteryColorField =
    GeneratedEditField<Fleet, CarLocation, String?, Lens<String?>>(
      id: 'carConvertibleTrimUpholsteryColor',
      dirtyField: FleetDirtyField.carConvertibleTrimUpholsteryColor,
      lens: carConvertibleTrimUpholsteryColorLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool carConvertibleTrimUpholsteryHeatedHasSavedBacking(
  Fleet? saved,
  CarLocation location,
) {
  if (saved == null) return false;
  try {
    carConvertibleTrimUpholsteryHeatedLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carConvertibleTrimUpholsteryHeatedField =
    GeneratedEditField<Fleet, CarLocation, bool?, Lens<bool?>>(
      id: 'carConvertibleTrimUpholsteryHeated',
      dirtyField: FleetDirtyField.carConvertibleTrimUpholsteryHeated,
      lens: carConvertibleTrimUpholsteryHeatedLens,
      fallback: null,
      adapter: FieldAdapterSpec<bool?>.identity(),
    );

bool carConvertibleTrimUpholsteryRowsHasSavedBacking(
  Fleet? saved,
  CarLocation location,
) {
  if (saved == null) return false;
  try {
    carConvertibleTrimUpholsteryRowsLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carConvertibleTrimUpholsteryRowsField =
    GeneratedEditField<Fleet, CarLocation, List<int>, Lens<List<int>>>(
      id: 'carConvertibleTrimUpholsteryRows',
      dirtyField: FleetDirtyField.carConvertibleTrimUpholsteryRows,
      lens: carConvertibleTrimUpholsteryRowsLens,
      fallback: null,
      adapter: FieldAdapterSpec<List<int>>.identity(),
    );

bool carConvertibleRoofOpenHasSavedBacking(Fleet? saved, CarLocation location) {
  if (saved == null) return false;
  try {
    carConvertibleRoofOpenLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final carConvertibleRoofOpenField =
    GeneratedEditField<Fleet, CarLocation, bool?, Lens<bool?>>(
      id: 'carConvertibleRoofOpen',
      dirtyField: FleetDirtyField.carConvertibleRoofOpen,
      lens: carConvertibleRoofOpenLens,
      fallback: null,
      adapter: FieldAdapterSpec<bool?>.identity(),
    );

bool truckRegistrationPlateHasSavedBacking(
  Fleet? saved,
  TruckLocation location,
) {
  if (saved == null) return false;
  try {
    truckRegistrationPlateLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final truckRegistrationPlateField =
    GeneratedEditField<Fleet, TruckLocation, String?, Lens<String?>>(
      id: 'truckRegistrationPlate',
      dirtyField: FleetDirtyField.truckRegistrationPlate,
      lens: truckRegistrationPlateLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool truckRegistrationVinHasSavedBacking(Fleet? saved, TruckLocation location) {
  if (saved == null) return false;
  try {
    truckRegistrationVinLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final truckRegistrationVinField =
    GeneratedEditField<Fleet, TruckLocation, String?, Lens<String?>>(
      id: 'truckRegistrationVin',
      dirtyField: FleetDirtyField.truckRegistrationVin,
      lens: truckRegistrationVinLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool truckRegistrationRegionHasSavedBacking(
  Fleet? saved,
  TruckLocation location,
) {
  if (saved == null) return false;
  try {
    truckRegistrationRegionLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final truckRegistrationRegionField =
    GeneratedEditField<Fleet, TruckLocation, String?, Lens<String?>>(
      id: 'truckRegistrationRegion',
      dirtyField: FleetDirtyField.truckRegistrationRegion,
      lens: truckRegistrationRegionLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool truckRegistrationLockedHasSavedBacking(
  Fleet? saved,
  TruckLocation location,
) {
  if (saved == null) return false;
  try {
    truckRegistrationLockedLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final truckRegistrationLockedField =
    GeneratedEditField<Fleet, TruckLocation, bool?, Lens<bool?>>(
      id: 'truckRegistrationLocked',
      dirtyField: FleetDirtyField.truckRegistrationLocked,
      lens: truckRegistrationLockedLens,
      fallback: null,
      adapter: FieldAdapterSpec<bool?>.identity(),
    );

bool truckRegistrationTagsHasSavedBacking(
  Fleet? saved,
  TruckLocation location,
) {
  if (saved == null) return false;
  try {
    truckRegistrationTagsLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final truckRegistrationTagsField =
    GeneratedEditField<Fleet, TruckLocation, List<String>, Lens<List<String>>>(
      id: 'truckRegistrationTags',
      dirtyField: FleetDirtyField.truckRegistrationTags,
      lens: truckRegistrationTagsLens,
      fallback: null,
      adapter: FieldAdapterSpec<List<String>>.identity(),
    );

bool truckRegistrationNotesHasSavedBacking(
  Fleet? saved,
  TruckLocation location,
) {
  if (saved == null) return false;
  try {
    truckRegistrationNotesLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final truckRegistrationNotesField =
    GeneratedEditField<Fleet, TruckLocation, String?, Lens<String?>>(
      id: 'truckRegistrationNotes',
      dirtyField: FleetDirtyField.truckRegistrationNotes,
      lens: truckRegistrationNotesLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool truckRegistrationPermitDetailAuthorityHasSavedBacking(
  Fleet? saved,
  TruckPermitLocation location,
) {
  if (saved == null) return false;
  try {
    truckRegistrationPermitDetailAuthorityLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final truckRegistrationPermitDetailAuthorityField =
    GeneratedEditField<Fleet, TruckPermitLocation, String?, Lens<String?>>(
      id: 'truckRegistrationPermitDetailAuthority',
      dirtyField: FleetDirtyField.truckRegistrationPermitDetailAuthority,
      lens: truckRegistrationPermitDetailAuthorityLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool truckRegistrationPermitDetailRevokedHasSavedBacking(
  Fleet? saved,
  TruckPermitLocation location,
) {
  if (saved == null) return false;
  try {
    truckRegistrationPermitDetailRevokedLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final truckRegistrationPermitDetailRevokedField =
    GeneratedEditField<Fleet, TruckPermitLocation, bool?, Lens<bool?>>(
      id: 'truckRegistrationPermitDetailRevoked',
      dirtyField: FleetDirtyField.truckRegistrationPermitDetailRevoked,
      lens: truckRegistrationPermitDetailRevokedLens,
      fallback: null,
      adapter: FieldAdapterSpec<bool?>.identity(),
    );

bool truckRegistrationPermitDetailParkingZoneHasSavedBacking(
  Fleet? saved,
  TruckPermitLocation location,
) {
  if (saved == null) return false;
  try {
    truckRegistrationPermitDetailParkingZoneLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final truckRegistrationPermitDetailParkingZoneField =
    GeneratedEditField<Fleet, TruckPermitLocation, String, Lens<String>>(
      id: 'truckRegistrationPermitDetailParkingZone',
      dirtyField: FleetDirtyField.truckRegistrationPermitDetailParkingZone,
      lens: truckRegistrationPermitDetailParkingZoneLens,
      fallback: null,
      adapter: FieldAdapterSpec<String>.identity(),
    );

bool truckRegistrationPermitDetailParkingHoursHasSavedBacking(
  Fleet? saved,
  TruckPermitLocation location,
) {
  if (saved == null) return false;
  try {
    truckRegistrationPermitDetailParkingHoursLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final truckRegistrationPermitDetailParkingHoursField =
    GeneratedEditField<Fleet, TruckPermitLocation, int?, Lens<int?>>(
      id: 'truckRegistrationPermitDetailParkingHours',
      dirtyField: FleetDirtyField.truckRegistrationPermitDetailParkingHours,
      lens: truckRegistrationPermitDetailParkingHoursLens,
      fallback: null,
      adapter: FieldAdapterSpec<int?>.identity(),
    );

bool truckRegistrationPermitDetailTollAccountHasSavedBacking(
  Fleet? saved,
  TruckPermitLocation location,
) {
  if (saved == null) return false;
  try {
    truckRegistrationPermitDetailTollAccountLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final truckRegistrationPermitDetailTollAccountField =
    GeneratedEditField<Fleet, TruckPermitLocation, String, Lens<String>>(
      id: 'truckRegistrationPermitDetailTollAccount',
      dirtyField: FleetDirtyField.truckRegistrationPermitDetailTollAccount,
      lens: truckRegistrationPermitDetailTollAccountLens,
      fallback: null,
      adapter: FieldAdapterSpec<String>.identity(),
    );

bool truckRegistrationPermitDetailTollBalanceHasSavedBacking(
  Fleet? saved,
  TruckPermitLocation location,
) {
  if (saved == null) return false;
  try {
    truckRegistrationPermitDetailTollBalanceLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final truckRegistrationPermitDetailTollBalanceField =
    GeneratedEditField<Fleet, TruckPermitLocation, double, Lens<double>>(
      id: 'truckRegistrationPermitDetailTollBalance',
      dirtyField: FleetDirtyField.truckRegistrationPermitDetailTollBalance,
      lens: truckRegistrationPermitDetailTollBalanceLens,
      fallback: null,
      adapter: FieldAdapterSpec<double>.identity(),
    );

bool truckRegistrationPermitDetailAccessGateIdHasSavedBacking(
  Fleet? saved,
  TruckPermitGateLocation location,
) {
  if (saved == null) return false;
  try {
    truckRegistrationPermitDetailAccessGateIdLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final truckRegistrationPermitDetailAccessGateIdField =
    GeneratedEditField<Fleet, TruckPermitGateLocation, String, Lens<String>>(
      id: 'truckRegistrationPermitDetailAccessGateId',
      dirtyField: FleetDirtyField.truckRegistrationPermitDetailAccessGateId,
      lens: truckRegistrationPermitDetailAccessGateIdLens,
      fallback: null,
      adapter: FieldAdapterSpec<String>.identity(),
    );

bool truckRegistrationPermitDetailAccessGateManualKeyHasSavedBacking(
  Fleet? saved,
  TruckPermitGateLocation location,
) {
  if (saved == null) return false;
  try {
    truckRegistrationPermitDetailAccessGateManualKeyLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final truckRegistrationPermitDetailAccessGateManualKeyField =
    GeneratedEditField<Fleet, TruckPermitGateLocation, String?, Lens<String?>>(
      id: 'truckRegistrationPermitDetailAccessGateManualKey',
      dirtyField:
          FleetDirtyField.truckRegistrationPermitDetailAccessGateManualKey,
      lens: truckRegistrationPermitDetailAccessGateManualKeyLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool truckRegistrationPermitDetailAccessGateAutoSensorModelHasSavedBacking(
  Fleet? saved,
  TruckPermitGateLocation location,
) {
  if (saved == null) return false;
  try {
    truckRegistrationPermitDetailAccessGateAutoSensorModelLens(
      location,
    ).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final truckRegistrationPermitDetailAccessGateAutoSensorModelField =
    GeneratedEditField<Fleet, TruckPermitGateLocation, String?, Lens<String?>>(
      id: 'truckRegistrationPermitDetailAccessGateAutoSensorModel',
      dirtyField: FleetDirtyField
          .truckRegistrationPermitDetailAccessGateAutoSensorModel,
      lens: truckRegistrationPermitDetailAccessGateAutoSensorModelLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool truckRegistrationPermitDetailAccessGateAutoBackupIdHasSavedBacking(
  Fleet? saved,
  TruckPermitGateLocation location,
) {
  if (saved == null) return false;
  try {
    truckRegistrationPermitDetailAccessGateAutoBackupIdLens(
      location,
    ).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final truckRegistrationPermitDetailAccessGateAutoBackupIdField =
    GeneratedEditField<Fleet, TruckPermitGateLocation, String?, Lens<String?>>(
      id: 'truckRegistrationPermitDetailAccessGateAutoBackupId',
      dirtyField:
          FleetDirtyField.truckRegistrationPermitDetailAccessGateAutoBackupId,
      lens: truckRegistrationPermitDetailAccessGateAutoBackupIdLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool truckRegistrationPermitLabelHasSavedBacking(
  Fleet? saved,
  TruckPermitLocation location,
) {
  if (saved == null) return false;
  try {
    truckRegistrationPermitLabelLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final truckRegistrationPermitLabelField =
    GeneratedEditField<Fleet, TruckPermitLocation, String?, Lens<String?>>(
      id: 'truckRegistrationPermitLabel',
      dirtyField: FleetDirtyField.truckRegistrationPermitLabel,
      lens: truckRegistrationPermitLabelLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool truckRegistrationPermitPriorityHasSavedBacking(
  Fleet? saved,
  TruckPermitLocation location,
) {
  if (saved == null) return false;
  try {
    truckRegistrationPermitPriorityLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final truckRegistrationPermitPriorityField =
    GeneratedEditField<Fleet, TruckPermitLocation, int?, Lens<int?>>(
      id: 'truckRegistrationPermitPriority',
      dirtyField: FleetDirtyField.truckRegistrationPermitPriority,
      lens: truckRegistrationPermitPriorityLens,
      fallback: null,
      adapter: FieldAdapterSpec<int?>.identity(),
    );

bool truckRegistrationPermitRepeatHasSavedBacking(
  Fleet? saved,
  TruckPermitLocation location,
) {
  if (saved == null) return false;
  try {
    truckRegistrationPermitRepeatLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final truckRegistrationPermitRepeatField =
    GeneratedEditField<Fleet, TruckPermitLocation, int?, Lens<int?>>(
      id: 'truckRegistrationPermitRepeat',
      dirtyField: FleetDirtyField.truckRegistrationPermitRepeat,
      lens: truckRegistrationPermitRepeatLens,
      fallback: null,
      adapter: FieldAdapterSpec<int?>.identity(),
    );

bool truckRegistrationPermitEnabledHasSavedBacking(
  Fleet? saved,
  TruckPermitLocation location,
) {
  if (saved == null) return false;
  try {
    truckRegistrationPermitEnabledLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final truckRegistrationPermitEnabledField =
    GeneratedEditField<Fleet, TruckPermitLocation, bool?, Lens<bool?>>(
      id: 'truckRegistrationPermitEnabled',
      dirtyField: FleetDirtyField.truckRegistrationPermitEnabled,
      lens: truckRegistrationPermitEnabledLens,
      fallback: null,
      adapter: FieldAdapterSpec<bool?>.identity(),
    );

bool truckAxleCountHasSavedBacking(Fleet? saved, TruckLocation location) {
  if (saved == null) return false;
  try {
    truckAxleCountLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final truckAxleCountField =
    GeneratedEditField<Fleet, TruckLocation, int?, Lens<int?>>(
      id: 'truckAxleCount',
      dirtyField: FleetDirtyField.truckAxleCount,
      lens: truckAxleCountLens,
      fallback: null,
      adapter: FieldAdapterSpec<int?>.identity(),
    );

bool truckBoxTrimLevelHasSavedBacking(Fleet? saved, TruckLocation location) {
  if (saved == null) return false;
  try {
    truckBoxTrimLevelLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final truckBoxTrimLevelField =
    GeneratedEditField<Fleet, TruckLocation, String?, Lens<String?>>(
      id: 'truckBoxTrimLevel',
      dirtyField: FleetDirtyField.truckBoxTrimLevel,
      lens: truckBoxTrimLevelLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool truckBoxTrimLeatherHasSavedBacking(Fleet? saved, TruckLocation location) {
  if (saved == null) return false;
  try {
    truckBoxTrimLeatherLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final truckBoxTrimLeatherField =
    GeneratedEditField<Fleet, TruckLocation, bool?, Lens<bool?>>(
      id: 'truckBoxTrimLeather',
      dirtyField: FleetDirtyField.truckBoxTrimLeather,
      lens: truckBoxTrimLeatherLens,
      fallback: null,
      adapter: FieldAdapterSpec<bool?>.identity(),
    );

bool truckBoxTrimUpholsteryMaterialHasSavedBacking(
  Fleet? saved,
  TruckLocation location,
) {
  if (saved == null) return false;
  try {
    truckBoxTrimUpholsteryMaterialLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final truckBoxTrimUpholsteryMaterialField =
    GeneratedEditField<Fleet, TruckLocation, String?, Lens<String?>>(
      id: 'truckBoxTrimUpholsteryMaterial',
      dirtyField: FleetDirtyField.truckBoxTrimUpholsteryMaterial,
      lens: truckBoxTrimUpholsteryMaterialLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool truckBoxTrimUpholsteryColorHasSavedBacking(
  Fleet? saved,
  TruckLocation location,
) {
  if (saved == null) return false;
  try {
    truckBoxTrimUpholsteryColorLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final truckBoxTrimUpholsteryColorField =
    GeneratedEditField<Fleet, TruckLocation, String?, Lens<String?>>(
      id: 'truckBoxTrimUpholsteryColor',
      dirtyField: FleetDirtyField.truckBoxTrimUpholsteryColor,
      lens: truckBoxTrimUpholsteryColorLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool truckBoxTrimUpholsteryHeatedHasSavedBacking(
  Fleet? saved,
  TruckLocation location,
) {
  if (saved == null) return false;
  try {
    truckBoxTrimUpholsteryHeatedLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final truckBoxTrimUpholsteryHeatedField =
    GeneratedEditField<Fleet, TruckLocation, bool?, Lens<bool?>>(
      id: 'truckBoxTrimUpholsteryHeated',
      dirtyField: FleetDirtyField.truckBoxTrimUpholsteryHeated,
      lens: truckBoxTrimUpholsteryHeatedLens,
      fallback: null,
      adapter: FieldAdapterSpec<bool?>.identity(),
    );

bool truckBoxTrimUpholsteryRowsHasSavedBacking(
  Fleet? saved,
  TruckLocation location,
) {
  if (saved == null) return false;
  try {
    truckBoxTrimUpholsteryRowsLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final truckBoxTrimUpholsteryRowsField =
    GeneratedEditField<Fleet, TruckLocation, List<int>, Lens<List<int>>>(
      id: 'truckBoxTrimUpholsteryRows',
      dirtyField: FleetDirtyField.truckBoxTrimUpholsteryRows,
      lens: truckBoxTrimUpholsteryRowsLens,
      fallback: null,
      adapter: FieldAdapterSpec<List<int>>.identity(),
    );

bool truckBoxBoxVolumeHasSavedBacking(Fleet? saved, TruckLocation location) {
  if (saved == null) return false;
  try {
    truckBoxBoxVolumeLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final truckBoxBoxVolumeField =
    GeneratedEditField<Fleet, TruckLocation, double?, Lens<double?>>(
      id: 'truckBoxBoxVolume',
      dirtyField: FleetDirtyField.truckBoxBoxVolume,
      lens: truckBoxBoxVolumeLens,
      fallback: null,
      adapter: FieldAdapterSpec<double?>.identity(),
    );

bool truckTankerCapacityHasSavedBacking(Fleet? saved, TruckLocation location) {
  if (saved == null) return false;
  try {
    truckTankerCapacityLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final truckTankerCapacityField =
    GeneratedEditField<Fleet, TruckLocation, double?, Lens<double?>>(
      id: 'truckTankerCapacity',
      dirtyField: FleetDirtyField.truckTankerCapacity,
      lens: truckTankerCapacityLens,
      fallback: null,
      adapter: FieldAdapterSpec<double?>.identity(),
    );

bool truckTankerHazmatHasSavedBacking(Fleet? saved, TruckLocation location) {
  if (saved == null) return false;
  try {
    truckTankerHazmatLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final truckTankerHazmatField =
    GeneratedEditField<Fleet, TruckLocation, bool?, Lens<bool?>>(
      id: 'truckTankerHazmat',
      dirtyField: FleetDirtyField.truckTankerHazmat,
      lens: truckTankerHazmatLens,
      fallback: null,
      adapter: FieldAdapterSpec<bool?>.identity(),
    );

bool bikeRegistrationPlateHasSavedBacking(Fleet? saved, BikeLocation location) {
  if (saved == null) return false;
  try {
    bikeRegistrationPlateLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final bikeRegistrationPlateField =
    GeneratedEditField<Fleet, BikeLocation, String?, Lens<String?>>(
      id: 'bikeRegistrationPlate',
      dirtyField: FleetDirtyField.bikeRegistrationPlate,
      lens: bikeRegistrationPlateLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool bikeRegistrationVinHasSavedBacking(Fleet? saved, BikeLocation location) {
  if (saved == null) return false;
  try {
    bikeRegistrationVinLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final bikeRegistrationVinField =
    GeneratedEditField<Fleet, BikeLocation, String?, Lens<String?>>(
      id: 'bikeRegistrationVin',
      dirtyField: FleetDirtyField.bikeRegistrationVin,
      lens: bikeRegistrationVinLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool bikeRegistrationRegionHasSavedBacking(
  Fleet? saved,
  BikeLocation location,
) {
  if (saved == null) return false;
  try {
    bikeRegistrationRegionLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final bikeRegistrationRegionField =
    GeneratedEditField<Fleet, BikeLocation, String?, Lens<String?>>(
      id: 'bikeRegistrationRegion',
      dirtyField: FleetDirtyField.bikeRegistrationRegion,
      lens: bikeRegistrationRegionLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool bikeRegistrationLockedHasSavedBacking(
  Fleet? saved,
  BikeLocation location,
) {
  if (saved == null) return false;
  try {
    bikeRegistrationLockedLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final bikeRegistrationLockedField =
    GeneratedEditField<Fleet, BikeLocation, bool?, Lens<bool?>>(
      id: 'bikeRegistrationLocked',
      dirtyField: FleetDirtyField.bikeRegistrationLocked,
      lens: bikeRegistrationLockedLens,
      fallback: null,
      adapter: FieldAdapterSpec<bool?>.identity(),
    );

bool bikeRegistrationTagsHasSavedBacking(Fleet? saved, BikeLocation location) {
  if (saved == null) return false;
  try {
    bikeRegistrationTagsLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final bikeRegistrationTagsField =
    GeneratedEditField<Fleet, BikeLocation, List<String>, Lens<List<String>>>(
      id: 'bikeRegistrationTags',
      dirtyField: FleetDirtyField.bikeRegistrationTags,
      lens: bikeRegistrationTagsLens,
      fallback: null,
      adapter: FieldAdapterSpec<List<String>>.identity(),
    );

bool bikeRegistrationNotesHasSavedBacking(Fleet? saved, BikeLocation location) {
  if (saved == null) return false;
  try {
    bikeRegistrationNotesLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final bikeRegistrationNotesField =
    GeneratedEditField<Fleet, BikeLocation, String?, Lens<String?>>(
      id: 'bikeRegistrationNotes',
      dirtyField: FleetDirtyField.bikeRegistrationNotes,
      lens: bikeRegistrationNotesLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool bikeRegistrationPermitDetailAuthorityHasSavedBacking(
  Fleet? saved,
  BikePermitLocation location,
) {
  if (saved == null) return false;
  try {
    bikeRegistrationPermitDetailAuthorityLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final bikeRegistrationPermitDetailAuthorityField =
    GeneratedEditField<Fleet, BikePermitLocation, String?, Lens<String?>>(
      id: 'bikeRegistrationPermitDetailAuthority',
      dirtyField: FleetDirtyField.bikeRegistrationPermitDetailAuthority,
      lens: bikeRegistrationPermitDetailAuthorityLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool bikeRegistrationPermitDetailRevokedHasSavedBacking(
  Fleet? saved,
  BikePermitLocation location,
) {
  if (saved == null) return false;
  try {
    bikeRegistrationPermitDetailRevokedLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final bikeRegistrationPermitDetailRevokedField =
    GeneratedEditField<Fleet, BikePermitLocation, bool?, Lens<bool?>>(
      id: 'bikeRegistrationPermitDetailRevoked',
      dirtyField: FleetDirtyField.bikeRegistrationPermitDetailRevoked,
      lens: bikeRegistrationPermitDetailRevokedLens,
      fallback: null,
      adapter: FieldAdapterSpec<bool?>.identity(),
    );

bool bikeRegistrationPermitDetailParkingZoneHasSavedBacking(
  Fleet? saved,
  BikePermitLocation location,
) {
  if (saved == null) return false;
  try {
    bikeRegistrationPermitDetailParkingZoneLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final bikeRegistrationPermitDetailParkingZoneField =
    GeneratedEditField<Fleet, BikePermitLocation, String, Lens<String>>(
      id: 'bikeRegistrationPermitDetailParkingZone',
      dirtyField: FleetDirtyField.bikeRegistrationPermitDetailParkingZone,
      lens: bikeRegistrationPermitDetailParkingZoneLens,
      fallback: null,
      adapter: FieldAdapterSpec<String>.identity(),
    );

bool bikeRegistrationPermitDetailParkingHoursHasSavedBacking(
  Fleet? saved,
  BikePermitLocation location,
) {
  if (saved == null) return false;
  try {
    bikeRegistrationPermitDetailParkingHoursLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final bikeRegistrationPermitDetailParkingHoursField =
    GeneratedEditField<Fleet, BikePermitLocation, int?, Lens<int?>>(
      id: 'bikeRegistrationPermitDetailParkingHours',
      dirtyField: FleetDirtyField.bikeRegistrationPermitDetailParkingHours,
      lens: bikeRegistrationPermitDetailParkingHoursLens,
      fallback: null,
      adapter: FieldAdapterSpec<int?>.identity(),
    );

bool bikeRegistrationPermitDetailTollAccountHasSavedBacking(
  Fleet? saved,
  BikePermitLocation location,
) {
  if (saved == null) return false;
  try {
    bikeRegistrationPermitDetailTollAccountLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final bikeRegistrationPermitDetailTollAccountField =
    GeneratedEditField<Fleet, BikePermitLocation, String, Lens<String>>(
      id: 'bikeRegistrationPermitDetailTollAccount',
      dirtyField: FleetDirtyField.bikeRegistrationPermitDetailTollAccount,
      lens: bikeRegistrationPermitDetailTollAccountLens,
      fallback: null,
      adapter: FieldAdapterSpec<String>.identity(),
    );

bool bikeRegistrationPermitDetailTollBalanceHasSavedBacking(
  Fleet? saved,
  BikePermitLocation location,
) {
  if (saved == null) return false;
  try {
    bikeRegistrationPermitDetailTollBalanceLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final bikeRegistrationPermitDetailTollBalanceField =
    GeneratedEditField<Fleet, BikePermitLocation, double, Lens<double>>(
      id: 'bikeRegistrationPermitDetailTollBalance',
      dirtyField: FleetDirtyField.bikeRegistrationPermitDetailTollBalance,
      lens: bikeRegistrationPermitDetailTollBalanceLens,
      fallback: null,
      adapter: FieldAdapterSpec<double>.identity(),
    );

bool bikeRegistrationPermitDetailAccessGateIdHasSavedBacking(
  Fleet? saved,
  BikePermitGateLocation location,
) {
  if (saved == null) return false;
  try {
    bikeRegistrationPermitDetailAccessGateIdLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final bikeRegistrationPermitDetailAccessGateIdField =
    GeneratedEditField<Fleet, BikePermitGateLocation, String, Lens<String>>(
      id: 'bikeRegistrationPermitDetailAccessGateId',
      dirtyField: FleetDirtyField.bikeRegistrationPermitDetailAccessGateId,
      lens: bikeRegistrationPermitDetailAccessGateIdLens,
      fallback: null,
      adapter: FieldAdapterSpec<String>.identity(),
    );

bool bikeRegistrationPermitDetailAccessGateManualKeyHasSavedBacking(
  Fleet? saved,
  BikePermitGateLocation location,
) {
  if (saved == null) return false;
  try {
    bikeRegistrationPermitDetailAccessGateManualKeyLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final bikeRegistrationPermitDetailAccessGateManualKeyField =
    GeneratedEditField<Fleet, BikePermitGateLocation, String?, Lens<String?>>(
      id: 'bikeRegistrationPermitDetailAccessGateManualKey',
      dirtyField:
          FleetDirtyField.bikeRegistrationPermitDetailAccessGateManualKey,
      lens: bikeRegistrationPermitDetailAccessGateManualKeyLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool bikeRegistrationPermitDetailAccessGateAutoSensorModelHasSavedBacking(
  Fleet? saved,
  BikePermitGateLocation location,
) {
  if (saved == null) return false;
  try {
    bikeRegistrationPermitDetailAccessGateAutoSensorModelLens(
      location,
    ).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final bikeRegistrationPermitDetailAccessGateAutoSensorModelField =
    GeneratedEditField<Fleet, BikePermitGateLocation, String?, Lens<String?>>(
      id: 'bikeRegistrationPermitDetailAccessGateAutoSensorModel',
      dirtyField:
          FleetDirtyField.bikeRegistrationPermitDetailAccessGateAutoSensorModel,
      lens: bikeRegistrationPermitDetailAccessGateAutoSensorModelLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool bikeRegistrationPermitDetailAccessGateAutoBackupIdHasSavedBacking(
  Fleet? saved,
  BikePermitGateLocation location,
) {
  if (saved == null) return false;
  try {
    bikeRegistrationPermitDetailAccessGateAutoBackupIdLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final bikeRegistrationPermitDetailAccessGateAutoBackupIdField =
    GeneratedEditField<Fleet, BikePermitGateLocation, String?, Lens<String?>>(
      id: 'bikeRegistrationPermitDetailAccessGateAutoBackupId',
      dirtyField:
          FleetDirtyField.bikeRegistrationPermitDetailAccessGateAutoBackupId,
      lens: bikeRegistrationPermitDetailAccessGateAutoBackupIdLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool bikeRegistrationPermitLabelHasSavedBacking(
  Fleet? saved,
  BikePermitLocation location,
) {
  if (saved == null) return false;
  try {
    bikeRegistrationPermitLabelLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final bikeRegistrationPermitLabelField =
    GeneratedEditField<Fleet, BikePermitLocation, String?, Lens<String?>>(
      id: 'bikeRegistrationPermitLabel',
      dirtyField: FleetDirtyField.bikeRegistrationPermitLabel,
      lens: bikeRegistrationPermitLabelLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

bool bikeRegistrationPermitPriorityHasSavedBacking(
  Fleet? saved,
  BikePermitLocation location,
) {
  if (saved == null) return false;
  try {
    bikeRegistrationPermitPriorityLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final bikeRegistrationPermitPriorityField =
    GeneratedEditField<Fleet, BikePermitLocation, int?, Lens<int?>>(
      id: 'bikeRegistrationPermitPriority',
      dirtyField: FleetDirtyField.bikeRegistrationPermitPriority,
      lens: bikeRegistrationPermitPriorityLens,
      fallback: null,
      adapter: FieldAdapterSpec<int?>.identity(),
    );

bool bikeRegistrationPermitRepeatHasSavedBacking(
  Fleet? saved,
  BikePermitLocation location,
) {
  if (saved == null) return false;
  try {
    bikeRegistrationPermitRepeatLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final bikeRegistrationPermitRepeatField =
    GeneratedEditField<Fleet, BikePermitLocation, int?, Lens<int?>>(
      id: 'bikeRegistrationPermitRepeat',
      dirtyField: FleetDirtyField.bikeRegistrationPermitRepeat,
      lens: bikeRegistrationPermitRepeatLens,
      fallback: null,
      adapter: FieldAdapterSpec<int?>.identity(),
    );

bool bikeRegistrationPermitEnabledHasSavedBacking(
  Fleet? saved,
  BikePermitLocation location,
) {
  if (saved == null) return false;
  try {
    bikeRegistrationPermitEnabledLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final bikeRegistrationPermitEnabledField =
    GeneratedEditField<Fleet, BikePermitLocation, bool?, Lens<bool?>>(
      id: 'bikeRegistrationPermitEnabled',
      dirtyField: FleetDirtyField.bikeRegistrationPermitEnabled,
      lens: bikeRegistrationPermitEnabledLens,
      fallback: null,
      adapter: FieldAdapterSpec<bool?>.identity(),
    );

bool bikeElectricHasSavedBacking(Fleet? saved, BikeLocation location) {
  if (saved == null) return false;
  try {
    bikeElectricLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final bikeElectricField =
    GeneratedEditField<Fleet, BikeLocation, bool?, Lens<bool?>>(
      id: 'bikeElectric',
      dirtyField: FleetDirtyField.bikeElectric,
      lens: bikeElectricLens,
      fallback: null,
      adapter: FieldAdapterSpec<bool?>.identity(),
    );

bool bikeRoadGearsHasSavedBacking(Fleet? saved, BikeLocation location) {
  if (saved == null) return false;
  try {
    bikeRoadGearsLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final bikeRoadGearsField =
    GeneratedEditField<Fleet, BikeLocation, int?, Lens<int?>>(
      id: 'bikeRoadGears',
      dirtyField: FleetDirtyField.bikeRoadGears,
      lens: bikeRoadGearsLens,
      fallback: null,
      adapter: FieldAdapterSpec<int?>.identity(),
    );

bool bikeCargoBasketsHasSavedBacking(Fleet? saved, BikeLocation location) {
  if (saved == null) return false;
  try {
    bikeCargoBasketsLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final bikeCargoBasketsField =
    GeneratedEditField<Fleet, BikeLocation, int?, Lens<int?>>(
      id: 'bikeCargoBaskets',
      dirtyField: FleetDirtyField.bikeCargoBaskets,
      lens: bikeCargoBasketsLens,
      fallback: null,
      adapter: FieldAdapterSpec<int?>.identity(),
    );

bool bikeCargoAssistHasSavedBacking(Fleet? saved, BikeLocation location) {
  if (saved == null) return false;
  try {
    bikeCargoAssistLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final bikeCargoAssistField =
    GeneratedEditField<Fleet, BikeLocation, bool?, Lens<bool?>>(
      id: 'bikeCargoAssist',
      dirtyField: FleetDirtyField.bikeCargoAssist,
      lens: bikeCargoAssistLens,
      fallback: null,
      adapter: FieldAdapterSpec<bool?>.identity(),
    );

bool policyConditionsHasSavedBacking(Fleet? saved, PolicyLocation location) {
  if (saved == null) return false;
  try {
    policyConditionsLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final policyConditionsField =
    GeneratedEditField<
      Fleet,
      PolicyLocation,
      PolicyCondition?,
      Lens<PolicyCondition?>
    >(
      id: 'policyConditions',
      dirtyField: FleetDirtyField.policyConditions,
      lens: policyConditionsLens,
      fallback: null,
      adapter: FieldAdapterSpec<PolicyCondition?>.identity(),
    );

bool policyLimitsMaxSpeedHasSavedBacking(
  Fleet? saved,
  PolicyLocation location,
) {
  if (saved == null) return false;
  try {
    policyLimitsMaxSpeedLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final policyLimitsMaxSpeedField =
    GeneratedEditField<Fleet, PolicyLocation, int?, Lens<int?>>(
      id: 'policyLimitsMaxSpeed',
      dirtyField: FleetDirtyField.policyLimitsMaxSpeed,
      lens: policyLimitsMaxSpeedLens,
      fallback: null,
      adapter: FieldAdapterSpec<int?>.identity(),
    );

bool policyLimitsMaxLoadHasSavedBacking(Fleet? saved, PolicyLocation location) {
  if (saved == null) return false;
  try {
    policyLimitsMaxLoadLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final policyLimitsMaxLoadField =
    GeneratedEditField<Fleet, PolicyLocation, double?, Lens<double?>>(
      id: 'policyLimitsMaxLoad',
      dirtyField: FleetDirtyField.policyLimitsMaxLoad,
      lens: policyLimitsMaxLoadLens,
      fallback: null,
      adapter: FieldAdapterSpec<double?>.identity(),
    );

bool policyLimitsEscortHasSavedBacking(Fleet? saved, PolicyLocation location) {
  if (saved == null) return false;
  try {
    policyLimitsEscortLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final policyLimitsEscortField =
    GeneratedEditField<Fleet, PolicyLocation, bool?, Lens<bool?>>(
      id: 'policyLimitsEscort',
      dirtyField: FleetDirtyField.policyLimitsEscort,
      lens: policyLimitsEscortLens,
      fallback: null,
      adapter: FieldAdapterSpec<bool?>.identity(),
    );

bool policyLimitsCurfewHasSavedBacking(Fleet? saved, PolicyLocation location) {
  if (saved == null) return false;
  try {
    policyLimitsCurfewLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final policyLimitsCurfewField =
    GeneratedEditField<Fleet, PolicyLocation, int?, Lens<int?>>(
      id: 'policyLimitsCurfew',
      dirtyField: FleetDirtyField.policyLimitsCurfew,
      lens: policyLimitsCurfewLens,
      fallback: null,
      adapter: FieldAdapterSpec<int?>.identity(),
    );

bool policyLimitsInspectionDaysHasSavedBacking(
  Fleet? saved,
  PolicyLocation location,
) {
  if (saved == null) return false;
  try {
    policyLimitsInspectionDaysLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final policyLimitsInspectionDaysField =
    GeneratedEditField<Fleet, PolicyLocation, int?, Lens<int?>>(
      id: 'policyLimitsInspectionDays',
      dirtyField: FleetDirtyField.policyLimitsInspectionDays,
      lens: policyLimitsInspectionDaysLens,
      fallback: null,
      adapter: FieldAdapterSpec<int?>.identity(),
    );

bool depotCapacityHasSavedBacking(Fleet? saved, VehicleCategory location) {
  if (saved == null) return false;
  try {
    depotCapacityLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final depotCapacityField =
    GeneratedEditField<Fleet, VehicleCategory, int?, Lens<int?>>(
      id: 'depotCapacity',
      dirtyField: FleetDirtyField.depotCapacity,
      lens: depotCapacityLens,
      fallback: null,
      adapter: FieldAdapterSpec<int?>.identity(),
    );

bool depotBaysHasSavedBacking(Fleet? saved, VehicleCategory location) {
  if (saved == null) return false;
  try {
    depotBaysLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final depotBaysField =
    GeneratedEditField<Fleet, VehicleCategory, int?, Lens<int?>>(
      id: 'depotBays',
      dirtyField: FleetDirtyField.depotBays,
      lens: depotBaysLens,
      fallback: null,
      adapter: FieldAdapterSpec<int?>.identity(),
    );

bool depotNightShiftHasSavedBacking(Fleet? saved, VehicleCategory location) {
  if (saved == null) return false;
  try {
    depotNightShiftLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final depotNightShiftField =
    GeneratedEditField<Fleet, VehicleCategory, bool?, Lens<bool?>>(
      id: 'depotNightShift',
      dirtyField: FleetDirtyField.depotNightShift,
      lens: depotNightShiftLens,
      fallback: null,
      adapter: FieldAdapterSpec<bool?>.identity(),
    );

bool depotNotesHasSavedBacking(Fleet? saved, VehicleCategory location) {
  if (saved == null) return false;
  try {
    depotNotesLens(location).get(saved);
    return true;
  } on Object catch (_) {
    return false;
  }
}

final depotNotesField =
    GeneratedEditField<Fleet, VehicleCategory, String?, Lens<String?>>(
      id: 'depotNotes',
      dirtyField: FleetDirtyField.depotNotes,
      lens: depotNotesLens,
      fallback: null,
      adapter: FieldAdapterSpec<String?>.identity(),
    );

Object? comparableFleetFieldValue(
  Fleet? value,
  FleetDirtyField field,
) => switch (field) {
  FleetDirtyField.settingsAutoSync => value?.settings?.effectiveAutoSync,
  FleetDirtyField.settingsAlerts => value?.settings?.alerts,
  FleetDirtyField.settingsRegion => value?.settings?.region,
  FleetDirtyField.settingsEmergencyContacts =>
    value?.settings?.emergencyContacts,
  FleetDirtyField.settingsNotificationsEmail =>
    value?.settings?.notifications?.email,
  FleetDirtyField.settingsNotificationsSms =>
    value?.settings?.notifications?.sms,
  FleetDirtyField.settingsNotificationsWebhookUrl =>
    value?.settings?.notifications?.webhookUrl,
  FleetDirtyField.carRegistrationPlate => null,
  FleetDirtyField.carRegistrationVin => null,
  FleetDirtyField.carRegistrationRegion => null,
  FleetDirtyField.carRegistrationLocked => null,
  FleetDirtyField.carRegistrationTags => null,
  FleetDirtyField.carRegistrationNotes => null,
  FleetDirtyField.carRegistrationPermitDetailAuthority => null,
  FleetDirtyField.carRegistrationPermitDetailRevoked => null,
  FleetDirtyField.carRegistrationPermitDetailParkingZone => null,
  FleetDirtyField.carRegistrationPermitDetailParkingHours => null,
  FleetDirtyField.carRegistrationPermitDetailTollAccount => null,
  FleetDirtyField.carRegistrationPermitDetailTollBalance => null,
  FleetDirtyField.carRegistrationPermitDetailAccessGateId => null,
  FleetDirtyField.carRegistrationPermitDetailAccessGateManualKey => null,
  FleetDirtyField.carRegistrationPermitDetailAccessGateAutoSensorModel => null,
  FleetDirtyField.carRegistrationPermitDetailAccessGateAutoBackupId => null,
  FleetDirtyField.carRegistrationPermitLabel => null,
  FleetDirtyField.carRegistrationPermitPriority => null,
  FleetDirtyField.carRegistrationPermitRepeat => null,
  FleetDirtyField.carRegistrationPermitEnabled => null,
  FleetDirtyField.carColor => null,
  FleetDirtyField.carYear => null,
  FleetDirtyField.carSedanTrimLevel => null,
  FleetDirtyField.carSedanTrimLeather => null,
  FleetDirtyField.carSedanTrimUpholsteryMaterial => null,
  FleetDirtyField.carSedanTrimUpholsteryColor => null,
  FleetDirtyField.carSedanTrimUpholsteryHeated => null,
  FleetDirtyField.carSedanTrimUpholsteryRows => null,
  FleetDirtyField.carCoupeTrimLevel => null,
  FleetDirtyField.carCoupeTrimLeather => null,
  FleetDirtyField.carCoupeTrimUpholsteryMaterial => null,
  FleetDirtyField.carCoupeTrimUpholsteryColor => null,
  FleetDirtyField.carCoupeTrimUpholsteryHeated => null,
  FleetDirtyField.carCoupeTrimUpholsteryRows => null,
  FleetDirtyField.carCoupeDrivetrainLabel => null,
  FleetDirtyField.carCoupeDrivetrainFixedAxle => null,
  FleetDirtyField.carCoupeDrivetrainRangeMinRatio => null,
  FleetDirtyField.carCoupeDrivetrainRangeMaxRatio => null,
  FleetDirtyField.carCoupeDrivetrainRangeLocking => null,
  FleetDirtyField.carCoupeTopSpeed => null,
  FleetDirtyField.carConvertibleTrimLevel => null,
  FleetDirtyField.carConvertibleTrimLeather => null,
  FleetDirtyField.carConvertibleTrimUpholsteryMaterial => null,
  FleetDirtyField.carConvertibleTrimUpholsteryColor => null,
  FleetDirtyField.carConvertibleTrimUpholsteryHeated => null,
  FleetDirtyField.carConvertibleTrimUpholsteryRows => null,
  FleetDirtyField.carConvertibleRoofOpen => null,
  FleetDirtyField.truckRegistrationPlate => null,
  FleetDirtyField.truckRegistrationVin => null,
  FleetDirtyField.truckRegistrationRegion => null,
  FleetDirtyField.truckRegistrationLocked => null,
  FleetDirtyField.truckRegistrationTags => null,
  FleetDirtyField.truckRegistrationNotes => null,
  FleetDirtyField.truckRegistrationPermitDetailAuthority => null,
  FleetDirtyField.truckRegistrationPermitDetailRevoked => null,
  FleetDirtyField.truckRegistrationPermitDetailParkingZone => null,
  FleetDirtyField.truckRegistrationPermitDetailParkingHours => null,
  FleetDirtyField.truckRegistrationPermitDetailTollAccount => null,
  FleetDirtyField.truckRegistrationPermitDetailTollBalance => null,
  FleetDirtyField.truckRegistrationPermitDetailAccessGateId => null,
  FleetDirtyField.truckRegistrationPermitDetailAccessGateManualKey => null,
  FleetDirtyField.truckRegistrationPermitDetailAccessGateAutoSensorModel =>
    null,
  FleetDirtyField.truckRegistrationPermitDetailAccessGateAutoBackupId => null,
  FleetDirtyField.truckRegistrationPermitLabel => null,
  FleetDirtyField.truckRegistrationPermitPriority => null,
  FleetDirtyField.truckRegistrationPermitRepeat => null,
  FleetDirtyField.truckRegistrationPermitEnabled => null,
  FleetDirtyField.truckAxleCount => null,
  FleetDirtyField.truckBoxTrimLevel => null,
  FleetDirtyField.truckBoxTrimLeather => null,
  FleetDirtyField.truckBoxTrimUpholsteryMaterial => null,
  FleetDirtyField.truckBoxTrimUpholsteryColor => null,
  FleetDirtyField.truckBoxTrimUpholsteryHeated => null,
  FleetDirtyField.truckBoxTrimUpholsteryRows => null,
  FleetDirtyField.truckBoxBoxVolume => null,
  FleetDirtyField.truckTankerCapacity => null,
  FleetDirtyField.truckTankerHazmat => null,
  FleetDirtyField.bikeRegistrationPlate => null,
  FleetDirtyField.bikeRegistrationVin => null,
  FleetDirtyField.bikeRegistrationRegion => null,
  FleetDirtyField.bikeRegistrationLocked => null,
  FleetDirtyField.bikeRegistrationTags => null,
  FleetDirtyField.bikeRegistrationNotes => null,
  FleetDirtyField.bikeRegistrationPermitDetailAuthority => null,
  FleetDirtyField.bikeRegistrationPermitDetailRevoked => null,
  FleetDirtyField.bikeRegistrationPermitDetailParkingZone => null,
  FleetDirtyField.bikeRegistrationPermitDetailParkingHours => null,
  FleetDirtyField.bikeRegistrationPermitDetailTollAccount => null,
  FleetDirtyField.bikeRegistrationPermitDetailTollBalance => null,
  FleetDirtyField.bikeRegistrationPermitDetailAccessGateId => null,
  FleetDirtyField.bikeRegistrationPermitDetailAccessGateManualKey => null,
  FleetDirtyField.bikeRegistrationPermitDetailAccessGateAutoSensorModel => null,
  FleetDirtyField.bikeRegistrationPermitDetailAccessGateAutoBackupId => null,
  FleetDirtyField.bikeRegistrationPermitLabel => null,
  FleetDirtyField.bikeRegistrationPermitPriority => null,
  FleetDirtyField.bikeRegistrationPermitRepeat => null,
  FleetDirtyField.bikeRegistrationPermitEnabled => null,
  FleetDirtyField.bikeElectric => null,
  FleetDirtyField.bikeRoadGears => null,
  FleetDirtyField.bikeCargoBaskets => null,
  FleetDirtyField.bikeCargoAssist => null,
  FleetDirtyField.policyConditions => null,
  FleetDirtyField.policyLimitsMaxSpeed => null,
  FleetDirtyField.policyLimitsMaxLoad => null,
  FleetDirtyField.policyLimitsEscort => null,
  FleetDirtyField.policyLimitsCurfew => null,
  FleetDirtyField.policyLimitsInspectionDays => null,
  FleetDirtyField.depotCapacity => null,
  FleetDirtyField.depotBays => null,
  FleetDirtyField.depotNightShift => null,
  FleetDirtyField.depotNotes => null,
};

Object? comparableFleetSettingsValue(FleetSettings? value) => [
  value?.effectiveAutoSync,
  value?.alerts,
  value?.region,
  value?.emergencyContacts,
  comparableNotificationSettingsValue(value?.notifications),
];

Object? comparableNotificationSettingsValue(NotificationSettings? value) => [
  value?.email,
  value?.sms,
  value?.webhookUrl,
];

Object? comparableCarValue(Car? value) => switch (value) {
  Sedan() && final v => [
    comparableRegistrationValue(v?.registration),
    v.color,
    v.year,
    'sedan',
    comparableTrimValue(v?.trim),
  ],
  Coupe() && final v => [
    comparableRegistrationValue(v?.registration),
    v.color,
    v.year,
    'coupe',
    comparableTrimValue(v?.trim),
    comparableDrivetrainValue(v?.drivetrain),
    v.topSpeed,
  ],
  Convertible() && final v => [
    comparableRegistrationValue(v?.registration),
    v.color,
    v.year,
    'convertible',
    comparableTrimValue(v?.trim),
    v.roofOpen ?? false,
  ],
  _ => null,
};

Object? comparableRegistrationValue(Registration? value) => [
  value?.plate,
  value?.vin,
  value?.region,
  value?.effectiveActive,
  value?.effectiveLocked,
  value?.tags,
  value?.notes,
  (value?.permits ?? const <Permit>[]).map(comparablePermitValue).toList(),
];

Object? comparableRegistrationIdentityValue(Registration? value) => [
  value?.plate,
  value?.vin,
];

Object? comparableRegistrationAuditValue(Registration? value) => [
  value?.plate,
  value?.region,
  value?.effectiveActive,
  value?.notes,
];

Object? comparablePermitValue(Permit? value) => [
  comparablePermitDetailValue(value?.detail),
  value?.label,
  value?.priority,
  value?.effectiveRepeat,
  value?.enabled,
];

Object? comparablePermitDetailValue(PermitDetail? value) => switch (value) {
  ParkingPermit() && final v => [
    v.authority,
    v.revoked,
    'parking',
    v.zone,
    v.hours ?? 0,
  ],
  TollPermit() && final v => [
    v.authority,
    v.revoked,
    'toll',
    v.account,
    v.balance,
  ],
  AccessPermit() && final v => [
    v.authority,
    v.revoked,
    'access',
    (v?.gates ?? const <Gate>[]).map(comparableGateValue).toList(),
  ],
  _ => null,
};

Object? comparableGateValue(Gate? value) => switch (value) {
  ManualGate() && final v => [v.id, 'manual', v.key],
  AutoGate() && final v => [v.id, 'auto', v.sensorModel, v.backupId],
  _ => null,
};

Object? comparableTrimValue(Trim? value) => [
  value?.level,
  value?.effectiveLeather,
  comparableUpholsteryValue(value?.upholstery),
];

Object? comparableUpholsteryValue(Upholstery? value) => [
  value?.material,
  value?.color,
  value?.heated,
  value?.rows,
];

Object? comparableDrivetrainValue(Drivetrain? value) => switch (value) {
  FixedDrive() && final v => [v.label, 'fixed', v.axle],
  RangeDrive() && final v => [
    v.label,
    'range',
    v.minRatio,
    v.maxRatio,
    v.locking,
  ],
  _ => null,
};

Object? comparableTruckValue(Truck? value) => switch (value) {
  BoxTruck() && final v => [
    comparableRegistrationValue(v?.registration),
    v.axleCount,
    'box',
    comparableTrimValue(v?.trim),
    v.boxVolume,
  ],
  Tanker() && final v => [
    comparableRegistrationValue(v?.registration),
    v.axleCount,
    'tanker',
    v.capacity,
    v.hazmat,
  ],
  _ => null,
};

Object? comparableBikeValue(Bike? value) => switch (value) {
  RoadBike() && final v => [
    comparableRegistrationValue(v?.registration),
    v.electric,
    'road',
    v.gears,
  ],
  CargoBike() && final v => [
    comparableRegistrationValue(v?.registration),
    v.electric,
    'cargo',
    v.baskets,
    v.assist,
  ],
  _ => null,
};

Object? comparablePolicyValue(Policy? value) => [
  value?.conditions,
  comparablePolicyLimitsValue(value?.limits),
];

Object? comparablePolicyLimitsValue(PolicyLimits? value) => [
  value?.maxSpeed,
  value?.maxLoad,
  value?.escort,
  value?.curfew,
  value?.inspectionDays,
];

Object? comparableDepotSettingsValue(DepotSettings? value) => [
  value?.capacity,
  value?.bays,
  value?.nightShift,
  value?.notes,
];

Object? comparableFleetValue(Fleet? value) => [
  comparableFleetSettingsValue(value?.settings),
  (value?.cars ?? const <Car>[]).map(comparableCarValue).toList(),
  (value?.trucks ?? const <Truck>[]).map(comparableTruckValue).toList(),
  (value?.bikes ?? const <Bike>[]).map(comparableBikeValue).toList(),
  (value?.policies ?? const <Policy>[]).map(comparablePolicyValue).toList(),
  comparableDepotSettingsValue(value?.carDepot),
  comparableDepotSettingsValue(value?.truckDepot),
  comparableDepotSettingsValue(value?.bikeDepot),
];
