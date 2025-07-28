abstract class PValidations {
  static final RegExp _name = RegExp(r'^[A-Za-z ]+$');
  static final RegExp _emailRegex = RegExp(r"^[\w.+-]+@[\w-]+\.[\w.-]{2,}$");

  static final RegExp _passowrdLowercaseRegex = RegExp(r"(?=.*[a-z])");
  static final RegExp _passowrdUppercaseRegex = RegExp(r"(?=.*[A-Z])");
  static final RegExp _phoneRegex = RegExp(r"^\+1\d{10}$");
  static final RegExp _passowrdDigitRegex = RegExp(r"(?=.*\d)");
  static final RegExp _passowrdSpecialCharRegex = RegExp(r"(?=.*[@$!%*?&])");
  static final RegExp _passowrdLengthRegex = RegExp(r".{8,}");

  static String? requiredValidation(String? value, String name) {
    if (value == null || value.isEmpty) {
      return "$name is required";
    }

    if (!_name.hasMatch(value)) {
      return "$name must contain only alphabetic characters.";
    }
    return null;
  }

  static String? emailValidation(String? email) {
    if (email == null || email.isEmpty) {
      return "Email is required";
    }
    if (!_emailRegex.hasMatch(email)) {
      return "Email is not valid";
    }
    return null;
  }

  static String? phoneValidation(String? phone) {
    if (phone == null || phone.isEmpty) {
      return "Phone Number is required";
    }
    if (!_phoneRegex.hasMatch(phone)) {
      return "Phone Number is not valid.";
    }
    return null;
  }

  static String? passwordValidation(String? password) {
    if (password == null || password.isEmpty) {
      return "Password is required";
    }
    if (!_passowrdLengthRegex.hasMatch(password)) {
      return "Password must be at least 8 characters long.";
    }
    if (!_passowrdLowercaseRegex.hasMatch(password)) {
      return "Password must include at least one lowercase letter.";
    }
    if (!_passowrdUppercaseRegex.hasMatch(password)) {
      return "Password must include at least one uppercase letter.";
    }
    if (!_passowrdDigitRegex.hasMatch(password)) {
      return "Password must include at least one digit.";
    }
    if (!_passowrdSpecialCharRegex.hasMatch(password)) {
      return "Password must include at least one special character (@\$!%*?&).";
    }
    return null;
  }

  static String? confirmPasswordValidations(
      String? confirmPassword, String? password) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return "Confirm Password is required";
    }
    if (confirmPassword != password) {
      return "Confirm Password does not match with Password";
    }
    return null;
  }
}
