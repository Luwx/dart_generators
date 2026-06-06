import 'package:edit_schema_generator/edit_schema_generator.dart';
import 'package:test/test.dart';

import 'car_schema_test_models.dart';
import 'car_source_gen_fixture.dart' as car_generated;
import 'edit_schema_test_models.dart';
import 'source_gen_fixture.dart' as generated;
import 'tearoff_self_union_fixture.dart' as tsu;

void main() {
  group('build_runner source generated helpers', () {
    test('compute generated comparable field and group values', () {
      const value = FixtureNode(
        variant: TextVariant(text: 'source-text'),
        mode: 'source-mode',
      );

      expect(
        generated.comparableFixtureNodeFieldValue(
          value,
          generated.FixtureNodeDirtyField.text,
        ),
        'source-text',
      );
      expect(
        generated.comparableFixtureNodeFieldValue(
          value,
          generated.FixtureNodeDirtyField.flag,
        ),
        isTrue,
      );
      expect(
        generated.comparableFixtureNodeGroupValue(
          value,
          generated.FixtureNodeDirtyGroup.modeAndFlag,
        ),
        ['source-mode', isTrue],
      );
    });

    test('restore generated merge and replace fields', () {
      const current = FixtureNode(
        variant: TextVariant(text: 'current-text', flag: false),
        mode: 'current-mode',
      );
      const saved = FixtureNode(
        variant: TextVariant(text: 'saved-text', flag: true),
        mode: 'saved-mode',
      );

      final restoredText = generated.restoreFixtureNodeField(
        current: current,
        saved: saved,
        field: generated.FixtureNodeDirtyField.text,
      );
      expect((restoredText.variant as TextVariant).text, 'saved-text');
      expect((restoredText.variant as TextVariant).flag, isFalse);
      expect(restoredText.mode, 'current-mode');

      final restoredMode = generated.restoreFixtureNodeField(
        current: current,
        saved: saved,
        field: generated.FixtureNodeDirtyField.mode,
      );
      expect(restoredMode.mode, 'saved-mode');
      expect((restoredMode.variant as TextVariant).text, 'current-text');
    });

    test('compute generated saved-backing state', () {
      expect(generated.fixtureNodeHasSavedBacking(null), isFalse);
      expect(
        generated.fixtureNodeHasSavedBacking(
          const FixtureNode(variant: TextVariant(text: 'value')),
        ),
        isTrue,
      );
    });

    test('emit generated field refs with fallback and adapter metadata', () {
      expect(generated.fixtureNodeTextField.id, 'text');
      expect(
        generated.fixtureNodeTextField.dirtyField,
        generated.FixtureNodeDirtyField.text,
      );
      expect(
        generated.fixtureNodeTextField.fallback!(
          const FixtureNode(variant: TextVariant(text: 'fallback-text')),
        ),
        'fallback-text',
      );
      final adapter = generated.fixtureNodeTextField.adapter;
      expect(adapter.format('source-text'), 'source-text');
      expect(
        adapter.parse('source-text'),
        isA<FieldParseAccepted<String>>().having(
          (result) => result.value,
          'value',
          'source-text',
        ),
      );
    });
  });

  group('self-union and tear-off authoring', () {
    test('self-union projects/restores without a caseLens override', () {
      expect(
        tsu.comparableVariantFieldValue(
          const TextVariant(text: 'a'),
          tsu.VariantDirtyField.text,
        ),
        'a',
      );
      // A non-matching case projects to null for that field.
      expect(
        tsu.comparableVariantFieldValue(
          const ListVariant(items: ['x']),
          tsu.VariantDirtyField.text,
        ),
        isNull,
      );
      final restored = tsu.restoreVariantField(
        current: const TextVariant(text: 'current'),
        saved: const TextVariant(text: 'saved'),
        field: tsu.VariantDirtyField.text,
      );
      expect((restored as TextVariant).text, 'saved');
    });

    test('tear-off get/set feed comparable and restore', () {
      const node = FixtureNode(variant: TextVariant(text: 't'), mode: 'm');
      expect(
        tsu.comparableTearoffNodeFieldValue(
          node,
          tsu.TearoffNodeDirtyField.mode,
        ),
        'm',
      );
      final restored = tsu.restoreTearoffNodeField(
        current: node,
        saved: node.copyWith(mode: 'saved'),
        field: tsu.TearoffNodeDirtyField.mode,
      );
      expect(restored.mode, 'saved');
    });
  });

  group('larger car source generated helpers', () {
    test('compute generated root leaf comparable values', () {
      final car = _gasCar();

      expect(
        car_generated.comparableCarFieldValue(
          car,
          car_generated.CarDirtyField.name,
        ),
        'wagon',
      );
      expect(
        car_generated.comparableCarFieldValue(
          car,
          car_generated.CarDirtyField.wheels,
        ),
        car.wheels,
      );
      expect(
        car_generated.comparableCarGroupValue(
          car,
          car_generated.CarDirtyGroup.body,
        ),
        [
          'wagon',
          2020,
          'blue',
          ['daily', 'simple'],
        ],
      );
    });

    test('compute generated union field comparable values', () {
      final gasCar = _gasCar();
      final electricCar = _electricCar();

      expect(
        car_generated.comparableCarFieldValue(
          gasCar,
          car_generated.CarDirtyField.engineName,
        ),
        'small gas',
      );
      expect(
        car_generated.comparableCarFieldValue(
          gasCar,
          car_generated.CarDirtyField.horsepower,
        ),
        180,
      );
      expect(
        car_generated.comparableCarFieldValue(
          gasCar,
          car_generated.CarDirtyField.kw,
        ),
        null,
      );
      expect(
        car_generated.comparableCarFieldValue(
          electricCar,
          car_generated.CarDirtyField.kw,
        ),
        220,
      );
      expect(
        car_generated.comparableCarGroupValue(
          electricCar,
          car_generated.CarDirtyGroup.enginePower,
        ),
        [null, 220],
      );
    });

    test('restore generated root and union fields', () {
      final current = _gasCar().copyWith(
        name: 'current',
        color: 'black',
        engine: const GasEngine(
          name: 'current gas',
          horsepower: 100,
          liters: 1.2,
          cylinders: 4,
          turbo: false,
        ),
      );
      final saved = _gasCar().copyWith(
        name: 'saved',
        color: 'white',
        engine: const GasEngine(
          name: 'saved gas',
          horsepower: 250,
          liters: 2,
          cylinders: 6,
          turbo: true,
        ),
      );

      final restoredColor = car_generated.restoreCarField(
        current: current,
        saved: saved,
        field: car_generated.CarDirtyField.color,
      );
      expect(restoredColor.color, 'white');
      expect((restoredColor.engine as GasEngine).horsepower, 100);

      final restoredPower = car_generated.restoreCarField(
        current: current,
        saved: saved,
        field: car_generated.CarDirtyField.horsepower,
      );
      expect((restoredPower.engine as GasEngine).horsepower, 250);
      expect(restoredPower.color, 'black');
    });

    test('compute generated read-only comparison-only field', () {
      final car = _gasCar();
      expect(
        car_generated.comparableCarFieldValue(
          car,
          car_generated.CarDirtyField.summary,
        ),
        ['wagon', 2020],
      );
      // Read-only fields restore to a no-op (no lens to write through).
      final saved = car.copyWith(name: 'other', year: 1999);
      expect(
        car_generated.restoreCarField(
          current: car,
          saved: saved,
          field: car_generated.CarDirtyField.summary,
        ),
        same(car),
      );
      // Read-only fields still honor their own backing override.
      expect(
        car_generated.carFieldHasSavedBacking(
          car,
          car_generated.CarDirtyField.summary,
        ),
        isTrue,
      );
    });

    test('compute generated per-field saved-backing overrides', () {
      // Default fields inherit the root predicate (saved != null).
      expect(
        car_generated.carFieldHasSavedBacking(
          null,
          car_generated.CarDirtyField.name,
        ),
        isFalse,
      );
      expect(
        car_generated.carFieldHasSavedBacking(
          _gasCar(),
          car_generated.CarDirtyField.name,
        ),
        isTrue,
      );

      // wheels declares backedWhen((car) => car.wheels.isNotEmpty).
      expect(
        car_generated.carFieldHasSavedBacking(
          null,
          car_generated.CarDirtyField.wheels,
        ),
        isFalse,
      );
      expect(
        car_generated.carFieldHasSavedBacking(
          _gasCar(),
          car_generated.CarDirtyField.wheels,
        ),
        isTrue,
      );
      expect(
        car_generated.carFieldHasSavedBacking(
          _gasCar().copyWith(wheels: const []),
          car_generated.CarDirtyField.wheels,
        ),
        isFalse,
      );
    });

    test(
      'compute generated value schema projections (flat/sealed/composed)',
      () {
        // Flat value projection.
        expect(
          car_generated.comparableWheelValue(
            const Wheel(
              name: 'fl',
              size: 18,
              width: 8,
              pressure: 32,
              spare: false,
            ),
          ),
          [18, 32],
        );
        expect(car_generated.comparableWheelValue(null), [null, null]);

        // Sealed value projection with discriminant tags.
        expect(
          car_generated.comparableEngineValue(
            const GasEngine(
              name: 'g',
              horsepower: 180,
              liters: 1.6,
              cylinders: 4,
              turbo: true,
            ),
          ),
          ['gas', 180, true],
        );
        expect(
          car_generated.comparableEngineValue(
            const ElectricEngine(
              name: 'e',
              kw: 220,
              battery: 75,
              motors: 2,
              fastCharge: true,
            ),
          ),
          ['electric', 220],
        );

        // Composed projection: delegates to wheel (list) and engine (scalar).
        final car = _gasCar();
        expect(car_generated.comparableCarValue(car), [
          'wagon',
          List.filled(4, [18, 32]),
          ['gas', 180, true],
        ]);
      },
    );

    test('generate guarded list-mutation helpers', () {
      final car = _gasCar(); // 4 wheels
      const newWheel = Wheel(
        name: 'spare',
        size: 17,
        width: 7,
        pressure: 30,
        spare: true,
      );

      // replace / add / insert / remove / duplicate change the list.
      expect(
        car_generated.replaceWheelAt(car, 1, newWheel).wheels[1].name,
        'spare',
      );
      expect(car_generated.addWheel(car, newWheel).wheels.length, 5);
      expect(car_generated.addWheel(car, newWheel).wheels.last.name, 'spare');
      expect(
        car_generated.insertWheelAt(car, 0, newWheel).wheels.first.name,
        'spare',
      );
      expect(car_generated.removeWheelAt(car, 0).wheels.length, 3);
      expect(car_generated.duplicateWheelAt(car, 0).wheels.length, 5);
      expect(
        car_generated.duplicateWheelAt(car, 0).wheels[1].name,
        car.wheels[0].name,
      );

      // update transforms in place; move repositions.
      final updated = car_generated.updateWheelAt(
        car,
        2,
        (w) => w.copyWith(pressure: 99),
      );
      expect(updated.wheels[2].pressure, 99);
      expect(
        car_generated.moveWheel(car, 0, 3).wheels[3].name,
        car.wheels[0].name,
      );

      // Out-of-range indices leave the root unchanged (same instance).
      expect(
        identical(car_generated.replaceWheelAt(car, 9, newWheel), car),
        isTrue,
      );
      expect(identical(car_generated.removeWheelAt(car, -1), car), isTrue);
      expect(identical(car_generated.duplicateWheelAt(car, 4), car), isTrue);
      expect(identical(car_generated.moveWheel(car, 7, 0), car), isTrue);
      // insert allows index == length (append position) but not beyond.
      expect(car_generated.insertWheelAt(car, 4, newWheel).wheels.length, 5);
      expect(
        identical(car_generated.insertWheelAt(car, 5, newWheel), car),
        isTrue,
      );
    });

    test('compute generated saved-backing state and metadata', () {
      expect(car_generated.carHasSavedBacking(null), isFalse);
      expect(car_generated.carHasSavedBacking(_gasCar()), isTrue);

      expect(car_generated.carNameField.id, 'name');
      expect(
        car_generated.carNameField.dirtyField,
        car_generated.CarDirtyField.name,
      );
      expect(car_generated.carNameField.fallback!(_gasCar()), 'wagon');
    });
  });
}

