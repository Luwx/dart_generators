import 'package:collection/collection.dart';

const _deepEquality = DeepCollectionEquality();

typedef FieldGetter<TRoot, TField> = TField Function(TRoot value);
typedef FieldSetter<TRoot, TField> =
    TRoot Function(TRoot value, TField fieldValue);
typedef CaseGetter<TRoot> = Object? Function(TRoot value);
typedef CaseSetter<TRoot, TCase> = TRoot Function(TRoot value, TCase nextCase);
typedef FieldProjector<TRoot> = Object? Function(TRoot? value);
typedef FieldRestorer<TRoot> =
    TRoot Function(TRoot current, TRoot saved, EditField<TRoot, Object?> field);
typedef SavedBackingPredicate<TRoot> = bool Function(TRoot? saved);
typedef FieldFallback<TRoot, TField> = TField Function(TRoot value);

EditRoot<TRoot, TLocation> editRoot<TRoot, TLocation>({
  required String id,
  required String rootLens,
  required SavedBackingSpec<TRoot> savedBacking,
  required List<EditField<TRoot, Object?>> fields,
  String? rootType,
  String? locationType,
  List<EditGroup> groups = const [],
}) => EditRoot<TRoot, TLocation>(
  id: id,
  rootType: rootType ?? _typeName<TRoot>(),
  locationType: locationType ?? _typeName<TLocation>(),
  rootLens: rootLens,
  savedBacking: savedBacking,
  fields: fields
      .map((field) => field.withDefaultCode())
      .toList(growable: false),
  groups: groups,
);

EditField<TRoot, TField> field<TRoot, TField>({
  required String id,
  required FieldSelector<TRoot, TField> select,
  CompareSpec<TRoot>? compare,
  RestoreSpec? restore,
  FallbackSpec<TRoot, TField>? fallback,
  FieldAdapterSpec<TField>? adapter,
  SavedBackingSpec<TRoot>? backing,
  String? type,
}) => EditField<TRoot, TField>(
  id: id,
  type: type ?? _typeName<TField>(),
  select: select.withDefaultFieldId(id),
  compare: compare ?? _defaultCompare<TRoot, TField>(),
  restore: restore ?? select.defaultRestore,
  fallback: fallback ?? FallbackSpec.fromSelect(),
  adapter: adapter ?? FieldAdapterSpec.identity(),
  backing: backing,
);

LeafSelector<TRoot, TField> leaf<TRoot, TField>({
  FieldGetter<TRoot, TField>? get,
  FieldSetter<TRoot, TField>? set,
  String? fieldName,
  String? getSource,
  String? setSource,
}) => LeafSelector<TRoot, TField>(
  get: get,
  set: set,
  fieldName: fieldName,
  getSource: getSource,
  setSource: setSource,
);

UnionSelector<TRoot, TCase, TField> unionField<TRoot, TCase, TField>({
  CaseGetter<TRoot>? getCase,
  CaseSetter<TRoot, TCase>? setCase,
  FieldGetter<TCase, TField>? get,
  FieldSetter<TCase, TField>? set,
  String? fieldName,
  String? caseType,
  String? caseField,
  String? caseSource,
  String? setCaseSource,
  String? getSource,
  String? setSource,
}) => UnionSelector<TRoot, TCase, TField>(
  getCase: getCase,
  setCase: setCase,
  getCaseField: get,
  setCaseField: set,
  fieldName: fieldName,
  caseType: caseType ?? _typeName<TCase>(),
  caseField: caseField,
  caseSource: caseSource,
  setCaseSource: setCaseSource,
  getSource: getSource,
  setSource: setSource,
);

EditGroup editGroup({
  required String id,
  required List<String> members,
  DirtyAggregation dirty = DirtyAggregation.tuple,
  GroupRevert revert = GroupRevert.membersInOrder,
}) => EditGroup(id: id, members: members, dirty: dirty, revert: revert);

// ---------------------------------------------------------------------------
// Tree authoring surface (codegen-only).
//
// A declarative tree of fields consumed by the source generator. Field
// identifiers are plain strings validated against the model class at build
// time; field types and the default get/set are resolved from the class, so
// no type arguments or closures are needed for the common case. Behavior
// overrides (compare/restore/get/set) are passed as typed functions only when
// the defaults are wrong; the generator derives the emitted source from those
// closures.
//
// Example:
// ```dart
// @GenerateEditSchema()
// final carSchema = editSchema<Car, CarLocation>(
//   fields: [
//     prop('name'),
//     prop('tags', compare: deep()),
//     union<GasEngine>('engine', fields: [
//       prop('engineName', property: 'name'),
//       prop('horsepower'),
//     ]),
//   ],
//   groups: [editGroup(id: 'body', members: ['name', 'tags'])],
// );
// ```
// ---------------------------------------------------------------------------

/// Codegen-only description of an edit schema.
///
/// Construct it with [editSchema]. The instance holds no behavior; the source
/// generator inspects the call expression that produced it.
final class EditSchema<TRoot, TLocation> {
  const EditSchema._();
}

