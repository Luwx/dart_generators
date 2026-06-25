import 'package:edit_schema_generator/edit_schema_generator.dart';

import 'car_schema_test_models.dart';

part 'car_source_gen_fixture.g.dart';

Lens<Car> carLens(CarLocation location) {
  throw UnimplementedError('Only generated helper signatures use this lens.');
}

@GenerateEditSchema()
final EditSchema<Car, CarLocation> carGeneratedSchema =
    editSchema<Car, CarLocation>(
      fields: [
        prop('name'),
        prop('year'),
        prop('wheels', backing: backedWhen((Car car) => car.wheels.isNotEmpty)),
        prop('seats'),
        prop('color'),
        prop('tags'),
        prop(
          'summary',
          readOnly: true,
          compare: projected((Car? c) => [c?.name, c?.year]),
          backing: backedWhen((Car car) => car.year > 0),
        ),
        union<GasEngine>(
          'engine',
          fields: [
            prop('engineName', property: 'name'),
            prop('horsepower'),
          ],
        ),
        union<ElectricEngine>('engine', fields: [prop('kw'), prop('battery')]),
      ],
      groups: [
        editGroup(id: 'body', members: ['name', 'year', 'color', 'tags']),
        editGroup(id: 'inside', members: ['seats']),
        editGroup(id: 'enginePower', members: ['horsepower', 'kw']),
      ],
    );

// Flat value projection: comparableWheelValue(Wheel?).
@GenerateEditSchema()
final ValueSchema<Wheel> wheelValueSchema = valueSchema<Wheel>(
  fields: [prop('size'), prop('pressure')],
);

// Sealed value projection with discriminant tags: comparableEngineValue(Engine?).
@GenerateEditSchema()
final ValueSchema<Engine> engineValueSchema = valueSchema<Engine>(
  cases: [
    valueCase<GasEngine>('gas', fields: [prop('horsepower'), prop('turbo')]),
    valueCase<ElectricEngine>('electric', fields: [prop('kw')]),
  ],
);

// Guarded list-mutation helpers: replaceWheelAt, addWheel, removeWheelAt, etc.
@GenerateEditSchema()
final ListSchema<Car, Wheel> wheelList = listSchema<Car, Wheel>(
  property: 'wheels',
  id: 'wheel',
);

// Composed projection delegating to the value schemas above (scalar + list).
@GenerateEditSchema()
final ValueSchema<Car> carValueSchema = valueSchema<Car>(
  fields: [
    prop('name'),
    prop('wheels', compare: composed()),
    prop('engine', compare: composed()),
  ],
);