Car _gasCar() => const Car(
  name: 'wagon',
  year: 2020,
  color: 'blue',
  wheels: [
    Wheel(name: 'front-left', size: 18, width: 8, pressure: 32, spare: false),
    Wheel(name: 'front-right', size: 18, width: 8, pressure: 32, spare: false),
    Wheel(name: 'rear-left', size: 18, width: 8, pressure: 32, spare: false),
    Wheel(name: 'rear-right', size: 18, width: 8, pressure: 32, spare: false),
  ],
  seats: [
    Seat(
      name: 'front-left',
      row: 1,
      heat: true,
      material: 'cloth',
      fold: false,
    ),
    Seat(
      name: 'front-right',
      row: 1,
      heat: true,
      material: 'cloth',
      fold: false,
    ),
    Seat(name: 'rear-left', row: 2, heat: false, material: 'cloth', fold: true),
    Seat(
      name: 'rear-right',
      row: 2,
      heat: false,
      material: 'cloth',
      fold: true,
    ),
    Seat(
      name: 'rear-middle',
      row: 2,
      heat: false,
      material: 'cloth',
      fold: true,
    ),
  ],
  engine: GasEngine(
    name: 'small gas',
    horsepower: 180,
    liters: 1.6,
    cylinders: 4,
    turbo: true,
  ),
  tags: ['daily', 'simple'],
);

Car _electricCar() => _gasCar().copyWith(
  name: 'quiet wagon',
  engine: const ElectricEngine(
    name: 'quiet motor',
    kw: 220,
    battery: 75,
    motors: 2,
    fastCharge: true,
  ),
);