/// Declares an edit schema as a tree of [prop] and [union] nodes.
///
/// - [fields]: the field tree; leaves are [prop], sealed-case projections are
///   [union] (with nested [prop] children).
/// - [groups]: named groupings declared with [editGroup].
/// - [id]/[rootLens]: default to the root type name (`Car` -> `car`,
///   `carLens`); pass to override.
/// - [savedBacking]: defaults to [SavedBackingSpec.rootExists].
EditSchema<TRoot, TLocation> editSchema<TRoot, TLocation>({
  required List<SchemaField> fields,
  List<EditGroup> groups = const [],
  String? id,
  String? rootLens,
  SavedBackingSpec<TRoot>? savedBacking,
}) => EditSchema<TRoot, TLocation>._();

/// Codegen-only description of a comparison-only value projection.
///
/// Construct it with [valueSchema]. Generates a single
/// `comparable{T}Value(T? value)` helper that projects a value of type [T] to a
/// comparable representation. Unlike [editSchema] it has no lenses, restore, or
/// saved-backing — it only describes how a value is compared, and is referenced
/// by other schemas through [composed].
final class ValueSchema<T> {
  const ValueSchema._();
}

/// Declares a comparison-only projection for type [T].
///
/// - Flat form: pass [fields] (a list of [prop] leaves). The generated helper
///   returns `[f1, f2, ...]`.
/// - Sealed form: pass [cases] (one [valueCase] per concrete subtype) and
///   optional [shared] fields applied to every case. The generated helper
///   switches on the runtime type and returns `['tag', ...shared, ...case]`,
///   falling back to `null` for unmatched values.
///
/// Field [compare] may be [composed] to delegate to another type's generated
/// `comparable{T}Value` (auto-mapping `List<T>`).
ValueSchema<T> valueSchema<T>({
  List<SchemaField> fields = const [],
  List<SchemaField> shared = const [],
  List<ValueCase> cases = const [],
}) => ValueSchema<T>._();

/// One concrete case of a sealed [valueSchema]. [TCase] is the concrete subtype,
/// [tag] is the discriminant emitted as the first tuple element, and [fields]
/// are the case's [prop] projections.
final class ValueCase {
  const ValueCase._();
}

/// [scope]: resets the lens/field display-name prefix for this case's fields
/// (the case tag is dropped from names), e.g. a `press` case with `scope: 'press'`
/// and `prop('instant')` yields `pressInstantLens`.
ValueCase valueCase<TCase>(
  String tag, {
  List<TreeField> fields = const [],
  String? scope,
}) => const ValueCase._();

/// Codegen-only description of a list property on [TRoot] holding elements of
/// type [T].
///
/// Construct it with [listSchema]. Generates guarded, copy-on-write mutation
/// helpers (`replace…At`, `update…At`, `insert…At`, `add…`, `remove…At`,
/// `duplicate…At`, `move…`) that return a new root and leave it unchanged when
/// the index is out of range.
final class ListSchema<TRoot, T> {
  const ListSchema._();
}

/// Declares list-mutation helpers for a [property] of type `List<T>` on [TRoot].
///
/// - [property]: the list property name (default get/set is `root.property` /
///   `root.copyWith(property: list)`).
/// - [id]: base name for the generated helpers (default: [property]); helpers
///   are named `replace{Id}At`, `add{Id}`, etc.
/// - [select]: a [lens] overriding the default property get/set when the list is
///   not reachable through a plain `copyWith` (e.g. computed or dispatched).
ListSchema<TRoot, T> listSchema<TRoot, T>({
  required String property,
  String? id,
  FieldAccess? select,
}) => ListSchema<TRoot, T>._();

/// Codegen-only description of a single structural edit tree rooted at [TRoot].
///
/// This is the option-B authoring surface: nested [child], [nullable], [list],
/// [sealed], and reusable [subtree] nodes are flattened by the generator into
/// path-composed lenses and comparable projections.
final class EditTree<TRoot> {
  const EditTree._();
}

EditTree<TRoot> editTree<TRoot>({
  required List<TreeField> fields,
  List<EditGroup> groups = const [],
  String? id,
}) => EditTree<TRoot>._();

/// A reusable, root-less tree node.
final class TreeNode<T> {
  const TreeNode._();
}

TreeNode<T> subtree<T>({
  List<TreeField> fields = const [],
  List<SchemaField> shared = const [],
  List<ValueCase> cases = const [],
  List<EditGroup> groups = const [],
  bool Function(T value)? compactWhen,
  String? id,
}) => TreeNode<T>._();

sealed class TreeField {
  const TreeField._();
}

final class _TreeChildField extends TreeField {
  const _TreeChildField._() : super._();
}

final class _TreeNullableField extends TreeField {
  const _TreeNullableField._() : super._();
}

final class _TreeListField extends TreeField {
  const _TreeListField._() : super._();
}

final class _TreeSealedField extends TreeField {
  const _TreeSealedField._() : super._();
}

final class _TreeTaggedListsField extends TreeField {
  const _TreeTaggedListsField._() : super._();
}

