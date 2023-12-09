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

StringValidationCallback isRequired(BuildContext context) {
  String? notEmptyConstraint(String? value) {
    return (value?.trim().isEmpty ?? true) ? 'Must be not empty' : null;
  }

  return ValidationBuilder(localeName: 'en')
      .required()
      .minLength(4)
      .add(notEmptyConstraint)
      .build();
}
