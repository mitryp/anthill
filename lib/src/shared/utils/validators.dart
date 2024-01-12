import 'package:flutter/widgets.dart';
import 'package:form_validator/form_validator.dart';

// todo localization
StringValidationCallback isAmount(BuildContext context) {
  String? amountConstraint(String? value) {
    if (value == null) {
      return null;
    }

    final amount = double.tryParse(value);

    if (amount == null) {
      return 'Must be a valid amount';
    }

    if (amount == 0) {
      return 'Must be either positive or negative';
    }

    if (amount.abs() >= 1000000000) {
      return 'Must be between -10^8 and 10^8';
    }

    return null;
  }

  return ValidationBuilder(localeName: 'en').required().add(amountConstraint).build();
}

StringValidationCallback isRequired(BuildContext context, {int minLength = 1}) {
  String? notEmptyConstraint(String? value) {
    return (value?.trim().isEmpty ?? true) ? 'Must be not empty' : null;
  }

  return ValidationBuilder(localeName: 'en')
      .required()
      .minLength(minLength)
      .add(notEmptyConstraint)
      .build();
}

StringValidationCallback isPassword(
  BuildContext context, {
  int minLength = 0,
  int minNumbers = 0,
  int minLowercase = 0,
  int minUppercase = 0,
  int minSymbols = 0,
}) =>
    (value) {
      if (value == null) {
        return 'Password must be provided';
      }

      if (value.length < minLength) {
        return 'The length must be not less than $minLength';
      }

      if (value.replaceAll(RegExp(r'\D'), '').length < minNumbers) {
        return 'Must contain at least $minNumbers numbers';
      }

      if (value.replaceAll(RegExp(r'[^a-z]'), '').length < minLowercase) {
        return 'Must contain at least $minLowercase lowercase characters';
      }

      if (value.replaceAll(RegExp(r'[^A-Z]'), '').length < minUppercase) {
        return 'Must contain at least $minUppercase uppercase characters';
      }

      if (value.replaceAll(RegExp(r'(\W|_)'), '').length < minSymbols) {
        return 'Must contain at least $minSymbols symbols';
      }

      return null;
    };