final class _TreeDispatchField extends TreeField {
  const _TreeDispatchField._() : super._();
}

TreeField child(
  String id, {
  List<TreeField> fields = const [],
  TreeNode<dynamic>? node,
  String? name,
  String? scope,
  FieldAccess? select,
}) => const _TreeChildField._();

TreeField nullable(
  String id, {
  List<TreeField> fields = const [],
  TreeNode<dynamic>? node,
  Object? orElse,
  String? name,
  String? scope,
  FieldAccess? select,
}) => const _TreeNullableField._();

/// [scope]: resets the lens/field *display name* prefix for this list's subtree
/// to the given token (the traversal path is unchanged), e.g. `scope: 'action'`
/// turns `gestureCommonActionActionCommandCommandLens` into `actionCommandLens`.
///
/// [location]/[parentField]/[indexField]: when this list nests under a path that
/// already carries a non-int location param, collapse the mixed params into one
/// generated location object named [location], whose lead field is [parentField]
/// (the inherited location) and whose index field is [indexField] (default
/// `{singular}Index`). E.g. `location: 'ActionLocation', parentField: 'gesture',
/// indexField: 'actionIndex'` → `actionCommandLens(ActionLocation location)`.
TreeField list(
  String id, {
  required TreeNode<dynamic> of,
  String? name,
  String? scope,
  String? location,
  String? parentField,
  String? indexField,
}) => const _TreeListField._();

TreeField sealed(
  String id, {
  List<SchemaField> shared = const [],
  required List<ValueCase> cases,
  CaseAccess? select,
  String? name,
}) => const _TreeSealedField._();

/// Cross-cutting list discriminator: one [TLocation] addresses several lists,
/// dispatched by a discriminator enum [TCategory]. The generated `[lens]`
/// function returns `Lens<TElement>` (the lists' common supertype, e.g. the
/// app's `Item`), so [shared] fields declared once (reached through
/// [TElement]) yield a single lens family, while each entry's per-case fields
/// yield per-entry families.
///
/// - [lens]: name of the generated dispatcher (e.g. `itemLens`).
/// - [discriminator]/[index]: the [TLocation] fields holding the enum and the
///   list index (e.g. `category`/`index`).
/// - [shared]: fields present on every entry, accessed via [TElement]; pass a
///   `select:` on a [child]/[prop] when the setter isn't a plain `copyWith`
///   (e.g. `withCommon`).
/// - [lists]: maps each [TCategory] value to `(listProperty, perEntrySubtree)`.
/// - [name]: base name for the [shared] lens family (default: lowered [TElement]).
/// [generateLocation]: emit the [TLocation] value class (lead field
/// [discriminator] of type [TCategory] + int [index] field) instead of treating
/// it as an externally-defined type.
TreeField taggedLists<TLocation, TElement, TCategory>({
  required String lens,
  required String discriminator,
  required Map<TCategory, (String, TreeNode<dynamic>)> lists,
  String index = 'index',
  List<TreeField> shared = const [],
  String? name,
  bool generateLocation = false,
}) => const _TreeTaggedListsField._();

/// Cross-cutting singleton dispatcher: one shared [node] shape stored under
/// several sibling properties of [TRoot], selected at runtime by a [TCategory]
/// enum. Unlike [taggedLists] (which fans lists out by index), this addresses
/// a single nullable value per category — e.g. `mouseSpeed`/`touchpadSpeed`/
/// `touchscreenSpeed`, all of type `SpeedSettings`, dispatched by `DeviceType`.
///
/// The generated [lens] function returns `Lens<TNode>(TCategory)` (the node's
/// type), reading `root.<branch> ?? const TNode()` and writing back through
/// `copyWith`. If [node] declares `compactWhen`, an empty value writes `null`
/// (the property is compacted away). Categories absent from [branches] read a
/// `const TNode()` and ignore writes.
///
/// The node's fields each yield a `{name}{Field}Lens(TCategory)` family
/// composed on top of the dispatcher, mirroring the per-field lenses a flat
/// `editSchema<TNode, TCategory>` would emit.
///
/// - [lens]: name of the generated section dispatcher (e.g. `speedSettingsLens`).
/// - [node]: the shared per-category shape (a [subtree]).
/// - [branches]: maps each [TCategory] value to the property name on [TRoot].
/// - [name]: base for the per-field lens family (default: lowered node type).
/// - [param]: the generated parameter name (cosmetic; default `category`).
TreeField dispatch<TCategory>({
  required String lens,
  required TreeNode<dynamic> node,
  required Map<TCategory, String> branches,
  String? name,
  String param = 'category',
}) => const _TreeDispatchField._();

/// A node in an [editSchema] field tree: a [prop] leaf or a [union] case.
sealed class SchemaField extends TreeField {
  const SchemaField._() : super._();
}

final class _PropField extends SchemaField {
  const _PropField._() : super._();
}

