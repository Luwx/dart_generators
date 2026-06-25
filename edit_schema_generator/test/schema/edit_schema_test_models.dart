sealed class FixtureVariant {
  const FixtureVariant();
}

final class TextVariant extends FixtureVariant {
  const TextVariant({required this.text, this.flag});

  final String text;
  final bool? flag;

  bool get effectiveFlag => flag ?? true;

  TextVariant copyWith({String? text, Object? flag = _unset}) {
    return TextVariant(
      text: text ?? this.text,
      flag: identical(flag, _unset) ? this.flag : flag as bool?,
    );
  }
}

final class ListVariant extends FixtureVariant {
  const ListVariant({required this.items});

  final List<String> items;

  ListVariant copyWith({List<String>? items}) {
    return ListVariant(items: items ?? this.items);
  }
}

final class FixtureNode {
  const FixtureNode({
    required this.variant,
    this.mode,
    this.labels = const [],
  });

  final FixtureVariant variant;
  final String? mode;
  final List<String> labels;

  FixtureNode copyWith({
    FixtureVariant? variant,
    Object? mode = _unset,
    List<String>? labels,
  }) {
    return FixtureNode(
      variant: variant ?? this.variant,
      mode: identical(mode, _unset) ? this.mode : mode as String?,
      labels: labels ?? this.labels,
    );
  }
}

final class FixtureDocument {
  const FixtureDocument({this.nodes = const []});

  final List<FixtureNode> nodes;

  FixtureDocument copyWith({List<FixtureNode>? nodes}) {
    return FixtureDocument(nodes: nodes ?? this.nodes);
  }
}

final class FixtureLocation {
  const FixtureLocation(this.index);

  final int index;
}

const _unset = Object();
