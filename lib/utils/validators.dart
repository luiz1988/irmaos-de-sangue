class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  // static final RegExp _passwordRegExp = RegExp(
  //   r'^(?=.*[A-Za-z])[A-Za-z\d]{8,}$',
  // );

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static isNameValid(String name) {
    return name != "";
  }

  static isValidPassword(String password) {
    // return _passwordRegExp.hasMatch(password);
    return password.length > 8;
  }

  static isPhoneNumberValid(String phoneNumber) {
    return phoneNumber != "";
  }

  static isWeightValid(String weight) {
    return weight != "";
  }

  static isDateBirthValid(String dateBirth) {
    return dateBirth != "";
  }

  static isDateDonationValid(String dateDonation) {
    return dateDonation != "";
  }
}
