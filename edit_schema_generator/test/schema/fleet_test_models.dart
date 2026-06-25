// A deliberately complex test model that mirrors the structure (and the awkward
// cross-cuts) of the real `Config` tree in the input_actions_ui app, so the
// single-tree schema work can be exercised against something representative
// rather than the flat `Car` fixture.
//
// Mapping to the real app model (see single-tree-schema.md):
//
//   Fleet              ≈ Config            (the single root)
//   VehicleCategory    ≈ DeviceType        (discriminates the cross-cutting lists)
//   Car/Truck/Bike     ≈ Mouse/Keyboard/…Gesture (separate sealed lists that all
//                                           share a common sub-object)
//   Registration       ≈ TriggerCommon     (the shared "common", reached from
//                                           every vehicle list)
//   Permit             ≈ TriggerAction     (wrapper: a sealed `detail` field +
//                                           scalar fields), nested in a list
//                                           inside the common
//   PermitDetail       ≈ TriggerAction.action (the sealed payload; here it also
//                                           carries shared fields across cases)
//   Gate               ≈ a sealed element nested *inside* a sealed case's list
//   Trim → Upholstery  ≈ MotionCommon, extended with a deeper nested object
//   Drivetrain         ≈ SwipeMode         (sealed sub-object with shared fields)
//   DepotSettings      ≈ SpeedSettings     (nullable, compacted to null when empty,
//                                           dispatched per category)
//   FleetSettings →    ≈ GlobalSettings, extended with a nested NotificationSettings
//     NotificationSettings
//   Policy             ≈ DeviceRule        (list; a "default" element is found by
//                                           scanning conditions, not by index)
//   PolicyLimits       ≈ DeviceRuleProperties
//   VehicleLocation    ≈ GestureLocation   ({category, index} over 3 lists)
//   PermitLocation     ≈ ActionLocation    ({vehicle, permitIndex} → two indices)
//
// These are plain Dart classes (sealed + copyWith), matching the convention of
// car_schema_test_models.dart; the package does not depend on freezed. Fields
// shared across all cases of a sealed type live on the sealed base as abstract
// getters (≈ a freezed union's common parameters), so the generator's supertype
// traversal and the schema `shared:` path are both exercised.

// ===========================================================================
// Discriminator
// ===========================================================================

const Object _unset = Object();

/// ≈ DeviceType. Selects which cross-cutting vehicle list a [VehicleLocation]
/// addresses.
enum VehicleCategory { car, truck, bike }

// ===========================================================================
// Conditions (≈ Condition) — used by the scan-addressed default policy
// ===========================================================================

sealed class PolicyCondition {
  const PolicyCondition();
}

/// ≈ VariableCondition. The default policy for a region is the one whose
/// condition is a [RegionCondition] matching that region — found by scanning,
/// never by a static index.
final class RegionCondition extends PolicyCondition {
  const RegionCondition({
    required this.region,
    this.operator = '==',
    this.value = 'true',
    this.negate = false,
  });

  final String region;
  final String operator;
  final String value;
  final bool negate;

  RegionCondition copyWith({
    String? region,
    String? operator,
    String? value,
    bool? negate,
  }) => RegionCondition(
    region: region ?? this.region,
    operator: operator ?? this.operator,
    value: value ?? this.value,
    negate: negate ?? this.negate,
  );
}

final class AlwaysCondition extends PolicyCondition {
  const AlwaysCondition();
}

// ===========================================================================
// Gate (≈ a sealed element nested inside a sealed permit case's list) — has a
// field `id` shared across every case.
// ===========================================================================

sealed class Gate {
  const Gate();

  /// Shared across all gate cases.
  String get id;

  Gate copyWith({String? id});

  Gate copyWithId(String id);
}

final class ManualGate extends Gate {
  const ManualGate({required this.id, this.key});

  @override
  final String id;
  final String? key;

  @override
  ManualGate copyWithId(String id) => copyWith(id: id);

  @override
  ManualGate copyWith({String? id, String? key}) =>
      ManualGate(id: id ?? this.id, key: key ?? this.key);
}

final class AutoGate extends Gate {
  const AutoGate({required this.id, this.sensorModel, this.backupId});

  @override
  final String id;
  final String? sensorModel;
  final String? backupId;

  @override
  AutoGate copyWithId(String id) => copyWith(id: id);

