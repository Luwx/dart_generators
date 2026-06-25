## 0.0.8

* Tighten `Lens.canGet` to a non-null root, matching `Lens.get` and `Lens.set`.
  Nullable-root helpers should check null before calling the lens.

## 0.0.7

* Tighten `Lens.get`/`Lens.set` roots to non-null `Object` while keeping
  `canGet` nullable-aware, avoiding nullable-cast diagnostics in generated
  lenses.

## 0.0.6

* Export canonical `Lens` and `LensPart` runtime classes from the package, with
  documentation for generated edit paths, guarded reads, composition, and
  stable path-name equality.

## 0.0.5

* `GeneratedEditField` now carries `defaultValue`, populated from a tree prop's
  `defaultsTo`. Lets consumers read the schema default from the field ref (e.g.
  as the value to show when the lens is unreadable) without restating it.

## 0.0.4

* Emit public structural lenses and nullable read helpers for root child
  sections and list paths, including nested located list items.
* Emit tagged-list facade helpers for branch access, key/index lookup, location
  creation, and guarded structural mutations.

## 0.0.3

* Add `prop(defaultsTo:)` for tree schemas. It collapses a nullable property
  onto a non-null default: the generated lens is `Lens<T>` (not `Lens<T?>`)
  reading `prop ?? default`, writes `null` when the new value equals the
  default (compacting the key away), and the comparable projects through the
  same default so an absent value and an explicit default compare equal.
  Generalizes the hand-written `select:` + `compare: projected(... ?? default)`
  pair. Rejected (with a clear error) on `valueSchema`/flat `editSchema` props
  and when combined with `select`/`orElse`/`compare`/`adapter`/`readOnly`.

## 0.0.2

* Positional list-item lens parts now carry a `canGet` bounds guard and a
  no-op `set` when the index is out of range, matching the keyed-item contract
  ("out-of-range reads as absent"). Fixes a `RangeError` when a stale selector
  for a just-removed list row re-read its lens during a synchronous rebuild.

## 0.0.1

* TODO: Describe initial release.
