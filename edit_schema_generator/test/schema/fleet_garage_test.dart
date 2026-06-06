// Verifies the generalized `taggedLists` discriminator (see
// fleet_garage_fixture.dart): a single configurable location coordinate over
// several lists, returning the common supertype, with shared + per-entry lenses.

import 'package:test/test.dart';

import 'fleet_garage_fixture.dart' as garage;
import 'fleet_test_models.dart';

void main() {
  final fleet = const Fleet(
    cars: [
      Sedan(
        registration: Registration(plate: 'CAR-1', region: 'north'),
        color: 'red',
        year: 2022,
        trim: Trim(level: 'lux'),
      ),
      Coupe(registration: Registration(plate: 'CAR-2'), topSpeed: 250),
    ],
    trucks: [BoxTruck(registration: Registration(plate: 'TRK-1'), axleCount: 3)],
    bikes: [RoadBike(registration: Registration(plate: 'BIKE-1'), electric: true)],
  );

  group('taggedLists discriminator', () {
    test('dispatcher resolves the element by configurable kind/slot', () {
      expect(
        garage
            .garageVehicleLens(
              const GarageLocation(kind: VehicleCategory.car, slot: 1),
            )
            .get(fleet),
        isA<Coupe>(),
      );
      expect(
        garage
            .garageVehicleLens(
              const GarageLocation(kind: VehicleCategory.truck, slot: 0),
            )
            .get(fleet),
        isA<BoxTruck>(),
      );
    });

    test('one shared registration family addresses every list', () {
      String plate(VehicleCategory kind, int slot) => garage
          .garageVehicleRegistrationPlateLens(
            GarageLocation(kind: kind, slot: slot),
          )
          .get(fleet)!;
      expect(plate(VehicleCategory.car, 0), 'CAR-1');
      expect(plate(VehicleCategory.truck, 0), 'TRK-1');
      expect(plate(VehicleCategory.bike, 0), 'BIKE-1');
    });

    test('shared set dispatches back into the right list via the supertype', () {
      final updated =
          garage
                  .garageVehicleRegistrationRegionLens(
                    const GarageLocation(kind: VehicleCategory.car, slot: 0),
                  )
                  .set(fleet, 'south')
              as Fleet;
      expect(updated.cars.first.registration.region, 'south');
      expect(updated.trucks.first.registration.region, isNull);
    });

    test('per-entry case fields compose through the cast', () {
      final loc = const GarageLocation(kind: VehicleCategory.car, slot: 0);
      expect(garage.carColorLens(loc).get(fleet), 'red');
      expect(garage.carSedanTrimLevelLens(loc).get(fleet), 'lux');
      final updated = garage.carCoupeTopSpeedLens(
        const GarageLocation(kind: VehicleCategory.car, slot: 1),
      ).set(fleet, 300) as Fleet;
      expect((updated.cars[1] as Coupe).topSpeed, 300);
    });

    test('shared backing + field ref carry the discriminator location', () {
      const loc = GarageLocation(kind: VehicleCategory.car, slot: 0);
      expect(garage.garageVehicleRegistrationPlateHasSavedBacking(fleet, loc), isTrue);
      expect(
        garage.garageVehicleRegistrationPlateHasSavedBacking(
          fleet,
          const GarageLocation(kind: VehicleCategory.car, slot: 9),
        ),
        isFalse,
      );
      final ref = garage.garageVehicleRegistrationPlateField;
      expect(ref.dirtyField, garage.GarageDirtyField.garageVehicleRegistrationPlate);
      expect(ref.lens(loc).get(fleet), 'CAR-1');
    });
  });
}