  @override
  AutoGate copyWith({String? id, String? sensorModel, String? backupId}) =>
      AutoGate(
        id: id ?? this.id,
        sensorModel: sensorModel ?? this.sensorModel,
        backupId: backupId ?? this.backupId,
      );
}

// ===========================================================================
// Permit detail (≈ TriggerAction.action) — sealed payload with fields shared
// across every case (`authority`, `revoked`) plus per-case fields.
// ===========================================================================

sealed class PermitDetail {
  const PermitDetail();

  /// Shared across all detail cases (≈ a sealed union's common parameters).
  String? get authority;
  bool? get revoked;

  PermitDetail copyWith({String? authority, bool? revoked});
}

/// ≈ CommandAction { command, wait }. `hours` is nullable with an effective
/// getter, to exercise compare-via-effective on a sealed case.
final class ParkingPermit extends PermitDetail {
  const ParkingPermit({
    required this.zone,
    this.hours,
    this.authority,
    this.revoked,
  });

  final String zone;
  final int? hours;

  @override
  final String? authority;
  @override
  final bool? revoked;

  @override
  ParkingPermit copyWith({
    String? zone,
    int? hours,
    String? authority,
    bool? revoked,
  }) => ParkingPermit(
    zone: zone ?? this.zone,
    hours: hours ?? this.hours,
    authority: authority ?? this.authority,
    revoked: revoked ?? this.revoked,
  );
}

/// ≈ PlasmaShortcutAction { component, shortcut }.
final class TollPermit extends PermitDetail {
  const TollPermit({
    required this.account,
    required this.balance,
    this.authority,
    this.revoked,
  });

  final String account;
  final double balance;

  @override
  final String? authority;
  @override
  final bool? revoked;

  @override
  TollPermit copyWith({
    String? account,
    double? balance,
    String? authority,
    bool? revoked,
  }) => TollPermit(
    account: account ?? this.account,
    balance: balance ?? this.balance,
    authority: authority ?? this.authority,
    revoked: revoked ?? this.revoked,
  );
}

/// ≈ InputAction { entries } — but the list elements are themselves a sealed
/// [Gate], so this nests a sealed list inside a sealed case inside a list.
final class AccessPermit extends PermitDetail {
  const AccessPermit({this.gates = const [], this.authority, this.revoked});

  final List<Gate> gates;

  @override
  final String? authority;
  @override
  final bool? revoked;

  @override
  AccessPermit copyWith({
    List<Gate>? gates,
    String? authority,
    bool? revoked,
  }) => AccessPermit(
    gates: gates ?? this.gates,
    authority: authority ?? this.authority,
    revoked: revoked ?? this.revoked,
  );
}

// ===========================================================================
// Permit (≈ TriggerAction) — wrapper: sealed `detail` + scalar fields
// ===========================================================================

final class Permit {
  const Permit({
    required this.detail,
    this.label,
    this.priority,
    this.repeat,
    this.enabled,
    this.editId,
  });

  /// The sealed payload (≈ TriggerAction.action).
  final PermitDetail detail;
  final String? label;
  final int? priority;

  /// Nullable with an effective getter (≈ effectiveWait) — see [PermitEffective].
  final int? repeat;
  final bool? enabled;

  /// In-memory identity, excluded from comparison (≈ TriggerCommon.editId).
  final int? editId;

  Permit copyWith({
    PermitDetail? detail,
    String? label,
    int? priority,
    int? repeat,
    bool? enabled,
    int? editId,
  }) => Permit(
    detail: detail ?? this.detail,
    label: label ?? this.label,
    priority: priority ?? this.priority,
    repeat: repeat ?? this.repeat,
    enabled: enabled ?? this.enabled,
    editId: editId ?? this.editId,
  );
}

extension PermitEffective on Permit {
  int get effectiveRepeat => repeat ?? 1;
}

// ===========================================================================
// Registration (≈ TriggerCommon) — the shared "common", reached from every
// vehicle list, and itself holding a nested list of sealed Permits.
// ===========================================================================

final class Registration {
  const Registration({
    this.plate,
    this.vin,
    this.region,
    this.active,
    this.locked,
    this.tags = const [],
    this.notes,
    this.permits = const [],
    this.editId,
  });

  final String? plate;
  final String? vin;
  final String? region;

  /// Nullable tri-state with effective default (≈ enabled/effectiveEnabled).
  final bool? active;
  final bool? locked;
  final List<String> tags;
  final String? notes;

  /// Nested list of sealed wrappers (≈ TriggerCommon.actions). Addressed by
  /// [PermitLocation] (vehicle + permitIndex → two list indices).
  final List<Permit> permits;

