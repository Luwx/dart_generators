/// Reads a value of type [T] from an edit root.
typedef LensGet<T> = T Function(Object root);

/// Writes a value of type [T] into an edit root and returns the updated root.
typedef LensSet<T> = Object Function(Object root, T value);

/// Reports whether a lens can be read for an edit root.
typedef LensCanGet = bool Function(Object root);

/// Reads a target value of type [TTarget] from a source value of type [TSource].
typedef LensPartGet<TSource, TTarget> = TTarget Function(TSource source);

/// Writes a target value of type [TTarget] into a source value of type
/// [TSource] and returns the updated source.
typedef LensPartSet<TSource, TTarget> =
    TSource Function(TSource source, TTarget value);

/// Reports whether a lens part can be read for a source value.
typedef LensPartCanGet<TSource> = bool Function(TSource source);

/// A typed path from an edit root to one editable value.
///
/// The generator emits [Lens] values for every editable field. A lens contains
/// the three operations the edit layer needs:
///
/// - [get] reads the value from the current root.
/// - [set] returns a copy of the root with the value replaced.
/// - [canGet] answers whether [get] is valid for this root.
///
/// [canGet] is important for generated paths that include optional structure,
/// list positions, keyed list items, or sealed-union narrowing. When it returns
/// false, callers should treat the value as absent instead of calling [get].
///
/// Equality is based on [name], so independently constructed lenses for the
/// same generated path can be used as stable map/provider keys.
final class Lens<T> {
  const Lens({
    required this.get,
    required LensSet<T> set,
    required this.name,
    LensCanGet? canGet,
  }) : _set = set,
       _canGet = canGet;

  /// Reads this lens value from an edit root.
  final LensGet<T> get;

  /// Stable generated path name, used for display/debugging and equality.
  final String name;

  final LensSet<T> _set;
  final LensCanGet? _canGet;

  /// Whether [get] is safe to call for [root].
  bool canGet(Object root) => _canGet?.call(root) ?? true;

  /// Returns a copy of [root] with this lens value replaced.
  ///
  /// The returned value is cast back to the static root type passed by the
  /// caller. Generated lenses are responsible for preserving that root type.
  TRoot set<TRoot extends Object>(TRoot root, T value) =>
      _set(root, value) as TRoot;

  /// Composes this root lens with a typed subpart.
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

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is Lens && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}

/// A typed path segment from a source value to one child value.
///
/// Generated code uses [LensPart] for each property, union cast, and list-item
/// hop. Parts are root-independent; composing them with [Lens.then] creates a
/// full root lens.
final class LensPart<TSource, TTarget> {
  const LensPart({
    required this.get,
    required this.set,
    required this.name,
    this.canGet,
  });

  /// Reads the child value from [TSource].
  final LensPartGet<TSource, TTarget> get;

  /// Returns a copy of [TSource] with the child value replaced.
  final LensPartSet<TSource, TTarget> set;

  /// Stable path segment name.
  final String name;

  /// Whether [get] is safe to call for this source value.
  final LensPartCanGet<TSource>? canGet;
}
