// Test base for the single-tree schema work (see single-tree-schema.md).
//
// The `Fleet` model in fleet_test_models.dart mirrors the real `Config` tree and
// its cross-cuts. This file has two jobs:
//
//  1. LIVE tests that lock the model shape and its dispatch helpers, so the
//     fixture/codegen work builds on a stable base. These run today.
//
//  2. SKIPPED specs — one per behavior the single-tree generator must satisfy.
//     They are intentionally empty (the `editTree` DSL and the generated symbols
//     do not exist yet), and each carries a comment describing the expected
//     generated symbol and assertion. As the implementation lands, fill the body
//     and drop the `skip:`.
//
// ---------------------------------------------------------------------------
// Intended target fixture (does NOT compile yet — the primitives are unbuilt).
// Reproduced here so the spec tests below have a concrete reference. Keep in
// sync with the "ideal" section of single-tree-schema.md.
//
//   @GenerateEditSchema()
//   final fleetTree = editTree<Fleet>(fields: [
//     child('settings', fields: [
//       prop('autoSync', compare: projected((s) => s?.effectiveAutoSync)),
//       prop('alerts'), prop('region'), prop('emergencyContacts'),
//       child('notifications', fields: [          // child-of-a-child
//         prop('email'), prop('sms'), prop('webhookUrl'),
//       ]),
//     ]),
//
//     // Cross-cut: one VehicleLocation{category,index} over three sealed lists,
//     // each sharing `registration` + `color`/`year`/… (shared sealed fields).
//     taggedLists(
//       by: VehicleCategory.values,
//       lists: {
//         VehicleCategory.car:   ('cars',   carNode),
//         VehicleCategory.truck: ('trucks', truckNode),
//         VehicleCategory.bike:  ('bikes',  bikeNode),
//       },
//     ),
//
//     list('policies', of: policyNode),
//     nullable('carDepot',   node: depotNode),
//     nullable('truckDepot', node: depotNode),
//     nullable('bikeDepot',  node: depotNode),
//   ]);
//
//   final registrationNode = subtree<Registration>(fields: [
//     prop('plate'), prop('vin'), prop('region'),
//     prop('active', readOnly: true, compare: projected((r) => r?.effectiveActive)),
//     prop('locked', compare: projected((r) => r?.effectiveLocked)),
//     prop('tags'), prop('notes'),
//     list('permits', of: permitNode),
//   ]);
//
//   final permitNode = subtree<Permit>(fields: [
//     sealed('detail',
//       shared: [prop('authority'), prop('revoked')],   // shared across cases
//       cases: [
//         valueCase<ParkingPermit>('parking', fields: [prop('zone'), prop('hours', orElse: 0)]),
//         valueCase<TollPermit>('toll', fields: [prop('account'), prop('balance')]),
//         valueCase<AccessPermit>('access', fields: [list('gates', of: gateNode)]),
//       ],
//     ),
//     prop('label'), prop('priority'),
//     prop('repeat', compare: projected((p) => p?.effectiveRepeat)),
//     prop('enabled'),
//   ]);
//
//   // Sealed element nested inside a sealed case's list, with a shared `id`.
//   final gateNode = subtree<Gate>(
//     shared: [prop('id')],
//     cases: [
//       valueCase<ManualGate>('manual', fields: [prop('key')]),
//       valueCase<AutoGate>('auto', fields: [prop('sensorModel'), prop('backupId')]),
//     ],
//   );
//
//   final upholsteryNode = subtree<Upholstery>(fields: [
//     prop('material'), prop('color'), prop('heated'), prop('rows'),
//   ]);
//   final trimNode = subtree<Trim>(fields: [
//     prop('level'),
//     prop('leather', compare: projected((t) => t?.effectiveLeather)),
//     child('upholstery', node: upholsteryNode),   // deeper nesting
//   ]);
//   final drivetrainNode = subtree<Drivetrain>(
//     shared: [prop('label')],                      // shared across sealed cases
//     cases: [
//       valueCase<FixedDrive>('fixed', fields: [prop('axle')]),
//       valueCase<RangeDrive>('range', fields: [prop('minRatio'), prop('maxRatio'), prop('locking')]),
//     ],
//   );
//
//   final carNode = subtree<Car>(
//     // shared across every car case (≈ a sealed union's common parameters):
//     fields: [child('registration', node: registrationNode), prop('color'), prop('year')],
//     cases: [
//       valueCase<Sedan>('sedan', fields: [child('trim', node: trimNode)]),
//       valueCase<Coupe>('coupe', fields: [
//         child('trim', node: trimNode), child('drivetrain', node: drivetrainNode), prop('topSpeed'),
//       ]),
//       valueCase<Convertible>('convertible', fields: [
//         child('trim', node: trimNode), prop('roofOpen', orElse: false),
//       ]),
//     ],
//   );
//   // truckNode (shared axleCount) / bikeNode (shared electric): same shape.
//
//   final depotNode = subtree<DepotSettings>(
//     compactWhen: (d) => d.isEmpty,
//     fields: [prop('capacity'), prop('bays'), prop('nightShift'), prop('notes')],
//   );
//   final policyNode = subtree<Policy>(fields: [
//     prop('conditions'),
//     child('limits', fields: [prop('maxSpeed'), prop('maxLoad'), prop('escort'),
//       prop('curfew'), prop('inspectionDays')]),
//   ]);
// ---------------------------------------------------------------------------