  /// In-memory identity, excluded from comparison.
  final int? editId;

  Registration copyWith({
    String? plate,
    String? vin,
    String? region,
    bool? active,
    bool? locked,
    List<String>? tags,
    String? notes,
    List<Permit>? permits,
    int? editId,
  }) => Registration(
    plate: plate ?? this.plate,
    vin: vin ?? this.vin,
    region: region ?? this.region,
    active: active ?? this.active,
    locked: locked ?? this.locked,
    tags: tags ?? this.tags,
    notes: notes ?? this.notes,
    permits: permits ?? this.permits,
    editId: editId ?? this.editId,
  );
}

/// Effective getters declared as an extension (≈ effective_config_values.dart).
/// The generator finds these via static type resolution on the projection
/// closure, not via class-member lookup.
extension RegistrationEffective on Registration {
  bool get effectiveActive => active ?? true;
  bool get effectiveLocked => locked ?? false;
}

// ===========================================================================
// Per-case shared sub-objects (≈ MotionCommon / SwipeMode), now with deeper
// nesting and shared sealed fields.
// ===========================================================================

/// Nested one level below [Trim] (Car case → trim → upholstery → fields).
final class Upholstery {
  const Upholstery({
    this.material,
    this.color,
    this.heated,
    this.rows = const [],
  });

  final String? material;
  final String? color;
  final bool? heated;
  final List<int> rows;

  Upholstery copyWith({
    String? material,
    String? color,
    bool? heated,
    List<int>? rows,
  }) => Upholstery(
    material: material ?? this.material,
    color: color ?? this.color,
    heated: heated ?? this.heated,
    rows: rows ?? this.rows,
  );
}

/// ≈ MotionCommon, with a nested [Upholstery] child.
final class Trim {
  const Trim({this.level, this.leather, this.upholstery = const Upholstery()});

  final String? level;
  final bool? leather;
  final Upholstery upholstery;

  Trim copyWith({String? level, bool? leather, Upholstery? upholstery}) => Trim(
    level: level ?? this.level,
    leather: leather ?? this.leather,
    upholstery: upholstery ?? this.upholstery,
  );
}

extension TrimEffective on Trim {
  bool get effectiveLeather => leather ?? false;
}

/// ≈ SwipeMode. A sealed sub-object with a field (`label`) shared across cases.
sealed class Drivetrain {
  const Drivetrain();

  String? get label;

  Drivetrain copyWith({String? label});
}

final class FixedDrive extends Drivetrain {
  const FixedDrive({required this.axle, this.label});

  final String axle;

  @override
  final String? label;

  @override
  FixedDrive copyWith({String? axle, String? label}) =>
      FixedDrive(axle: axle ?? this.axle, label: label ?? this.label);
}

final class RangeDrive extends Drivetrain {
  const RangeDrive({
    required this.minRatio,
    required this.maxRatio,
    this.locking = false,
    this.label,
  });

  final double minRatio;
  final double maxRatio;
  final bool locking;

  @override
  final String? label;

  @override
  RangeDrive copyWith({
    double? minRatio,
    double? maxRatio,
    bool? locking,
    String? label,
  }) => RangeDrive(
    minRatio: minRatio ?? this.minRatio,
    maxRatio: maxRatio ?? this.maxRatio,
    locking: locking ?? this.locking,
    label: label ?? this.label,
  );
}

// ===========================================================================
// Vehicle lists (≈ Mouse/Keyboard/…Gesture): three independent sealed types,
// each case carrying the shared [Registration] AND shared scalar fields
// (`color`, `year`), plus case-specific fields. The shared members live on the
// sealed base so the cross-cutting "set the common on any vehicle" dispatch has
// a uniform hook (≈ withCommon / gestureCommonOf).
// ===========================================================================

/// Common supertype of the cross-cutting vehicle lists. A `taggedLists`
/// discriminator returns `Lens<Fleet, Vehicle>` and reaches the shared `registration` through it.
abstract interface class Vehicle {
  Registration get registration;
  Vehicle copyWithRegistration(Registration registration);
}

sealed class Car implements Vehicle {
  const Car();

  @override
  Registration get registration;

  /// Shared across all car cases (≈ a sealed union's common parameters).
  String get color;
  int? get year;

  Car copyWith({Registration? registration, String? color, int? year});

  @override
  Car copyWithRegistration(Registration registration);
}

