class AppValidations {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter email';
    }
    final RegExp nameExp = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (!nameExp.hasMatch(value.trim())) return 'Please enter a valid email';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    }

    return null; // valid
  }

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your name';
    }

    final RegExp nameExp = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameExp.hasMatch(value.trim())) {
      return 'Name can only contain letters and spaces';
    }

    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }

    return null; // valid
  }

  static String? validateSecondName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your second name';
    }

    final RegExp nameExp = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameExp.hasMatch(value.trim())) {
      return 'Second name can only contain letters and spaces';
    }

    if (value.trim().length < 2) {
      return 'Second Name must be at least 2 characters';
    }

    return null; // valid
  }

  static String? validateMobileNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter mobile number';
    }

    final RegExp mobileExp = RegExp(r'^[0-9]{10}$'); // Only 10-digit numbers

    if (!mobileExp.hasMatch(value.trim())) {
      return 'Please enter a valid 10-digit mobile number';
    }

    return null; // valid
  }
}
