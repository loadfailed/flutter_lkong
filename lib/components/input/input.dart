import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InputBorder extends OutlineInputBorder {
  InputBorder({
    Key key,
    BorderSide borderSide: const BorderSide(),
    BorderRadius borderRadius: const BorderRadius.all(Radius.circular(2.0)),
    double gapPadding: 2.0,
    this.cut: 7.0,
  }) : super(
            borderSide: borderSide,
            borderRadius: borderRadius,
            gapPadding: gapPadding);

  final cut;

  @override
  InputBorder copyWith(
      {BorderSide borderSide,
      BorderRadius borderRadius,
      double gapPadding,
      double cut}) {
    return InputBorder(
      borderRadius: borderRadius ?? this.borderRadius,
      borderSide: borderSide ?? this.borderSide,
      cut: cut ?? this.cut,
      gapPadding: gapPadding ?? this.gapPadding,
    );
  }
}
