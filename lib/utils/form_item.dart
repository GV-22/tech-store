import 'package:email_validator/email_validator.dart';
import 'package:intl/intl.dart';

class FormItem {
  String? value;
  String? Function(String?)? validator;

  FormItem({
    this.value,
    required this.validator,
  });

  factory FormItem.optional({String? value}) {
    return FormItem(value: value, validator: null);
  }

  factory FormItem.notEmpty({String? value}) {
    return FormItem(
      value: value,
      validator: (String? value) {
        if (value != null && value.isEmpty) {
          return 'This field cannot be empty';
        }

        return null;
      },
    );
  }

  factory FormItem.greaterThanMin({required int min, String? value}) {
    return FormItem(
      value: value,
      validator: (String? value) {
        if (value != null && value.isEmpty) {
          return 'This field cannot be empty';
        }

        try {
          final parsed = NumberFormat().parse(value!);

          if (parsed <= min) {
            return 'The value of this field must be greater than $min';
          }
          return null;
        } catch (error) {
          return 'This field have an invalid number';
        }
      },
    );
  }

  factory FormItem.validEmail({String? value}) {
    return FormItem(
      value: value,
      validator: (String? value) {
        if (value == null) return null;
        if (value.isEmpty) {
          return "This field cannot be empty";
        } else if (!EmailValidator.validate(value)) {
          return "L'adresse mail est invalide";
        }

        return null;
      },
    );
  }

  factory FormItem.cannotBeLessThanXDigit({
    required int digit,
    String? value,
    required String fieldName,
  }) {
    return FormItem(
      value: value,
      validator: (String? value) {
        if (value != null) {
          if (value.isEmpty) {
            return '$fieldName cannot be empty';
          } else if (value.length < digit) {
            return '$fieldName cannot be less than $digit digits';
          }

          return null;
        }

        return null;
      },
    );
  }

  factory FormItem.validNumber({String? value}) {
    return FormItem(
      value: value,
      validator: (String? value) {
        if (value == null) return null;

        if (value.isEmpty) {
          return 'This field cannot be empty';
        } else {
          try {
            NumberFormat().parse(value);
            return null;
          } catch (error) {
            return 'Please enter a valid number';
          }
        }
      },
    );
  }

  factory FormItem.validPassword({String? value}) {
    return FormItem(
      value: value,
      validator: (String? value) {
        if (value == null) return null;

        if (value.isEmpty) {
          return 'This field cannot be empty';
        }

        if (value.length < 8) {
          return 'This field should contain at leat 08 characters';
        }

        // if (estimatePasswordStrength(value) < 0.3) {
        //   return "Votre mot de passe est trop faible";
        // }

        return null;
      },
    );
  }

  factory FormItem.validYear({String? value}) {
    return FormItem(
      value: value,
      validator: (String? value) {
        if (value == null) return null;

        if (value.isEmpty) {
          return 'This field cannot be empty';
        }

        try {
          if (value.length != 4) return 'Enter a valid year';

          final int year = int.parse(value);
          final int currentYear = DateTime.now().year;

          if (currentYear <= year) {
            return 'Enter a valid year';
          }
        } catch (_) {
          return 'Enter a valid year';
        }

        return null;
      },
    );
  }

  factory FormItem.betweenMinAndMax({
    required int min,
    required int max,
    String? value,
  }) {
    return FormItem(
      value: value,
      validator: (String? value) {
        if (value == null) return null;

        if (value.isEmpty) {
          return 'This field cannot be empty';
        }

        try {
          final parsed = int.parse(value);
          if (parsed < min || parsed > max) {
            return 'Min: $min, Max: $max';
          }
        } catch (_) {
          return 'Please enter a valid number';
        }

        return null;
      },
    );
  }

  @override
  String toString() {
    return value ?? 'no-value';
  }
}
