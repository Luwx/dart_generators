typedef LensGet<T> = T Function(Object? root);
typedef LensSet<T> = Object? Function(Object? root, T value);
typedef LensCanGet = bool Function(Object? root);
typedef PartGet<TSource, TTarget> = TTarget Function(TSource value);
typedef PartSet<TSource, TTarget> =
    TSource Function(TSource value, TTarget next);
typedef PartCanGet<TSource> = bool Function(TSource value);

final class Lens<T> {
  const Lens({
    required this.get,
    required this.set,
    required this.name,
    LensCanGet? canGet,
  }) : _canGet = canGet;

  final LensGet<T> get;
  final LensSet<T> set;
  final String name;
  final LensCanGet? _canGet;

  bool canGet(Object? root) => _canGet?.call(root) ?? true;

  Lens<TNext> then<TNext>(LensPart<T, TNext> part) {
    return Lens<TNext>(
      get: (root) => part.get(get(root)),
      set: (root, value) {
        final source = get(root);
        final updated = part.set(source, value);
        return set(root, updated);
      },
      name: '$name.${part.name}',
      canGet: (root) {
        if (!canGet(root)) return false;
        final partCanGet = part.canGet;
        return partCanGet == null || partCanGet(get(root));
      },
    );
  }
}

final class LensPart<TSource, TTarget> {
  const LensPart({
    required this.get,
    required this.set,
    required this.name,
    this.canGet,
  });

  final PartGet<TSource, TTarget> get;
  final PartSet<TSource, TTarget> set;
  final String name;
  final PartCanGet<TSource>? canGet;
}
