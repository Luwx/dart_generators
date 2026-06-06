import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/meta_generator_impl.dart';

Builder metaBuilder(BuilderOptions options) =>
    SharedPartBuilder([MetaGenerator()], 'meta_generator');