final class Sedan extends Car {
  const Sedan({
    required this.registration,
    this.color = 'white',
    this.year,
    this.trim = const Trim(),
  });

  @override
  final Registration registration;
  @override
  final String color;
  @override
  final int? year;
  final Trim trim;

  @override
  Sedan copyWithRegistration(Registration registration) =>
      copyWith(registration: registration);

  @override
  Sedan copyWith({
    Registration? registration,
    String? color,
    int? year,
    Trim? trim,
  }) => Sedan(
    registration: registration ?? this.registration,
    color: color ?? this.color,
    year: year ?? this.year,
    trim: trim ?? this.trim,
  );
}

final class Coupe extends Car {
  const Coupe({
    required this.registration,
    this.color = 'white',
    this.year,
    this.trim = const Trim(),
    this.drivetrain = const FixedDrive(axle: 'rear'),
    this.topSpeed,
  });

  @override
  final Registration registration;
  @override
  final String color;
  @override
  final int? year;
  final Trim trim;
  final Drivetrain drivetrain;
  final int? topSpeed;

  @override
  Coupe copyWithRegistration(Registration registration) =>
      copyWith(registration: registration);

  @override
  Coupe copyWith({
    Registration? registration,
    String? color,
    int? year,
    Trim? trim,
    Drivetrain? drivetrain,
    int? topSpeed,
  }) => Coupe(
    registration: registration ?? this.registration,
    color: color ?? this.color,
    year: year ?? this.year,
    trim: trim ?? this.trim,
    drivetrain: drivetrain ?? this.drivetrain,
    topSpeed: topSpeed ?? this.topSpeed,
  );
}

final class Convertible extends Car {
  const Convertible({
    required this.registration,
    this.color = 'white',
    this.year,
    this.trim = const Trim(),
    this.roofOpen,
  });

  @override
  final Registration registration;
  @override
  final String color;
  @override
  final int? year;
  final Trim trim;
  final bool? roofOpen;

  @override
  Convertible copyWithRegistration(Registration registration) =>
      copyWith(registration: registration);

  @override
  Convertible copyWith({
    Registration? registration,
    String? color,
    int? year,
    Trim? trim,
    bool? roofOpen,
  }) => Convertible(
    registration: registration ?? this.registration,
    color: color ?? this.color,
    year: year ?? this.year,
    trim: trim ?? this.trim,
    roofOpen: roofOpen ?? this.roofOpen,
  );
}

sealed class Truck implements Vehicle {
  const Truck();

  @override
  Registration get registration;

  /// Shared across all truck cases.
  int? get axleCount;

  Truck copyWith({Registration? registration, int? axleCount});

  @override
  Truck copyWithRegistration(Registration registration);
}

final class BoxTruck extends Truck {
  const BoxTruck({
    required this.registration,
    this.axleCount,
    this.trim = const Trim(),
    this.boxVolume,
  });

  @override
  final Registration registration;
  @override
  final int? axleCount;
  final Trim trim;
  final double? boxVolume;

  @override
  BoxTruck copyWithRegistration(Registration registration) =>
      copyWith(registration: registration);

  @override
  BoxTruck copyWith({
    Registration? registration,
    int? axleCount,
    Trim? trim,
    double? boxVolume,
  }) => BoxTruck(
    registration: registration ?? this.registration,
    axleCount: axleCount ?? this.axleCount,
    trim: trim ?? this.trim,
    boxVolume: boxVolume ?? this.boxVolume,
  );
}

final class Tanker extends Truck {
  const Tanker({
    required this.registration,
    this.axleCount,
    this.capacity,
    this.hazmat,
  });

  @override
  final Registration registration;
  @override
  final int? axleCount;
  final double? capacity;
  final bool? hazmat;

  @override
  Tanker copyWithRegistration(Registration registration) =>
      copyWith(registration: registration);

  @override
  Tanker copyWith({
    Registration? registration,
    int? axleCount,
    double? capacity,
    bool? hazmat,
  }) => Tanker(
    registration: registration ?? this.registration,
    axleCount: axleCount ?? this.axleCount,
    capacity: capacity ?? this.capacity,
    hazmat: hazmat ?? this.hazmat,
  );
}

sealed class Bike implements Vehicle {
  const Bike();

  @override
  Registration get registration;

  /// Shared across all bike cases.
  bool? get electric;

  Bike copyWith({Registration? registration, bool? electric});

  @override
  Bike copyWithRegistration(Registration registration);
}

