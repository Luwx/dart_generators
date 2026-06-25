// Exercises identity-keyed `taggedLists` (`key: listKey(...)`): the generated
// location carries the element's editId instead of a list index, so the same
// location addresses the same logical element in any snapshot of the root —
// the draft/saved reorder case that positional coordinates get wrong.

import 'package:edit_schema_generator/edit_schema_generator.dart';

import 'fleet_test_models.dart';

part 'fleet_keyed_fixture.g.dart';

final TreeNode<Registration> keyedRegistrationNode = subtree<Registration>(
  fields: [prop('plate'), prop('region')],
);

final TreeNode<Car> keyedCarNode = subtree<Car>(
  fields: [prop('color')],
  cases: [
    valueCase<Sedan>('sedan'),
    valueCase<Coupe>('coupe', fields: [prop('topSpeed')]),
    valueCase<Convertible>('convertible'),
  ],
);

final TreeNode<Truck> keyedTruckNode = subtree<Truck>(
  fields: [prop('axleCount')],
  cases: [valueCase<BoxTruck>('box'), valueCase<Tanker>('tanker')],
);

final TreeNode<Bike> keyedBikeNode = subtree<Bike>(
  fields: [prop('electric')],
  cases: [valueCase<RoadBike>('road'), valueCase<CargoBike>('cargo')],
);

@GenerateEditSchema()
final EditTree<Fleet> keyedGarageTree = editTree<Fleet>(
  id: 'keyedGarage',
  fields: [
    taggedLists<KeyedGarageLocation, Vehicle, VehicleCategory>(
      lens: 'keyedVehicleLens',
      discriminator: 'kind',
      key: listKey<Vehicle, int>(
        field: 'editId',
        get: (v) => v.registration.editId,
      ),
      name: 'keyedVehicle',
      generateLocation: true,
      shared: [
        child(
          'registration',
          node: keyedRegistrationNode,
          select: lens<Vehicle, Registration>(
            get: (v) => v.registration,
            set: (v, r) => v.copyWithRegistration(r),
          ),
        ),
      ],
      lists: {
        VehicleCategory.car: ('cars', keyedCarNode),
        VehicleCategory.truck: ('trucks', keyedTruckNode),
        VehicleCategory.bike: ('bikes', keyedBikeNode),
      },
    ),
  ],
);