/// A leaf field.
///
/// - [id]: the dirty-field identifier and, by default, the property name.
/// - [property]: the underlying property when it differs from [id].
/// - [compare]/[restore]: strategy overrides (default: by type / replaceLeaf).
/// - [select]: a [lens] overriding the default `value.prop` / `copyWith` access.
/// - [orElse]: value-schema only. A default substituted when the projected
///   field reads null, emitted verbatim as `… ?? <orElse>` (e.g.
///   `prop('mouseButtons', orElse: const <Object?>[])`). Replaces a
///   `projected((v) => v?.x ?? default)` wrapper. Ignored when [compare] is
///   [projected] or [composed].
/// - [readOnly]: a comparison-only field with no underlying property/lens. It
///   contributes an enum member, comparable projection, and saved-backing
///   branch, but no lens accessor and a no-op restore. Requires
///   [compare] to be [projected].
SchemaField prop(
  String id, {
  String? property,
  CompareSpec<Object?>? compare,
  RestoreSpec? restore,
  FallbackSpec<Object?, Object?>? fallback,
  FieldAdapterSpec<Object?>? adapter,
  SavedBackingSpec<Object?>? backing,
  FieldAccess? select,
  Object? orElse,
  bool readOnly = false,
}) => const _PropField._();

final class _UnionField extends SchemaField {
  const _UnionField._() : super._();
}

/// A sealed-case projection. [TCase] is the concrete case type, [via] is the
/// root property holding the sealed value, and [fields] are the case's [prop]
/// children. [select] overrides the default case get/replace with a [caseLens].
SchemaField union<TCase>(
  String via, {
  required List<SchemaField> fields,
  CaseAccess? select,
}) => const _UnionField._();

/// Overrides a leaf's get/set with typed functions. The generator reads the
/// source of [get]/[set] to emit the lens; pass only when the default
/// `value.prop` / `value.copyWith(prop: next)` is wrong.
final class FieldAccess {
  const FieldAccess._();
}

FieldAccess lens<TRoot, TField>({
  required TField Function(TRoot value) get,
  required TRoot Function(TRoot value, TField next) set,
}) => const FieldAccess._();

/// Overrides a union's case get/replace with typed functions.
final class CaseAccess {
  const CaseAccess._();
}

CaseAccess caseLens<TRoot, TCase>({
  required TCase Function(TRoot value) get,
  required TRoot Function(TRoot value, TCase next) set,
}) => const CaseAccess._();

/// Compare override: identity (`==`) comparison of the projected value.
CompareSpec<Object?> scalar() => CompareSpec<Object?>.scalar();

/// Compare override: deep collection equality of the projected value.
CompareSpec<Object?> deep() => CompareSpec<Object?>.deepCollection();

/// Compare override: compares a custom projection. The generator emits the
/// source of [project] (with its parameter rewritten to `value`).
///
/// Returns an erased `CompareSpec<Object?>` so [TRoot]/[TField] infer upward
/// from [project] rather than downward from the `prop` argument context.
CompareSpec<Object?> projected<TRoot, TField>(
  TField Function(TRoot? value) project,
) => CompareSpec<Object?>.projected(
  project: (value) => project(value as TRoot?),
);

/// Compare override: delegate to the field type's generated
/// `comparable{T}Value` helper (declared by a [valueSchema] or another schema).
/// For `List<T>` fields the generator maps each element through it. The field
/// type is read from the model class (or the `prop`'s explicit field type arg).
CompareSpec<Object?> composed() => CompareSpec<Object?>.composed();

/// Saved-backing override: the field is backed whenever the saved root exists
/// (`saved != null`). This is the per-root default; pass it to a field only to
/// be explicit.
SavedBackingSpec<Object?> rootExists() => SavedBackingSpec.rootExists();

/// Saved-backing override: the field is backed when [predicate] holds for the
/// (non-null) saved root. The generator emits the source of [predicate] guarded
/// by a null check, so a null saved root reports no backing.
SavedBackingSpec<Object?> backedWhen<TRoot>(
  bool Function(TRoot saved) predicate,
) => SavedBackingSpec<Object?>.custom(
  hasBacking: (saved) => saved != null && predicate(saved as TRoot),
  source: '<closure>',
);

/// Restore override: replace the whole leaf with the saved value.
RestoreSpec replaceLeaf() => RestoreSpec.replaceLeaf();

/// Restore override: merge the saved leaf into the current case.
RestoreSpec mergeLeaf() => RestoreSpec.mergeLeaf();

/// Fallback value used when the UI has no loaded config yet but has the model
/// root currently being edited. Defaults to the same value selected by the
/// field lens.
final class FallbackSpec<TRoot, TField> {
  const FallbackSpec._({required this.kind, this.get, this.source});

  factory FallbackSpec.fromSelect() =>
      FallbackSpec<TRoot, TField>._(kind: FallbackKind.fromSelect);

  factory FallbackSpec.none() =>
      FallbackSpec<TRoot, TField>._(kind: FallbackKind.none);

  factory FallbackSpec.custom({
    required FieldFallback<TRoot, TField> get,
    String? source,
  }) => FallbackSpec<TRoot, TField>._(
    kind: FallbackKind.custom,
    get: get,
    source: source,
  );

  final FallbackKind kind;
  final FieldFallback<TRoot, TField>? get;
  final String? source;
}

