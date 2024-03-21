import 'dart:math';

extension RoundWithPrecision on double {
  double roundWithPrecision([int digits = 2]) {
    final multiplier = pow(10, digits);

    return (this * multiplier).roundToDouble() / multiplier;
  }
}