final class RoadBike extends Bike {
  const RoadBike({required this.registration, this.electric, this.gears});

  @override
  final Registration registration;
  @override
  final bool? electric;
  final int? gears;

  @override
  RoadBike copyWithRegistration(Registration registration) =>
      copyWith(registration: registration);

  @override
  RoadBike copyWith({Registration? registration, bool? electric, int? gears}) =>
      RoadBike(
        registration: registration ?? this.registration,
        electric: electric ?? this.electric,
        gears: gears ?? this.gears,
      );
}

final class CargoBike extends Bike {
  const CargoBike({
    required this.registration,
    this.electric,
    this.baskets,
    this.assist,
  });

  @override
  final Registration registration;
  @override
  final bool? electric;
  final int? baskets;
  final bool? assist;

  @override
  CargoBike copyWithRegistration(Registration registration) =>
      copyWith(registration: registration);

  @override
  CargoBike copyWith({
    Registration? registration,
    bool? electric,
    int? baskets,
    bool? assist,
  }) => CargoBike(
    registration: registration ?? this.registration,
    electric: electric ?? this.electric,
    baskets: baskets ?? this.baskets,
    assist: assist ?? this.assist,
  );
}

// ===========================================================================
// Depot settings (≈ SpeedSettings) — nullable on the root, dispatched per
// category, compacted to null when empty.
// ===========================================================================

final class DepotSettings {
  const DepotSettings({this.capacity, this.bays, this.nightShift, this.notes});

  final int? capacity;
  final int? bays;
  final bool? nightShift;
  final String? notes;

  /// Drives "compact to null on empty" set semantics (≈ SpeedSettings.isEmpty).
  bool get isEmpty =>
      capacity == null && bays == null && nightShift == null && notes == null;

  DepotSettings copyWith({
    Object? capacity = _unset,
    Object? bays = _unset,
    Object? nightShift = _unset,
    Object? notes = _unset,
  }) => DepotSettings(
    capacity: identical(capacity, _unset) ? this.capacity : capacity as int?,
    bays: identical(bays, _unset) ? this.bays : bays as int?,
    nightShift: identical(nightShift, _unset)
        ? this.nightShift
        : nightShift as bool?,
    notes: identical(notes, _unset) ? this.notes : notes as String?,
  );
}

// ===========================================================================
// Fleet settings (≈ GlobalSettings) — single non-null sub-object on the root,
// now with a further-nested [NotificationSettings] child. Exercises the
// "no-location root child" case AND a child-of-a-child.
// ===========================================================================

final class NotificationSettings {
  const NotificationSettings({this.email, this.sms, this.webhookUrl});

  final bool? email;
  final bool? sms;
  final String? webhookUrl;

  NotificationSettings copyWith({bool? email, bool? sms, String? webhookUrl}) =>
      NotificationSettings(
        email: email ?? this.email,
        sms: sms ?? this.sms,
        webhookUrl: webhookUrl ?? this.webhookUrl,
      );
}

final class FleetSettings {
  const FleetSettings({
    this.autoSync,
    this.alerts,
    this.region,
    this.emergencyContacts,
    this.notifications = const NotificationSettings(),
  });

  final bool? autoSync;
  final bool? alerts;
  final String? region;
  final List<String>? emergencyContacts;
  final NotificationSettings notifications;

  FleetSettings copyWith({
    bool? autoSync,
    bool? alerts,
    String? region,
    List<String>? emergencyContacts,
    NotificationSettings? notifications,
  }) => FleetSettings(
    autoSync: autoSync ?? this.autoSync,
    alerts: alerts ?? this.alerts,
    region: region ?? this.region,
    emergencyContacts: emergencyContacts ?? this.emergencyContacts,
    notifications: notifications ?? this.notifications,
  );
}

extension FleetSettingsEffective on FleetSettings {
  bool get effectiveAutoSync => autoSync ?? true;
}

// ===========================================================================
// Policy (≈ DeviceRule) — list element with a condition and a properties bag.
// The "default policy for a region" is found by scanning, not indexing.
// ===========================================================================

final class PolicyLimits {
  const PolicyLimits({
    this.maxSpeed,
    this.maxLoad,
    this.escort,
    this.curfew,
    this.inspectionDays,
  });

  final int? maxSpeed;
  final double? maxLoad;
  final bool? escort;
  final int? curfew;
  final int? inspectionDays;

