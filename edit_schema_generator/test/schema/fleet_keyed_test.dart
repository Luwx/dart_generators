// Verifies identity-keyed `taggedLists` (see fleet_keyed_fixture.dart): a
// location carrying the element's key resolves the same logical element in any
// snapshot of the root, regardless of list order. This is the draft/saved
// contract positional coordinates break after a reorder: the same lens must
// read the moved element from the draft and its baseline from the saved
// snapshot without any coordinate remapping.

import 'package:test/test.dart';

import 'fleet_keyed_fixture.dart';
import 'fleet_test_models.dart';

void main() {
  const fleet = Fleet(
    cars: [
      Sedan(
        registration: Registration(plate: 'CAR-1', editId: 1),
        color: 'red',
      ),
      Coupe(
        registration: Registration(plate: 'CAR-2', editId: 2),
        color: 'blue',
        topSpeed: 250,
      ),
    ],
    trucks: [
      BoxTruck(
        registration: Registration(plate: 'TRK-1', editId: 3),
        axleCount: 3,
      ),
    ],
    bikes: [
      RoadBike(
        registration: Registration(plate: 'BIKE-1', editId: 4),
        electric: true,
      ),
    ],
  );

  // The same fleet with the cars list reversed (≈ a reordered draft while the
  // original stays as the saved baseline).
  final reordered = Fleet(
    cars: fleet.cars.reversed.toList(),
    trucks: fleet.trucks,
    bikes: fleet.bikes,
  );

  const sedanLoc = KeyedGarageLocation(kind: VehicleCategory.car, editId: 1);
  const coupeLoc = KeyedGarageLocation(kind: VehicleCategory.car, editId: 2);
  const missingLoc = KeyedGarageLocation(kind: VehicleCategory.car, editId: 99);

  group('keyed taggedLists', () {
    test('dispatcher resolves the element by key, not position', () {
      expect(keyedVehicleLens(sedanLoc).get(fleet), isA<Sedan>());
      expect(keyedVehicleLens(coupeLoc).get(fleet), isA<Coupe>());
      expect(
        keyedVehicleLens(
          const KeyedGarageLocation(kind: VehicleCategory.truck, editId: 3),
        ).get(fleet),
        isA<BoxTruck>(),
      );
    });

    test('the same location addresses the same element after a reorder', () {
      // Draft (reordered) and saved (original) disagree on positions; the keyed
      // lens reads the same logical element from both.
      final lens = keyedVehicleRegistrationPlateLens(sedanLoc);
      expect(lens.get(fleet), 'CAR-1');
      expect(lens.get(reordered), 'CAR-1');
      expect(carColorLens(coupeLoc).get(fleet), 'blue');
      expect(carColorLens(coupeLoc).get(reordered), 'blue');
    });

    test('emits keyed tagged-list address helpers', () {
      expect(keyedVehiclesForKind(fleet, VehicleCategory.car), fleet.cars);
      expect(keyedVehicleAt(reordered, sedanLoc), isA<Sedan>());
      expect(keyedVehicleIndexOf(fleet, sedanLoc), 0);
      expect(keyedVehicleIndexOf(reordered, sedanLoc), 1);
      expect(keyedVehicleLocationAt(fleet, VehicleCategory.car, 1), coupeLoc);
      expect(
        keyedVehicleLocationOf(VehicleCategory.car, fleet.cars.first),
        sedanLoc,
      );
      expect(keyedVehicleLocationAt(fleet, VehicleCategory.car, 99), isNull);
      expect(
        keyedVehicleLocationOf(
          VehicleCategory.car,
          const Sedan(registration: Registration(plate: 'NO-ID')),
        ),
        isNull,
      );
    });

    test('emits keyed tagged-list mutation helpers', () {
      final added = addKeyedVehicle(
        fleet,
        VehicleCategory.car,
        const Convertible(
          registration: Registration(plate: 'CAR-3', editId: 5),
          color: 'green',
        ),
      );
      expect(added.cars.map((car) => car.registration.plate), [
        'CAR-1',
        'CAR-2',
        'CAR-3',
      ]);

      final updated = updateKeyedVehicle(
        reordered,
        sedanLoc,
        (vehicle) => (vehicle as Sedan).copyWith(color: 'black'),
      );
      expect((updated.cars[1] as Sedan).color, 'black');

      final removed = removeKeyedVehicle(fleet, sedanLoc);
      expect(removed.cars.map((car) => car.registration.plate), ['CAR-2']);

      final moved = moveKeyedVehicle(fleet, VehicleCategory.car, 0, 2);
      expect(moved.cars.map((car) => car.registration.plate), [
        'CAR-2',
        'CAR-1',
      ]);
    });

    test('set dispatches to the keyed element wherever it sits', () {
      final updated = keyedVehicleRegistrationRegionLens(
        sedanLoc,
      ).set(reordered, 'south');
      // The sedan is at index 1 in the reordered fleet.
      expect(updated.cars[1].registration.region, 'south');
      expect(updated.cars[0].registration.region, isNull);
    });

    test('per-entry case fields compose through the cast by key', () {
      expect(carCoupeTopSpeedLens(coupeLoc).get(fleet), 250);
      final updated = carCoupeTopSpeedLens(coupeLoc).set(reordered, 300);
      expect((updated.cars[0] as Coupe).topSpeed, 300);
    });

    group('key miss behaves like an out-of-range index', () {
      test('canGet is false', () {
        expect(keyedVehicleLens(missingLoc).canGet(fleet), isFalse);
        expect(
          keyedVehicleRegistrationPlateLens(missingLoc).canGet(fleet),
          isFalse,
        );
      });

      test('get throws', () {
        expect(() => keyedVehicleLens(missingLoc).get(fleet), throwsRangeError);
      });

      test('base dispatcher set leaves the root unchanged', () {
        final updated = keyedVehicleLens(
          missingLoc,
        ).set(fleet, fleet.cars.first);
        expect(identical(updated, fleet), isTrue);
      });

      test('composed set throws like a positional out-of-range set', () {
        // `Lens.then` reads the element before writing through it, so a
        // composed set on a missing key throws just as it does for a stale
        // index — callers guard with canGet either way.
        expect(
          () => keyedVehicleRegistrationRegionLens(
            missingLoc,
          ).set(fleet, 'south'),
          throwsRangeError,
        );
      });

      test('a key present in one snapshot but not another has no backing', () {
        // ≈ a freshly added draft gesture: present in the draft, absent from
        // the saved baseline.
        expect(
          keyedVehicleRegistrationPlateHasSavedBacking(fleet, sedanLoc),
          isTrue,
        );
        expect(
          keyedVehicleRegistrationPlateHasSavedBacking(fleet, missingLoc),
          isFalse,
        );
      });
    });

    test(
      'elements with a null key are unaddressable, others still resolve',
      () {
        const unkeyed = Fleet(
          cars: [
            Sedan(registration: Registration(plate: 'NO-ID')),
            Coupe(registration: Registration(plate: 'CAR-2', editId: 2)),
          ],
        );
        expect(keyedVehicleLens(coupeLoc).get(unkeyed), isA<Coupe>());
        expect(keyedVehicleLens(sedanLoc).canGet(unkeyed), isFalse);
      },
    );

    test('generated location carries value equality over kind/key', () {
      expect(
        sedanLoc,
        const KeyedGarageLocation(kind: VehicleCategory.car, editId: 1),
      );
      expect(sedanLoc == coupeLoc, isFalse);
      expect(
        sedanLoc ==
            const KeyedGarageLocation(kind: VehicleCategory.truck, editId: 1),
        isFalse,
      );
    });
  });
}
