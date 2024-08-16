import 'package:flutter/widgets.dart';
import 'package:form_validator/form_validator.dart';

import '../widgets.dart';

// todo localization
StringValidationCallback isAmount(BuildContext context) {
  final locale = context.locale;

  String? amountConstraint(String? value) {
    if (value == null) {
      return null;
    }

    final amount = double.tryParse(value);

    if (amount == null) {
      return locale.formValidationMessageInvalidAmount;
    }

    if (amount == 0) {
      return locale.formValidationMessageZeroAmount;
    }

    if (amount.abs() >= 1000000000) {
      return locale.formValidationMessageOutOfBounds;
    }

    return null;
  }

  return ValidationBuilder(localeName: 'en')
      .required(locale.formValidationMessageRequired)
      .add(amountConstraint)
      .build();
}

StringValidationCallback isRequired(BuildContext context, {int minLength = 1}) {
  final locale = context.locale;

  String? notEmptyConstraint(String? value) {
    return (value?.trim().isEmpty ?? true) ? locale.formValidationMessageEmpty : null;
  }

  return ValidationBuilder(localeName: 'en')
      .required(locale.formValidationMessageRequired)
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
      final locale = context.locale;

      if (value == null) {
        return locale.formValidationMessagePasswordNotProvided;
      }

      if (value.length < minLength) {
        return locale.formValidationMessagePasswordTooShort(minLength);
      }

      if (value.replaceAll(RegExp(r'\D'), '').length < minNumbers) {
        return locale.formValidationMessagePasswordFew(minNumbers, locale.digitsCharName);
      }

      if (value.replaceAll(RegExp(r'[^a-z]'), '').length < minLowercase) {
        return locale.formValidationMessagePasswordFew(minLowercase, locale.lowercaseCharName);
      }

      if (value.replaceAll(RegExp(r'[^A-Z]'), '').length < minUppercase) {
        return locale.formValidationMessagePasswordFew(minUppercase, locale.uppercaseCharName);
      }

      if (value.replaceAll(RegExp(r'(\W|_)'), '').length < minSymbols) {
        return locale.formValidationMessagePasswordFew(minSymbols, locale.specialCharName);
      }

      return null;
    };
