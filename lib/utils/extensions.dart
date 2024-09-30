import 'package:flutter/material.dart';

extension Mysize on int{
  SizedBox get h => SizedBox(
    height: toDouble(),
  );

  SizedBox get w => SizedBox(
    width: toDouble(),
  );
}