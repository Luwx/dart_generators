// Exercises the generalized `taggedLists` discriminator. Here:
//   - the coordinate is `GarageLocation` with NON-default field names
//     (`kind`/`slot`) — proving discriminator/index are configurable;
//   - the dispatcher returns `Lens<Fleet, Vehicle>` (the lists' common supertype), so
//     the `shared` registration is reached via the interface (≈ Gesture.common /
//     withCommon) and yields a single lens family;
//   - each entry contributes per-case fields.

import 'package:edit_schema_generator/edit_schema_generator.dart';

import 'fleet_test_models.dart';

part 'fleet_garage_fixture.g.dart';

final TreeNode<Registration> garageRegistrationNode = subtree<Registration>(
  fields: [prop('plate'), prop('region')],
);

final TreeNode<Trim> garageTrimNode = subtree<Trim>(fields: [prop('level')]);

final TreeNode<Car> garageCarNode = subtree<Car>(
  fields: [prop('color'), prop('year')],
  cases: [
    valueCase<Sedan>('sedan', fields: [child('trim', node: garageTrimNode)]),
    valueCase<Coupe>('coupe', fields: [prop('topSpeed')]),
    valueCase<Convertible>(
      'convertible',
      fields: [prop('roofOpen', orElse: false)],
    ),
  ],
);

final TreeNode<Truck> garageTruckNode = subtree<Truck>(
  fields: [prop('axleCount')],
  cases: [
    valueCase<BoxTruck>('box', fields: [prop('boxVolume')]),
    valueCase<Tanker>('tanker', fields: [prop('capacity')]),
  ],
);

final TreeNode<Bike> garageBikeNode = subtree<Bike>(
  fields: [prop('electric')],
  cases: [
    valueCase<RoadBike>('road', fields: [prop('gears')]),
    valueCase<CargoBike>('cargo', fields: [prop('baskets')]),
  ],
);

@GenerateEditSchema()
final EditTree<Fleet> garageTree = editTree<Fleet>(
  id: 'garage',
  fields: [
    taggedLists<GarageLocation, Vehicle, VehicleCategory>(
      lens: 'garageVehicleLens',
      discriminator: 'kind',
      index: 'slot',
      name: 'garageVehicle',
      shared: [
        child(
          'registration',
          node: garageRegistrationNode,
          select: lens<Vehicle, Registration>(
            get: (v) => v.registration,
            set: (v, r) => v.copyWithRegistration(r),
          ),
        ),
      ],
      lists: {
        VehicleCategory.car: ('cars', garageCarNode),
        VehicleCategory.truck: ('trucks', garageTruckNode),
        VehicleCategory.bike: ('bikes', garageBikeNode),
      },
    ),
  ],
);
