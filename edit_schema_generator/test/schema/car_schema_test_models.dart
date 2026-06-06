sealed class Engine {
  const Engine();
}

final class GasEngine extends Engine {
  const GasEngine({
    required this.name,
    required this.horsepower,
    required this.liters,
    required this.cylinders,
    required this.turbo,
  });

  final String name;
  final int horsepower;
  final double liters;
  final int cylinders;
  final bool turbo;

  GasEngine copyWith({
    String? name,
    int? horsepower,
    double? liters,
    int? cylinders,
    bool? turbo,
  }) {
    return GasEngine(
      name: name ?? this.name,
      horsepower: horsepower ?? this.horsepower,
      liters: liters ?? this.liters,
      cylinders: cylinders ?? this.cylinders,
      turbo: turbo ?? this.turbo,
    );
  }
}

final class ElectricEngine extends Engine {
  const ElectricEngine({
    required this.name,
    required this.kw,
    required this.battery,
    required this.motors,
    required this.fastCharge,
  });

  final String name;
  final int kw;
  final int battery;
  final int motors;
  final bool fastCharge;

  ElectricEngine copyWith({
    String? name,
    int? kw,
    int? battery,
    int? motors,
    bool? fastCharge,
  }) {
    return ElectricEngine(
      name: name ?? this.name,
      kw: kw ?? this.kw,
      battery: battery ?? this.battery,
      motors: motors ?? this.motors,
      fastCharge: fastCharge ?? this.fastCharge,
    );
  }
}

final class Wheel {
  const Wheel({
    required this.name,
    required this.size,
    required this.width,
    required this.pressure,
    required this.spare,
  });

  final String name;
  final int size;
  final int width;
  final int pressure;
  final bool spare;

  Wheel copyWith({
    String? name,
    int? size,
    int? width,
    int? pressure,
    bool? spare,
  }) {
    return Wheel(
      name: name ?? this.name,
      size: size ?? this.size,
      width: width ?? this.width,
      pressure: pressure ?? this.pressure,
      spare: spare ?? this.spare,
    );
  }
}

final class Seat {
  const Seat({
    required this.name,
    required this.row,
    required this.heat,
    required this.material,
    required this.fold,
  });

  final String name;
  final int row;
  final bool heat;
  final String material;
  final bool fold;

  Seat copyWith({
    String? name,
    int? row,
    bool? heat,
    String? material,
    bool? fold,
  }) {
    return Seat(
      name: name ?? this.name,
      row: row ?? this.row,
      heat: heat ?? this.heat,
      material: material ?? this.material,
      fold: fold ?? this.fold,
    );
  }
}

final class Car {
  const Car({
    required this.name,
    required this.year,
    required this.wheels,
    required this.seats,
    required this.engine,
    required this.color,
    required this.tags,
  });

  final String name;
  final int year;
  final List<Wheel> wheels;
  final List<Seat> seats;
  final Engine engine;
  final String color;
  final List<String> tags;

  Car copyWith({
    String? name,
    int? year,
    List<Wheel>? wheels,
    List<Seat>? seats,
    Engine? engine,
    String? color,
    List<String>? tags,
  }) {
    return Car(
      name: name ?? this.name,
      year: year ?? this.year,
      wheels: wheels ?? this.wheels,
      seats: seats ?? this.seats,
      engine: engine ?? this.engine,
      color: color ?? this.color,
      tags: tags ?? this.tags,
    );
  }
}

final class CarLocation {
  const CarLocation(this.index);

  final int index;
}