enum FallbackKind { fromSelect, none, custom }

FallbackSpec<Object?, Object?> noFallback() =>
    FallbackSpec<Object?, Object?>.none();

FallbackSpec<Object?, Object?> fallback<TRoot, TField>(
  TField Function(TRoot value) get,
) => FallbackSpec<Object?, Object?>.custom(get: (value) => get(value as TRoot));

/// UI adapter behavior. The schema stays domain-first; adapters own the
/// canonical text <-> value normalization so the UI layer never branches on
/// field kinds. [format] renders a field value for a text input; [parse] turns
/// raw input back into a field value, or rejects it (e.g. malformed number) so
/// the caller can ignore the edit.
final class FieldAdapterSpec<TField> {
  const FieldAdapterSpec._({required this.format, required this.parse});

  /// Pass-through adapter: the value is its own text. Used for plain string
  /// fields and as the default for non-text fields.
  factory FieldAdapterSpec.identity() => FieldAdapterSpec<TField>._(
    format: (value) => value is String ? value : value.toString(),
    parse: (text) => FieldParseAccepted<TField>(text as TField),
  );

  /// Nullable string field: empty text reads and writes as `null`.
  factory FieldAdapterSpec.nullableText() => FieldAdapterSpec<TField>._(
    format: (value) => (value as String?) ?? '',
    parse: (text) =>
        FieldParseAccepted<TField>((text.isEmpty ? null : text) as TField),
  );

  /// Nullable int field: empty text is `null`; unparseable text is rejected.
  factory FieldAdapterSpec.nullableInt() => FieldAdapterSpec<TField>._(
    format: (value) => (value as int?)?.toString() ?? '',
    parse: (text) => _parseNullableNum<TField>(text, int.tryParse),
  );

  /// Nullable double field: empty text is `null`; unparseable text is rejected.
  factory FieldAdapterSpec.nullableDouble() => FieldAdapterSpec<TField>._(
    format: (value) => (value as double?)?.toString() ?? '',
    parse: (text) => _parseNullableNum<TField>(text, double.tryParse),
  );

  /// Custom adapter: supply your own [format] and [parse] for a one-off field.
  /// Prefer the named factories above for the common cases.
  const factory FieldAdapterSpec.custom({
    required String Function(TField value) format,
    required FieldParseResult<TField> Function(String text) parse,
  }) = FieldAdapterSpec<TField>._;

  /// Formats a field value for display in a text input.
  final String Function(TField value) format;

  /// Parses raw input text into a field value, or rejects it.
  final FieldParseResult<TField> Function(String text) parse;
}

/// Shared empty-is-null + tryParse logic for the nullable numeric adapters.
FieldParseResult<TField> _parseNullableNum<TField>(
  String text,
  num? Function(String) tryParse,
) {
  if (text.isEmpty) return FieldParseAccepted<TField>(null as TField);
  final parsed = tryParse(text);
  return parsed == null
      ? FieldParseRejected<TField>()
      : FieldParseAccepted<TField>(parsed as TField);
}

/// Outcome of [FieldAdapterSpec.parse].
sealed class FieldParseResult<TField> {
  const FieldParseResult();
}

/// Parsing succeeded; [value] should be written to the field.
final class FieldParseAccepted<TField> extends FieldParseResult<TField> {
  const FieldParseAccepted(this.value);

  final TField value;
}

/// Parsing failed; the edit should be ignored, leaving the field unchanged.
final class FieldParseRejected<TField> extends FieldParseResult<TField> {
  const FieldParseRejected();
}

FieldAdapterSpec<String?> nullableText() =>
    FieldAdapterSpec<String?>.nullableText();

FieldAdapterSpec<int?> nullableInt() => FieldAdapterSpec<int?>.nullableInt();

FieldAdapterSpec<double?> nullableDouble() =>
    FieldAdapterSpec<double?>.nullableDouble();

/// Generated field metadata consumed by app UI helpers. [TLens] is intentionally
/// generic so the package does not depend on a concrete lens implementation.
final class GeneratedEditField<TRoot, TLocation, TField, TLens> {
  const GeneratedEditField({
    required this.id,
    required this.dirtyField,
    required this.lens,
    required this.fallback,
    required this.adapter,
  });

  final String id;
  final Object dirtyField;
  final TLens Function(TLocation location) lens;
  final TField Function(TRoot root)? fallback;
  final FieldAdapterSpec<TField> adapter;
}

final class EditRoot<TRoot, TLocation> {
  const EditRoot({
    required this.id,
    required this.rootType,
    required this.locationType,
    required this.rootLens,
    required this.savedBacking,
    required this.fields,
    required this.groups,
  });

  final String id;
  final String rootType;
  final String locationType;
  final String rootLens;
  final SavedBackingSpec<TRoot> savedBacking;
  final List<EditField<TRoot, Object?>> fields;
  final List<EditGroup> groups;

