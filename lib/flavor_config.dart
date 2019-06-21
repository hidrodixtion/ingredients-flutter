import 'package:flutter/material.dart';
import 'package:ingredients/utils/string_utils.dart';

enum Flavor {
  DEVELOPMENT, PRODUCTION
}

class FlavorConfig {
  final Flavor flavor;
  final Color color;
  final String name;

  static FlavorConfig _sh;

  factory FlavorConfig({@required Flavor flavor, @required Color color}) {
    _sh ??= FlavorConfig._internal(flavor, StringUtils.enumName(flavor.toString()), color);
    return _sh;
  }

  static FlavorConfig get shared => _sh;

  FlavorConfig._internal(this.flavor, this.name, this.color);

  static bool isProduction() => _sh.flavor == Flavor.PRODUCTION;
  static bool isDevelopment() => _sh.flavor == Flavor.DEVELOPMENT;
}