import 'package:test/test.dart';

import 'fleet_single_tree_fixture.dart' as tree;
import 'fleet_test_models.dart';

void main() {
  // =========================================================================
  // LIVE: model shape + dispatch helpers (the stable base the codegen targets).
  // =========================================================================
  group('fleet model (base)', () {
    final fleet = Fleet(
      cars: [
        Sedan(
          registration: const Registration(plate: 'CAR-1', active: true),
          color: 'red',
          year: 2022,
          trim: const Trim(
            level: 'lux',
            leather: true,
            upholstery: Upholstery(
              material: 'nappa',
              heated: true,
              rows: [1, 2],
            ),
          ),
        ),
        const Coupe(
          registration: Registration(plate: 'CAR-2'),
          drivetrain: RangeDrive(
            minRatio: 1,
            maxRatio: 6,
            locking: true,
            label: 'sport',
          ),
          topSpeed: 250,
        ),
      ],
      trucks: const [
        BoxTruck(registration: Registration(plate: 'TRK-1'), axleCount: 3),
      ],
      bikes: const [
        RoadBike(registration: Registration(plate: 'BIKE-1'), electric: true),
      ],
      policies: const [
        Policy(
          conditions: RegionCondition(region: 'north'),
          limits: PolicyLimits(maxSpeed: 90, escort: true),
        ),
      ],
      carDepot: const DepotSettings(capacity: 40, bays: 4),
      settings: const FleetSettings(
        autoSync: true,
        region: 'eu',
        notifications: NotificationSettings(
          email: true,
          webhookUrl: 'https://x',
        ),
      ),
    );

    test('vehicle lists share the registration common across categories', () {
      expect(fleet.cars.first.registration.plate, 'CAR-1');
      expect(fleet.trucks.first.registration.plate, 'TRK-1');
      expect(fleet.bikes.first.registration.plate, 'BIKE-1');
    });

    test('sealed vehicle bases expose shared scalar fields', () {
      // color/year on Car, axleCount on Truck, electric on Bike — reachable on
      // the sealed base regardless of case.
      final Car car = fleet.cars.first;
      expect(car.color, 'red');
      expect(car.year, 2022);
      final Truck truck = fleet.trucks.first;
      expect(truck.axleCount, 3);
      final Bike bike = fleet.bikes.first;
      expect(bike.electric, isTrue);
    });

    test('copyWithRegistration is uniform across sealed vehicle cases', () {
      final Car updated = fleet.cars.first.copyWithRegistration(
        fleet.cars.first.registration.copyWith(active: false),
      );
      expect(updated.registration.active, isFalse);
      expect(updated, isA<Sedan>());
      expect(updated.color, 'red'); // shared field preserved
    });

    test('depotFor / vehiclesFor dispatch the cross-cutting slots', () {
      expect(fleet.depotFor(VehicleCategory.car)?.capacity, 40);
      expect(fleet.depotFor(VehicleCategory.bike), isNull);
      expect(fleet.vehiclesFor(VehicleCategory.truck), fleet.trucks);
    });

    test('deep nesting: trim → upholstery round-trips', () {
      final sedan = fleet.cars.first as Sedan;
      expect(sedan.trim.upholstery.material, 'nappa');
      expect(sedan.trim.upholstery.rows, [1, 2]);
      final updated = sedan.copyWith(
        trim: sedan.trim.copyWith(
          upholstery: sedan.trim.upholstery.copyWith(heated: false),
        ),
      );
      expect(updated.trim.upholstery.heated, isFalse);
      expect(updated.trim.level, 'lux'); // sibling preserved
    });

    test('deep nesting: settings → notifications round-trips', () {
      expect(fleet.settings.notifications.email, isTrue);
      final updated = fleet.copyWith(
        settings: fleet.settings.copyWith(
          notifications: fleet.settings.notifications.copyWith(sms: true),
        ),
      );
      expect(updated.settings.notifications.sms, isTrue);
      expect(updated.settings.notifications.email, isTrue);
    });

    test('nested permit list with sealed detail and a sealed gate list', () {
      final withPermit = Sedan(
        registration: fleet.cars.first.registration.copyWith(
          permits: const [
            Permit(
              detail: ParkingPermit(zone: 'A', hours: 2, authority: 'city'),
              label: 'p1',
            ),
            Permit(
              detail: AccessPermit(
                gates: [
                  ManualGate(id: 'g1', key: 'k'),
                  AutoGate(id: 'g2'),
                ],
                revoked: true,
              ),
            ),
          ],
        ),
      );
      expect(withPermit.registration.permits, hasLength(2));
      final parking =
          withPermit.registration.permits.first.detail as ParkingPermit;
      expect(parking.zone, 'A');
      expect(parking.authority, 'city'); // shared sealed field
      final access = withPermit.registration.permits[1].detail as AccessPermit;
      expect(access.gates.map((g) => g.id), ['g1', 'g2']); // shared on Gate
      expect(access.revoked, isTrue); // shared sealed field
    });

    test('shared sealed fields are reachable on the base type', () {
      const PermitDetail detail = TollPermit(
        account: 'acct',
        balance: 1,
        authority: 'dot',
      );
      expect(detail.authority, 'dot');
      expect(detail.revoked, isNull);
      const Drivetrain drive = RangeDrive(
        minRatio: 1,
        maxRatio: 2,
        label: 'eco',
      );
      expect(drive.label, 'eco');
      const Gate gate = AutoGate(id: 'x');
      expect(gate.id, 'x');
    });

    test('effective getters provide defaults for null tri-state fields', () {
      const off = Registration();
      expect(off.effectiveActive, isTrue);
      expect(off.effectiveLocked, isFalse);
      expect(const Permit(detail: AccessPermit()).effectiveRepeat, 1);
    });

    test('DepotSettings.isEmpty / PolicyLimits.isEmpty drive compaction', () {
      expect(const DepotSettings().isEmpty, isTrue);
      expect(const DepotSettings(bays: 1).isEmpty, isFalse);
      expect(const PolicyLimits().isEmpty, isTrue);
    });
  });

  // =========================================================================
  // SPEC (skipped): behaviors the single-tree generator must satisfy.
  // Fill each body and drop `skip:` as the implementation lands.
  // =========================================================================

  group('root children', () {
    test('non-list child generates parameterless field lenses', () {
      final fleet = _fleetForTree();
      final lens = tree.settingsAutoSyncLens();

      expect(lens.get(fleet), isTrue);
      final updated = lens.set(fleet, false) as Fleet;
      expect(updated.settings.autoSync, isFalse);
      expect(updated.cars, same(fleet.cars));
    });

    test('root child structural lens has a nullable read helper', () {
      final fleet = _fleetForTree();
      final lens = tree.settingsLens();

      expect(lens.get(fleet).region, 'eu');
      expect(tree.settingsAt(fleet)?.region, 'eu');
      expect(tree.settingsAt(null), isNull);
    });

    test('child-of-a-child composes a two-hop path', () {
      final fleet = _fleetForTree();
      final lens = tree.settingsNotificationsEmailLens();

      expect(lens.get(fleet), isTrue);
      final updated = lens.set(fleet, false) as Fleet;
      expect(updated.settings.notifications.email, isFalse);
      expect(updated.settings.notifications.sms, isTrue);
    });

    test('dispatched depot compacts to null when empty', () {
      final fleet = _fleetForTree();
      final withoutCapacity =
          tree.depotCapacityLens(VehicleCategory.car).set(fleet, null) as Fleet;
      final empty =
          tree.depotBaysLens(VehicleCategory.car).set(withoutCapacity, null)
              as Fleet;

      expect(empty.carDepot, isNull);
    });

    test('dispatched depot lens reads through an absent slot as empty', () {
      expect(
        tree.depotCapacityLens(VehicleCategory.car).get(const Fleet()),
        isNull,
      );
      final updated =
          tree.depotCapacityLens(VehicleCategory.car).set(const Fleet(), 12)
              as Fleet;
      expect(updated.carDepot?.capacity, 12);
    });

    test('the depot dispatcher routes each category to its own slot', () {
      const fleet = Fleet();
      // Section lens writes the right slot per category and leaves siblings be.
      final withTruck =
          tree
                  .depotSettingsLens(VehicleCategory.truck)
                  .set(fleet, const DepotSettings(bays: 7))
              as Fleet;
      expect(withTruck.truckDepot?.bays, 7);
      expect(withTruck.carDepot, isNull);
      expect(withTruck.bikeDepot, isNull);

      // Per-field lens for one category does not leak into another.
      final withBike =
          tree.depotCapacityLens(VehicleCategory.bike).set(withTruck, 3)
              as Fleet;
      expect(withBike.bikeDepot?.capacity, 3);
      expect(tree.depotCapacityLens(VehicleCategory.car).get(withBike), isNull);
      expect(tree.depotBaysLens(VehicleCategory.truck).get(withBike), 7);
    });
  });

  group('cross-cutting vehicle lists', () {
    test('one VehicleLocation addresses all three sealed lists', () {
      final fleet = _fleetForTree();

      expect(
        tree
            .carRegistrationPlateLens(const tree.CarLocation(carIndex: 0))
            .get(fleet),
        'CAR-1',
      );
      expect(
        tree
            .truckRegistrationPlateLens(const tree.TruckLocation(truckIndex: 0))
            .get(fleet),
        'TRK-1',
      );
      expect(
        tree
            .bikeRegistrationPlateLens(const tree.BikeLocation(bikeIndex: 0))
            .get(fleet),
        'BIKE-1',
      );
    });

    test('out-of-range positional index reads as absent instead of throwing', () {
      final fleet = _fleetForTree();

      // In range, the located field is readable as usual.
      final inRange = tree.carRegistrationPlateLens(
        const tree.CarLocation(carIndex: 0),
      );
      expect(inRange.canGet(fleet), isTrue);
      expect(inRange.get(fleet), 'CAR-1');

      // Out of range, canGet guards the list bounds so readers never index past
      // the end. Regression: a stale selector for a just-removed row used to
      // RangeError here (the item LensPart had no canGet bounds guard).
      final outOfRange = tree.carRegistrationPlateLens(
        const tree.CarLocation(carIndex: 99),
      );
      expect(outOfRange.canGet(fleet), isFalse);

      // The same guard covers plain (non-cross-cutting) positional lists.
      final policy = tree.policyConditionsLens(
        const tree.PolicyLocation(policyIndex: 99),
      );
      expect(policy.canGet(fleet), isFalse);
    });

    test(
      'shared registration subtree is generated once, reached from each list',
      () {
        final fleet = _fleetForTree();

        final updated =
            tree
                    .truckRegistrationRegionLens(
                      const tree.TruckLocation(truckIndex: 0),
                    )
                    .set(fleet, 'west')
                as Fleet;
        expect(updated.trucks.first.registration.region, 'west');
        expect(updated.cars.first.registration.region, 'north');
      },
    );

    test(
      'shared sealed fields project as union "shared" before the case tag',
      () {
        final carValue = tree.comparableCarValue(_fleetForTree().cars.first);
        expect(carValue, isA<List<Object?>>());
        expect((carValue as List<Object?>)[1], 'red');
        expect(carValue[2], 2022);
        expect(carValue[3], 'sedan');
      },
    );

    test('per-case vehicle fields project and restore', () {
      final fleet = _fleetForTree();
      final lens = tree.carCoupeTopSpeedLens(
        const tree.CarLocation(carIndex: 1),
      );

      expect(lens.get(fleet), 250);
      final updated = lens.set(fleet, 300) as Fleet;
      expect((updated.cars[1] as Coupe).topSpeed, 300);
      expect(updated.cars.first, same(fleet.cars.first));
    });

    test('deeply nested case child composes the full path', () {
      final fleet = _fleetForTree();
      final lens = tree.carSedanTrimUpholsteryMaterialLens(
        const tree.CarLocation(carIndex: 0),
      );

      expect(lens.get(fleet), 'nappa');
      final updated = lens.set(fleet, 'cloth') as Fleet;
      expect(((updated.cars.first as Sedan).trim.upholstery.material), 'cloth');
    });
  });

  group('nested permit list (two indices)', () {
    test('permit field lens composes vehicle + permit index', () {
      final fleet = _fleetForTree();
      final lens = tree.carRegistrationPermitLabelLens(
        const tree.CarPermitLocation(carIndex: 0, permitIndex: 1),
      );

      expect(lens.get(fleet), 'access');
      final updated = lens.set(fleet, 'updated') as Fleet;
      expect(updated.cars.first.registration.permits[1].label, 'updated');
    });

    test('sealed permit detail projects shared fields + discriminant tag', () {
      expect(
        tree.comparablePermitDetailValue(
          const ParkingPermit(zone: 'A', authority: 'city'),
        ),
        ['city', null, 'parking', 'A', 0],
      );
    });

    test('sealed gate list nested inside a sealed permit case', () {
      final fleet = _fleetForTree();

      const gate = tree.CarPermitGateLocation(
        carIndex: 0,
        permitIndex: 1,
        gateIndex: 0,
      );
      expect(
        tree.carRegistrationPermitDetailAccessGateIdLens(gate).get(fleet),
        'g1',
      );
      final updated =
          tree
                  .carRegistrationPermitDetailAccessGateManualKeyLens(gate)
                  .set(fleet, 'new-key')
              as Fleet;
      final access =
          updated.cars.first.registration.permits[1].detail as AccessPermit;
      expect((access.gates.first as ManualGate).key, 'new-key');
      expect(tree.comparableGateValue(access.gates.last), [
        'g2',
        'auto',
        'sensor',
        null,
      ]);
    });

    test('list mutation helpers for permits are guarded and copy-on-write', () {
      final registration = _fleetForTree().cars.first.registration;
      const permit = Permit(
        detail: ParkingPermit(zone: 'B'),
        label: 'new',
      );

      expect(tree.addPermit(registration, permit).permits.last.label, 'new');
      expect(tree.removePermitAt(registration, 0).permits, hasLength(1));
      expect(tree.duplicatePermitAt(registration, 0).permits, hasLength(3));
      expect(tree.movePermit(registration, 0, 1).permits[1].label, 'park');
      expect(
        tree
            .updatePermitAt(registration, 0, (p) => p.copyWith(label: 'x'))
            .permits
            .first
            .label,
        'x',
      );
      expect(
        identical(tree.removePermitAt(registration, 99), registration),
        isTrue,
      );
    });

    test('nested list structural lenses have nullable read helpers', () {
      final fleet = _fleetForTree();
      const car = tree.CarLocation(carIndex: 0);
      const permit = tree.CarPermitLocation(carIndex: 0, permitIndex: 1);

      expect(tree.carRegistrationPermitsLens(car).get(fleet), hasLength(2));
      expect(tree.carRegistrationPermitsAt(fleet, car), hasLength(2));
      expect(tree.carRegistrationPermitAt(fleet, permit)?.label, 'access');
      expect(
        tree.carRegistrationPermitAt(
          fleet,
          const tree.CarPermitLocation(carIndex: 0, permitIndex: 99),
        ),
        isNull,
      );
    });
  });

  group('comparison projections', () {
    test('whole-registration comparable mirrors field order', () {
      final registration = _fleetForTree().cars.first.registration;

      expect(tree.comparableRegistrationValue(registration), [
        'CAR-1',
        null,
        'north',
        true,
        false,
        ['daily'],
        'note',
        [
          [
            ['city', null, 'parking', 'A', 2],
            'park',
            1,
            1,
            true,
          ],
          [
            [
              null,
              true,
              'access',
              [
                ['g1', 'manual', 'key'],
                ['g2', 'auto', 'sensor', null],
              ],
            ],
            'access',
            null,
            1,
            null,
          ],
        ],
      ]);
    });

    test('whole-vehicle comparable composes shared + per-case', () {
      final value =
          tree.comparableCarValue(_fleetForTree().cars.first) as List<Object?>;

      expect(value[1], 'red');
      expect(value[2], 2022);
      expect(value[3], 'sedan');
      expect(value[4], [
        'lux',
        true,
        [
          'nappa',
          'black',
          true,
          [1, 2],
        ],
      ]);
    });

    test('editId is excluded from comparison', () {
      final a = _fleetForTree().cars.first.registration;
      final b = a.copyWith(editId: 99);

      expect(
        tree.comparableRegistrationValue(a),
        tree.comparableRegistrationValue(b),
      );
    });

    test(
      'effective getters drive compare without changing the lens target',
      () {
        final registration = _fleetForTree().cars.first.registration.copyWith(
          active: null,
          locked: null,
        );

        expect(
          tree.comparableRegistrationValue(registration),
          containsAllInOrder([true, false]),
        );
        expect(
          tree
              .carRegistrationLockedLens(const tree.CarLocation(carIndex: 0))
              .get(_fleetForTree()),
          isNull,
        );
      },
    );
  });

  group('list mutation + scan-addressed escape hatches', () {
    test('vehicle list mutation helpers per category', () {
      final fleet = _fleetForTree();
      const car = Sedan(registration: Registration(plate: 'CAR-3'));

      expect(tree.addCar(fleet, car).cars.last.registration.plate, 'CAR-3');
      expect(tree.removeTruckAt(fleet, 0).trucks, isEmpty);
      expect(tree.duplicateBikeAt(fleet, 0).bikes, hasLength(2));
      expect(identical(tree.removeCarAt(fleet, 99), fleet), isTrue);
    });

    test('default policy for a region is reached by scanning conditions', () {
      final fleet = _fleetForTree();
      final lens = tree.defaultPolicyLimitsLens('north');

      expect(lens.get(fleet).maxSpeed, 90);
      final updated = lens.set(fleet, const PolicyLimits(maxLoad: 10)) as Fleet;
      expect(updated.policies.single.limits.maxLoad, 10);

      final created =
          tree
                  .defaultPolicyLimitsLens('south')
                  .set(fleet, const PolicyLimits(maxSpeed: 50))
              as Fleet;
      expect(created.policies, hasLength(2));

      final removed = lens.set(fleet, const PolicyLimits()) as Fleet;
      expect(removed.policies, isEmpty);
    });
  });

  group('saved-backing (#3)', () {
    test('located field is backed only when every path index is in range', () {
      final fleet = _fleetForTree();
      expect(
        tree.carRegistrationPlateHasSavedBacking(
          fleet,
          const tree.CarLocation(carIndex: 0),
        ),
        isTrue,
      );
      expect(
        tree.carRegistrationPlateHasSavedBacking(
          fleet,
          const tree.CarLocation(carIndex: 99),
        ),
        isFalse,
      );
    });

    test('nested two-index backing checks both list bounds', () {
      final fleet = _fleetForTree();
      expect(
        tree.carRegistrationPermitLabelHasSavedBacking(
          fleet,
          const tree.CarPermitLocation(carIndex: 0, permitIndex: 1),
        ),
        isTrue,
      );
      expect(
        tree.carRegistrationPermitLabelHasSavedBacking(
          fleet,
          const tree.CarPermitLocation(carIndex: 0, permitIndex: 99),
        ),
        isFalse,
      );
    });

    test('sealed-case mismatch on saved reads as no backing', () {
      final fleet = _fleetForTree();
      // permit 0 is a ParkingPermit, so the access-gate path does not resolve.
      expect(
        tree.carRegistrationPermitDetailAccessGateIdHasSavedBacking(
          fleet,
          const tree.CarPermitGateLocation(
            carIndex: 0,
            permitIndex: 0,
            gateIndex: 0,
          ),
        ),
        isFalse,
      );
      // permit 1 is an AccessPermit with a gate at index 0.
      expect(
        tree.carRegistrationPermitDetailAccessGateIdHasSavedBacking(
          fleet,
          const tree.CarPermitGateLocation(
            carIndex: 0,
            permitIndex: 1,
            gateIndex: 0,
          ),
        ),
        isTrue,
      );
    });

    test(
      'null saved is never backed; root-scalar backs off saved presence',
      () {
        final fleet = _fleetForTree();
        expect(
          tree.carRegistrationPlateHasSavedBacking(
            null,
            const tree.CarLocation(carIndex: 0),
          ),
          isFalse,
        );
        expect(tree.settingsAutoSyncHasSavedBacking(fleet), isTrue);
        expect(tree.settingsAutoSyncHasSavedBacking(null), isFalse);
      },
    );
  });

  group('groups (#5)', () {
    test('named group projects a subset of node fields in order', () {
      final registration = _fleetForTree().cars.first.registration;
      expect(tree.comparableRegistrationIdentityValue(registration), [
        'CAR-1',
        null,
      ]);
    });

    test(
      'group members reuse the node field compare rules (effective getter)',
      () {
        // `active` is readOnly + projected, so the group tuple holds effectiveActive.
        final registration = const Registration(plate: 'X'); // active == null
        expect(tree.comparableRegistrationAuditValue(registration), [
          'X',
          null,
          true, // effectiveActive default
          null,
        ]);
      },
    );
  });

  group('field refs (#4)', () {
    test('located field ref carries id, dirty field, and a working lens', () {
      final fleet = _fleetForTree();
      final ref = tree.carRegistrationPermitLabelField;
      expect(ref.id, 'carRegistrationPermitLabel');
      expect(ref.dirtyField, tree.FleetDirtyField.carRegistrationPermitLabel);
      final lens = ref.lens(
        const tree.CarPermitLocation(carIndex: 0, permitIndex: 1),
      );
      expect(lens.get(fleet), 'access');
    });

    test('no-location field ref keys off the empty record', () {
      final fleet = _fleetForTree();
      final ref = tree.settingsAutoSyncField;
      expect(ref.id, 'settingsAutoSync');
      expect(ref.dirtyField, tree.FleetDirtyField.settingsAutoSync);
      expect(ref.lens(const ()).get(fleet), isTrue);
    });
  });
}

