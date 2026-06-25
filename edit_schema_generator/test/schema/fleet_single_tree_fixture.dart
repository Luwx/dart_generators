import 'package:edit_schema_generator/edit_schema_generator.dart';

import 'fleet_test_models.dart';

part 'fleet_single_tree_fixture.g.dart';

int? _defaultPolicyIndex(Fleet fleet, String region) {
  for (var i = 0; i < fleet.policies.length; i++) {
    final condition = fleet.policies[i].conditions;
    if (condition is RegionCondition && condition.region == region) return i;
  }
  return null;
}

Lens<PolicyLimits> defaultPolicyLimitsLens(String region) => Lens<PolicyLimits>(
  get: (root) {
    final fleet = root as Fleet;
    final index = _defaultPolicyIndex(fleet, region);
    return index == null ? const PolicyLimits() : fleet.policies[index].limits;
  },
  set: (root, next) {
    final fleet = root as Fleet;
    final compacted = next.isEmpty;
    final index = _defaultPolicyIndex(fleet, region);
    if (index == null) {
      if (compacted) return fleet;
      return addPolicy(
        fleet,
        Policy(
          conditions: RegionCondition(region: region),
          limits: next,
        ),
      );
    }
    if (compacted) return removePolicyAt(fleet, index);
    return updatePolicyAt(
      fleet,
      index,
      (policy) => policy.copyWith(limits: next),
    );
  },
  name: 'defaultPolicy[$region].limits',
);

final upholsteryNode = subtree<Upholstery>(
  fields: [prop('material'), prop('color'), prop('heated'), prop('rows')],
);

final trimNode = subtree<Trim>(
  fields: [
    prop('level'),
    prop('leather', compare: projected((Trim? t) => t?.effectiveLeather)),
    child('upholstery', node: upholsteryNode),
  ],
);

final drivetrainNode = subtree<Drivetrain>(
  shared: [prop('label')],
  cases: [
    valueCase<FixedDrive>('fixed', fields: [prop('axle')]),
    valueCase<RangeDrive>(
      'range',
      fields: [prop('minRatio'), prop('maxRatio'), prop('locking')],
    ),
  ],
);

final gateNode = subtree<Gate>(
  shared: [prop('id')],
  cases: [
    valueCase<ManualGate>('manual', fields: [prop('key')]),
    valueCase<AutoGate>(
      'auto',
      fields: [prop('sensorModel'), prop('backupId')],
    ),
  ],
);

final permitNode = subtree<Permit>(
  fields: [
    sealed(
      'detail',
      shared: [prop('authority'), prop('revoked')],
      cases: [
        valueCase<ParkingPermit>(
          'parking',
          fields: [prop('zone'), prop('hours', orElse: 0)],
        ),
        valueCase<TollPermit>(
          'toll',
          fields: [prop('account'), prop('balance')],
        ),
        valueCase<AccessPermit>(
          'access',
          fields: [list('gates', of: gateNode)],
        ),
      ],
    ),
    prop('label'),
    prop('priority'),
    prop('repeat', compare: projected((Permit? p) => p?.effectiveRepeat)),
    prop('enabled'),
  ],
);

final registrationNode = subtree<Registration>(
  fields: [
    prop('plate'),
    prop('vin'),
    prop('region'),
    prop(
      'active',
      readOnly: true,
      compare: projected((Registration? r) => r?.effectiveActive),
    ),
    prop('locked', compare: projected((Registration? r) => r?.effectiveLocked)),
    prop('tags'),
    prop('notes'),
    list('permits', of: permitNode),
  ],
  groups: [
    editGroup(id: 'identity', members: ['plate', 'vin']),
    editGroup(id: 'audit', members: ['plate', 'region', 'active', 'notes']),
  ],
);

final carNode = subtree<Car>(
  fields: [
    child('registration', node: registrationNode),
    prop('color'),
    prop('year'),
  ],
  cases: [
    valueCase<Sedan>('sedan', fields: [child('trim', node: trimNode)]),
    valueCase<Coupe>(
      'coupe',
      fields: [
        child('trim', node: trimNode),
        child('drivetrain', node: drivetrainNode),
        prop('topSpeed'),
      ],
    ),
    valueCase<Convertible>(
      'convertible',
      fields: [
        child('trim', node: trimNode),
        prop('roofOpen', orElse: false),
      ],
    ),
  ],
);

final truckNode = subtree<Truck>(
  fields: [
    child('registration', node: registrationNode),
    prop('axleCount'),
  ],
  cases: [
    valueCase<BoxTruck>(
      'box',
      fields: [
        child('trim', node: trimNode),
        prop('boxVolume'),
      ],
    ),
    valueCase<Tanker>('tanker', fields: [prop('capacity'), prop('hazmat')]),
  ],
);

final bikeNode = subtree<Bike>(
  fields: [
    child('registration', node: registrationNode),
    prop('electric'),
  ],
  cases: [
    valueCase<RoadBike>('road', fields: [prop('gears')]),
    valueCase<CargoBike>('cargo', fields: [prop('baskets'), prop('assist')]),
  ],
);

/// Stands in for a meta_generator-produced `DepotSettingsMeta`: name constants
/// whose value equals their name (and `self` == the class name). Used to prove
/// the schema accepts `<Class>Meta.field` references in place of raw strings.
abstract final class DepotSettingsMeta {
  static const String self = 'DepotSettings';
  static const String capacity = 'capacity';
  static const String bays = 'bays';
  static const String nightShift = 'nightShift';
  static const String notes = 'notes';
}

final depotNode = subtree<DepotSettings>(
  compactWhen: (DepotSettings d) => d.isEmpty,
  fields: [
    prop(DepotSettingsMeta.capacity),
    prop(DepotSettingsMeta.bays),
    prop(DepotSettingsMeta.nightShift),
    prop(DepotSettingsMeta.notes),
  ],
);

final policyNode = subtree<Policy>(
  fields: [
    prop('conditions'),
    child(
      'limits',
      fields: [
        prop('maxSpeed'),
        prop('maxLoad'),
        prop('escort'),
        prop('curfew'),
        prop('inspectionDays'),
      ],
    ),
  ],
);

@GenerateEditSchema()
final fleetTree = editTree<Fleet>(
  fields: [
    child(
      'settings',
      fields: [
        prop(
          'autoSync',
          compare: projected((FleetSettings? s) => s?.effectiveAutoSync),
        ),
        prop('alerts'),
        prop('region'),
        prop('emergencyContacts'),
        child(
          'notifications',
          fields: [prop('email'), prop('sms'), prop('webhookUrl')],
        ),
      ],
    ),
    list('cars', of: carNode, name: 'car'),
    list('trucks', of: truckNode, name: 'truck'),
    list('bikes', of: bikeNode, name: 'bike'),
    list('policies', of: policyNode),
    dispatch<VehicleCategory>(
      lens: 'depotSettingsLens',
      node: depotNode,
      name: 'depot',
      branches: {
        VehicleCategory.car: 'carDepot',
        VehicleCategory.truck: 'truckDepot',
        VehicleCategory.bike: 'bikeDepot',
      },
    ),
  ],
);