  SchemaValidationResult validate() {
    final errors = <String>[];
    _validateUniqueIds(
      errors: errors,
      label: 'field',
      ids: fields.map((field) => field.id),
    );
    _validateUniqueIds(
      errors: errors,
      label: 'group',
      ids: groups.map((group) => group.id),
    );

    final fieldIds = fields.map((field) => field.id).toSet();
    for (final group in groups) {
      for (final member in group.members) {
        if (!fieldIds.contains(member)) {
          errors.add('Group "${group.id}" references unknown field "$member".');
        }
      }
    }

    for (final field in fields) {
      if (field.restore.kind == RestoreKind.mergeLeaf &&
          field.select is! UnionSelector<TRoot, Object?, Object?>) {
        final message =
            'Field "${field.id}" uses mergeLeaf restore without a union '
            'selector.';
        errors.add(message);
      }
    }

    return SchemaValidationResult(errors);
  }

  Object? comparableFieldValue(TRoot? value, String fieldId) {
    final editField = fieldById(fieldId);
    return editField.compare.project(value, editField);
  }

  Object? comparableGroupValue(TRoot? value, String groupId) {
    final editGroup = groupById(groupId);
    return editGroup.members
        .map((fieldId) => comparableFieldValue(value, fieldId))
        .toList(growable: false);
  }

  TRoot restoreField({
    required TRoot current,
    required TRoot saved,
    required String fieldId,
  }) {
    final editField = fieldById(fieldId);
    return editField.restore.restore(current, saved, editField);
  }

  bool hasSavedBacking(TRoot? saved) => savedBacking.hasBacking(saved);

  /// Whether [fieldId] is backed by the saved root. Uses the field's own
  /// [EditField.backing] when set, otherwise the root [savedBacking].
  bool fieldHasSavedBacking(TRoot? saved, String fieldId) =>
      (fieldById(fieldId).backing ?? savedBacking).hasBacking(saved);

  /// True when any field declares a [EditField.backing] override, meaning
  /// saved-backing must be resolved per field rather than per root.
  bool get hasFieldBacking => fields.any((field) => field.backing != null);

  EditField<TRoot, Object?> fieldById(String id) {
    for (final editField in fields) {
      if (editField.id == id) return editField;
    }
    throw StateError('Unknown field "$id" in edit root "$this.id".');
  }

  EditGroup groupById(String id) {
    for (final editGroup in groups) {
      if (editGroup.id == id) return editGroup;
    }
    throw StateError('Unknown group "$id" in edit root "$this.id".');
  }
}

final class EditField<TRoot, TField> {
  const EditField({
    required this.id,
    required this.type,
    required this.select,
    required this.compare,
    required this.restore,
    required this.fallback,
    required this.adapter,
    this.backing,
  });

  final String id;
  final String type;
  final FieldSelector<TRoot, TField> select;
  final CompareSpec<TRoot> compare;
  final RestoreSpec restore;
  final FallbackSpec<TRoot, TField> fallback;
  final FieldAdapterSpec<TField> adapter;

  /// Per-field saved-backing override. Null means the field inherits the root's
  /// [EditRoot.savedBacking].
  final SavedBackingSpec<TRoot>? backing;

  EditField<TRoot, TField> withDefaultCode() => EditField<TRoot, TField>(
    id: id,
    type: type,
    select: select.withDefaultFieldId(id),
    compare: compare,
    restore: restore,
    fallback: fallback,
    adapter: adapter,
    backing: backing,
  );
}

sealed class FieldSelector<TRoot, TField> {
  const FieldSelector({this.getSource, this.setSource});

  final String? getSource;
  final String? setSource;

  TField get(TRoot value);

  TRoot set(TRoot value, TField fieldValue);

  String getterExpression(String rootVariable);

  String setterExpression(String rootVariable, String nextVariable);

  RestoreSpec get defaultRestore;

  FieldSelector<TRoot, TField> withDefaultFieldId(String id);
}

final class LeafSelector<TRoot, TField> extends FieldSelector<TRoot, TField> {
  const LeafSelector({
    FieldGetter<TRoot, TField>? get,
    FieldSetter<TRoot, TField>? set,
    super.getSource,
    super.setSource,
    this.fieldName,
  }) : _get = get,
       _set = set;

  final FieldGetter<TRoot, TField>? _get;
  final FieldSetter<TRoot, TField>? _set;
  final String? fieldName;

  @override
  TField get(TRoot value) => _requireGetter(_get)(value);

  @override
  TRoot set(TRoot value, TField fieldValue) =>
      _requireSetter(_set)(value, fieldValue);

  @override
  RestoreSpec get defaultRestore => RestoreSpec.replaceLeaf();

  @override
  String getterExpression(String rootVariable) => _requireSource(
    getSource ?? r'$root.' + _requireFieldName(),
  ).replaceAll(r'$root', rootVariable);

  @override
  String setterExpression(String rootVariable, String nextVariable) =>
      _requireSource(
        setSource ?? r'$root.copyWith(' + _requireFieldName() + r': $next)',
      ).replaceAll(r'$root', rootVariable).replaceAll(r'$next', nextVariable);