Fleet _fleetForTree() => const Fleet(
  cars: [
    Sedan(
      registration: Registration(
        plate: 'CAR-1',
        region: 'north',
        tags: ['daily'],
        notes: 'note',
        permits: [
          Permit(
            detail: ParkingPermit(zone: 'A', hours: 2, authority: 'city'),
            label: 'park',
            priority: 1,
            repeat: 1,
            enabled: true,
          ),
          Permit(
            detail: AccessPermit(
              gates: [
                ManualGate(id: 'g1', key: 'key'),
                AutoGate(id: 'g2', sensorModel: 'sensor'),
              ],
              revoked: true,
            ),
            label: 'access',
          ),
        ],
      ),
      color: 'red',
      year: 2022,
      trim: Trim(
        level: 'lux',
        leather: true,
        upholstery: Upholstery(
          material: 'nappa',
          color: 'black',
          heated: true,
          rows: [1, 2],
        ),
      ),
    ),
    Coupe(
      registration: Registration(plate: 'CAR-2'),
      drivetrain: RangeDrive(
        minRatio: 1,
        maxRatio: 6,
        locking: true,
        label: 'sport',
      ),
      topSpeed: 250,
    ),
  ],
  trucks: [BoxTruck(registration: Registration(plate: 'TRK-1'), axleCount: 3)],
  bikes: [
    RoadBike(registration: Registration(plate: 'BIKE-1'), electric: true),
  ],
  policies: [
    Policy(
      conditions: RegionCondition(region: 'north'),
      limits: PolicyLimits(maxSpeed: 90, escort: true),
    ),
  ],
  carDepot: DepotSettings(capacity: 40, bays: 4),
  settings: FleetSettings(
    autoSync: true,
    region: 'eu',
    notifications: NotificationSettings(email: true, sms: true),
  ),
);
