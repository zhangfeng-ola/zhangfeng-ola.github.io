//
//  Generated code. Do not modify.
//  source: display.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// create a proto buffer file
/// define the message type Cmd which include an enum Op and a message Data
class DisplayModel extends $pb.ProtobufEnum {
  static const DisplayModel Normal = DisplayModel._(0, _omitEnumNames ? '' : 'Normal');
  static const DisplayModel Search = DisplayModel._(1, _omitEnumNames ? '' : 'Search');

  static const $core.List<DisplayModel> values = <DisplayModel> [
    Normal,
    Search,
  ];

  static final $core.Map<$core.int, DisplayModel> _byValue = $pb.ProtobufEnum.initByValue(values);
  static DisplayModel? valueOf($core.int value) => _byValue[value];

  const DisplayModel._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