  @override
  LeafSelector<TRoot, TField> withDefaultFieldId(String id) =>
      LeafSelector<TRoot, TField>(
        get: _get,
        set: _set,
        fieldName: fieldName ?? id,
        getSource: getSource,
        setSource: setSource,
      );

  String _requireFieldName() {
    final name = fieldName;
    if (name == null) {
      throw StateError('Leaf selector is missing a field name.');
    }
    return name;
  }
}

final class UnionSelector<TRoot, TCase, TField>
    extends FieldSelector<TRoot, TField> {
  const UnionSelector({
    required this.getCase,
    required this.setCase,
    required this.caseType,
    this.getCaseField,
    this.setCaseField,
    super.getSource,
    super.setSource,
    this.fieldName,
    this.caseField,
    this.caseSource,
    this.setCaseSource,
  });

  final CaseGetter<TRoot>? getCase;
  final CaseSetter<TRoot, TCase>? setCase;
  final FieldGetter<TCase, TField>? getCaseField;
  final FieldSetter<TCase, TField>? setCaseField;
  final String? fieldName;
  final String caseType;
  final String? caseField;
  final String? caseSource;
  final String? setCaseSource;

  @override
  TField get(TRoot value) =>
      _requireGetter(getCaseField)(_requireCaseGetter(getCase)(value) as TCase);

  @override
  TRoot set(TRoot value, TField fieldValue) => _requireCaseSetter(setCase)(
    value,
    _requireSetter(setCaseField)(
      _requireCaseGetter(getCase)(value) as TCase,
      fieldValue,
    ),
  );

  @override
  RestoreSpec get defaultRestore => RestoreSpec.mergeLeaf();

  String caseExpression(String rootVariable) => _requireSource(
    caseSource ?? r'$root.' + _requireCaseField(),
  ).replaceAll(r'$root', rootVariable);

  String replaceCaseExpression(
    String rootVariable,
    String nextCaseVariable,
  ) => _requireSource(
    setCaseSource ?? r'$root.copyWith(' + _requireCaseField() + r': $case)',
  ).replaceAll(r'$root', rootVariable).replaceAll(r'$case', nextCaseVariable);

  @override
  String getterExpression(String rootVariable) => _requireSource(
    getSource ?? r'$case.' + _requireFieldName(),
  ).replaceAll(r'$case', rootVariable);

  @override
  String setterExpression(String rootVariable, String nextVariable) =>
      _requireSource(
        setSource ?? r'$case.copyWith(' + _requireFieldName() + r': $next)',
      ).replaceAll(r'$case', rootVariable).replaceAll(r'$next', nextVariable);

  @override
  UnionSelector<TRoot, TCase, TField> withDefaultFieldId(String id) =>
      UnionSelector<TRoot, TCase, TField>(
        getCase: getCase,
        setCase: setCase,
        getCaseField: getCaseField,
        setCaseField: setCaseField,
        fieldName: fieldName ?? id,
        caseType: caseType,
        caseField: caseField,
        caseSource: caseSource,
        setCaseSource: setCaseSource,
        getSource: getSource,
        setSource: setSource,
      );

  String _requireFieldName() {
    final name = fieldName;
    if (name == null) {
      throw StateError('Union selector is missing a field name.');
    }
    return name;
  }

  String _requireCaseField() {
    final name = caseField;
    if (name == null) {
      throw StateError(
        'Union selector needs caseField, caseSource, or setCaseSource for '
        'temporary runtime code generation.',
      );
    }
    return name;
  }
}

final class CompareSpec<TRoot> {
  const CompareSpec._({
    required this.kind,
    required this.project,
    this.projectSource,
  });

  factory CompareSpec.scalar() => CompareSpec<TRoot>._(
    kind: CompareKind.scalar,
    project: (value, field) {
      if (value == null) return null;
      final selector = field.select;
      if (selector is UnionSelector<TRoot, Object?, Object?> &&
          selector.getCase != null &&
          selector.getCase?.call(value) == null) {
        return null;
      }
      return field.select.get(value);
    },
  );

  factory CompareSpec.deepCollection() => CompareSpec<TRoot>._(
    kind: CompareKind.deepCollection,
    project: (value, field) {
      if (value == null) return null;
      final selector = field.select;
      if (selector is UnionSelector<TRoot, Object?, Object?> &&
          selector.getCase != null &&
          selector.getCase?.call(value) == null) {
        return null;
      }
      return field.select.get(value);
    },
  );

  factory CompareSpec.projected({
    required FieldProjector<TRoot> project,
    String? source,
  }) => CompareSpec<TRoot>._(
    kind: CompareKind.projected,
    project: (value, _) => project(value),
    projectSource: source,
  );

  /// Comparison-only; resolved entirely by the source generator, which emits a
  /// call to the field type's `comparable{T}Value`. Has no runtime projection.
  factory CompareSpec.composed() => CompareSpec<TRoot>._(
    kind: CompareKind.composed,
    project: (value, field) => throw UnsupportedError(
      'composed() compare is codegen-only and has no runtime projection.',
    ),
  );

  final CompareKind kind;
  final Object? Function(TRoot? value, EditField<TRoot, Object?> field) project;
  final String? projectSource;