  bool get isEmpty =>
      maxSpeed == null &&
      maxLoad == null &&
      escort == null &&
      curfew == null &&
      inspectionDays == null;

  PolicyLimits copyWith({
    int? maxSpeed,
    double? maxLoad,
    bool? escort,
    int? curfew,
    int? inspectionDays,
  }) => PolicyLimits(
    maxSpeed: maxSpeed ?? this.maxSpeed,
    maxLoad: maxLoad ?? this.maxLoad,
    escort: escort ?? this.escort,
    curfew: curfew ?? this.curfew,
    inspectionDays: inspectionDays ?? this.inspectionDays,
  );
}

final class Policy {
  const Policy({this.conditions, this.limits = const PolicyLimits()});

  final PolicyCondition? conditions;
  final PolicyLimits limits;

  Policy copyWith({PolicyCondition? conditions, PolicyLimits? limits}) =>
      Policy(
        conditions: conditions ?? this.conditions,
        limits: limits ?? this.limits,
      );
}

// ===========================================================================
// Fleet (≈ Config) — the single root.
// ===========================================================================

final class Fleet {
  const Fleet({
    this.cars = const [],
    this.trucks = const [],
    this.bikes = const [],
    this.policies = const [],
    this.carDepot,
    this.truckDepot,
    this.bikeDepot,
    this.settings = const FleetSettings(),
  });

  // Cross-cutting sealed lists, all sharing [Registration] (≈ the 5 gesture
  // lists). Addressed uniformly by [VehicleLocation].
  final List<Car> cars;
  final List<Truck> trucks;
  final List<Bike> bikes;

  // ≈ deviceRules: a list whose "default for region X" element is scan-addressed.
  final List<Policy> policies;

  // ≈ mouse/touchpad/touchscreenSpeed: per-category nullable settings.
  final DepotSettings? carDepot;
  final DepotSettings? truckDepot;
  final DepotSettings? bikeDepot;

  // ≈ globalSettings.
  final FleetSettings settings;

  Fleet copyWith({
    List<Car>? cars,
    List<Truck>? trucks,
    List<Bike>? bikes,
    List<Policy>? policies,
    Object? carDepot = _unset,
    Object? truckDepot = _unset,
    Object? bikeDepot = _unset,
    FleetSettings? settings,
  }) => Fleet(
    cars: cars ?? this.cars,
    trucks: trucks ?? this.trucks,
    bikes: bikes ?? this.bikes,
    policies: policies ?? this.policies,
    carDepot: identical(carDepot, _unset)
        ? this.carDepot
        : carDepot as DepotSettings?,
    truckDepot: identical(truckDepot, _unset)
        ? this.truckDepot
        : truckDepot as DepotSettings?,
    bikeDepot: identical(bikeDepot, _unset)
        ? this.bikeDepot
        : bikeDepot as DepotSettings?,
    settings: settings ?? this.settings,
  );

  /// ≈ Config.speedForDevice. Dispatches the nullable depot slot by category.
  DepotSettings? depotFor(VehicleCategory category) => switch (category) {
    VehicleCategory.car => carDepot,
    VehicleCategory.truck => truckDepot,
    VehicleCategory.bike => bikeDepot,
  };

  /// ≈ Config.gesturesForDevice. The cross-cut: one coordinate, three lists.
  List<Object> vehiclesFor(VehicleCategory category) => switch (category) {
    VehicleCategory.car => cars,
    VehicleCategory.truck => trucks,
    VehicleCategory.bike => bikes,
  };
}

// ===========================================================================
// Locations (≈ dirty_locations.dart)
// ===========================================================================

/// ≈ GestureLocation{device, index}. One coordinate over three sealed lists.
final class VehicleLocation {
  const VehicleLocation({required this.category, required this.index});

  final VehicleCategory category;
  final int index;
}

/// ≈ ActionLocation{gesture, actionIndex}. A path with two list indices:
/// fleet → vehiclesFor(category)[vehicle.index] → registration → permits[permitIndex].
final class PermitLocation {
  const PermitLocation({required this.vehicle, required this.permitIndex});

  final VehicleLocation vehicle;
  final int permitIndex;
}

/// Like [VehicleLocation] but with deliberately non-default field names (`kind`
/// instead of `category`, `slot` instead of `index`) to prove the `taggedLists`
/// discriminator/index fields are configurable.
final class GarageLocation {
  const GarageLocation({required this.kind, required this.slot});

  final VehicleCategory kind;
  final int slot;
}
