class InputValidator {
  static String? required(dynamic value) {
    if (value == null ||
        value == false ||
        ((value is Iterable || value is String || value is Map) &&
            value.length == 0)) {
      return "Please fill in this field";
    } else if (value.length >= 500) {
      return "Too Long (Max 500 Characters)";
    }
    return null;
  }

  static String? usernameChar(String username) {
    // lower case
    if (!RegExp(r'^[a-z0-9_\(\)\|]+$').hasMatch(username.trim())) {
      return "Only lowercase and ( , ) , _ , | are allowed";
    } else if (username.trim().length > 15) {
      return "The password you enter is too long";
    }
    return null;
  }

  static String? passwordChar(String password) {
    if (password.length < 8) {
      return "The password must have at least 8 characters";
    } else if (password.length > 40) {
      return "The password you enter is too long";
    }
    return null;
  }

  static String? nameChar(String name) {
    if (name.trim().length < 4) {
      return "The name must have at least 4 characters";
    } else if (name.trim().length > 40) {
      return "The name you enter is too long";
    }
    return null;
  }

  static String? emailChar(String email) {
    if (email.trim().length < 4 ||
        email.trim().length > 40 ||
        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email.trim())) {
      return "Invalid Email";
    }
    return null;
  }

  static String? phoneNo(String phoneNo) {
    if (phoneNo.length < 9) {
      return "Invalid Phone Number";
    } else if (phoneNo.length > 11) {
      return "Invalid Phone Number";
    }
    return null;
  }

  static String? nric(String nric) {
    if (nric.length != 12) {
      return "Must 12 numeric characters";
    }
    return null;
  }
}
