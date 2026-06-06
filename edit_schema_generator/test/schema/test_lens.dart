typedef LensGet<T> = T Function(Object? root);
typedef LensSet<T> = Object? Function(Object? root, T value);
typedef PartGet<TSource, TTarget> = TTarget Function(TSource value);
typedef PartSet<TSource, TTarget> = TSource Function(TSource value, TTarget next);

final class Lens<T> {
  const Lens({required this.get, required this.set, required this.name});

  final LensGet<T> get;
  final LensSet<T> set;
  final String name;

  Lens<TNext> then<TNext>(LensPart<T, TNext> part) {
    return Lens<TNext>(
      get: (root) => part.get(get(root)),
      set: (root, value) {
        final source = get(root);
        final updated = part.set(source, value);
        return set(root, updated);
      },
      name: '$name.${part.name}',
    );
  }
}

final class LensPart<TSource, TTarget> {
  const LensPart({
    required this.get,
    required this.set,
    required this.name,
  });

  final PartGet<TSource, TTarget> get;
  final PartSet<TSource, TTarget> set;
  final String name;
}
