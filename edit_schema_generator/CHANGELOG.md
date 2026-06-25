## 0.0.2

* Positional list-item lens parts now carry a `canGet` bounds guard and a
  no-op `set` when the index is out of range, matching the keyed-item contract
  ("out-of-range reads as absent"). Fixes a `RangeError` when a stale selector
  for a just-removed list row re-read its lens during a synchronous rebuild.

## 0.0.1

* TODO: Describe initial release.