  bool equals(Object? current, Object? saved) {
    return switch (kind) {
      CompareKind.scalar ||
      CompareKind.projected ||
      CompareKind.composed => current == saved,
      CompareKind.deepCollection => _deepEquality.equals(current, saved),
    };
  }
}

enum CompareKind { scalar, deepCollection, projected, composed }

final class RestoreSpec {
  const RestoreSpec._({required this.kind, FieldRestorer<Object?>? restore})
    : _restore = restore;

  factory RestoreSpec.replaceLeaf() =>
      const RestoreSpec._(kind: RestoreKind.replaceLeaf);

  factory RestoreSpec.mergeLeaf() =>
      const RestoreSpec._(kind: RestoreKind.mergeLeaf);

  factory RestoreSpec.custom(FieldRestorer<Object?> restore) =>
      RestoreSpec._(kind: RestoreKind.custom, restore: restore);

  final RestoreKind kind;
  final FieldRestorer<Object?>? _restore;

  TRoot restore<TRoot>(
    TRoot current,
    TRoot saved,
    EditField<TRoot, Object?> field,
  ) {
    if (kind == RestoreKind.custom) {
      return _restore!(current, saved, field as EditField<Object?, Object?>)
          as TRoot;
    }
    final savedValue = field.select.get(saved);
    return field.select.set(current, savedValue);
  }
}

enum RestoreKind { replaceLeaf, mergeLeaf, custom }

final class SavedBackingSpec<TRoot> {
  const SavedBackingSpec._({
    required this.kind,
    required this.hasBacking,
    this.source,
  });

  factory SavedBackingSpec.rootExists() => SavedBackingSpec<TRoot>._(
    kind: SavedBackingKind.rootExists,
    hasBacking: (saved) => saved != null,
    source: r'$saved != null',
  );

  factory SavedBackingSpec.custom({
    required SavedBackingPredicate<TRoot> hasBacking,
    required String source,
  }) => SavedBackingSpec<TRoot>._(
    kind: SavedBackingKind.custom,
    hasBacking: hasBacking,
    source: source,
  );

  final SavedBackingKind kind;
  final SavedBackingPredicate<TRoot> hasBacking;
  final String? source;
}

enum SavedBackingKind { rootExists, custom }

final class EditGroup {
  const EditGroup({
    required this.id,
    required this.members,
    required this.dirty,
    required this.revert,
  });

  final String id;
  final List<String> members;
  final DirtyAggregation dirty;
  final GroupRevert revert;
}

enum DirtyAggregation { tuple, anyDirty }

enum GroupRevert { membersInOrder }

final class SchemaValidationResult {
  const SchemaValidationResult(this.errors);

  final List<String> errors;

  bool get isValid => errors.isEmpty;

  void throwIfInvalid() {
    if (isValid) return;
    throw SchemaValidationException(errors);
  }
}

final class SchemaValidationException implements Exception {
  const SchemaValidationException(this.errors);

  final List<String> errors;

  @override
  String toString() => 'SchemaValidationException(${errors.join('; ')})';
}

void _validateUniqueIds({
  required List<String> errors,
  required String label,
  required Iterable<String> ids,
}) {
  final seen = <String>{};
  for (final id in ids) {
    if (id.trim().isEmpty) {
      errors.add('A $label id cannot be empty.');
    }
    if (!seen.add(id)) {
      errors.add('Duplicate $label id "$id".');
    }
  }
}

String _typeName<T>() => T.toString();

CompareSpec<TRoot> _defaultCompare<TRoot, TField>() {
  final type = _typeName<TField>();
  if (type.startsWith('List<') ||
      type.startsWith('Set<') ||
      type.startsWith('Map<')) {
    return CompareSpec<TRoot>.deepCollection();
  }
  return CompareSpec<TRoot>.scalar();
}

String _requireSource(String? source) {
  if (source == null) {
    throw StateError('Selector is missing source code hints.');
  }
  return source;
}

FieldGetter<TSource, TValue> _requireGetter<TSource, TValue>(
  FieldGetter<TSource, TValue>? get,
) {
  if (get == null) {
    throw StateError(
      'This selector omits get; use source generation or provide get.',
    );
  }
  return get;
}

FieldSetter<TSource, TValue> _requireSetter<TSource, TValue>(
  FieldSetter<TSource, TValue>? set,
) {
  if (set == null) {
    throw StateError(
      'This selector omits set; use source generation or provide set.',
    );
  }
  return set;
}

CaseGetter<TRoot> _requireCaseGetter<TRoot>(CaseGetter<TRoot>? getCase) {
  if (getCase == null) {
    throw StateError(
      'This union selector omits getCase; use source generation or provide '
      'getCase.',
    );
  }
  return getCase;
}

CaseSetter<TRoot, TCase> _requireCaseSetter<TRoot, TCase>(
  CaseSetter<TRoot, TCase>? setCase,
) {
  if (setCase == null) {
    throw StateError(
      'This union selector omits setCase; use source generation or provide '
      'setCase.',
    );
  }
  return setCase;
}
