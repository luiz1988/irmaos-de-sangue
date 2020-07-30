import 'package:meta/meta.dart';

@immutable
class RegisterState {
  final bool isNameValid;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isPhoneNumber;
  final bool isWeight;
  final bool isDateBirth;
  final bool isDateDonation;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  // bool isCidadeValida;

  bool get isFormValid =>
      isEmailValid &&
      isPasswordValid &&
      isNameValid &&
      isPhoneNumber &&
      isWeight &&
      isDateBirth &&
      isDateDonation;
  // isCidadeValida;

  RegisterState(
      {@required this.isNameValid,
      @required this.isEmailValid,
      @required this.isPasswordValid,
      @required this.isPhoneNumber,
      @required this.isWeight,
      @required this.isDateBirth,
      @required this.isDateDonation,
      @required this.isSubmitting,
      @required this.isSuccess,
      @required this.isFailure});
      // this.isCidadeValida

  factory RegisterState.empty() {
    return RegisterState(
      isNameValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isPhoneNumber: true,
      isWeight: true,
      isDateBirth: true,
      isDateDonation: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.loading() {
    return RegisterState(
      isNameValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isPhoneNumber: true,
      isWeight: true,
      isDateBirth: true,
      isDateDonation: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.failure() {
    return RegisterState(
      isNameValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isPhoneNumber: true,
      isWeight: true,
      isDateDonation: true,
      isDateBirth: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory RegisterState.success() {
    return RegisterState(
      isNameValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isPhoneNumber: true,
      isWeight: true,
      isDateBirth: true,
      isDateDonation: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  RegisterState update({
    bool isNameValid,
    bool isEmailValid,
    bool isPasswordValid,
    bool isPhoneNumber,
    bool isWeight,
    bool isDateBirth,
    bool isDateDonation,
  }) {
    return copyWith(
      isNameValid: isNameValid,
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isPhoneNumber: isPhoneNumber,
      isWeight: isWeight,
      isDateBirth: isDateBirth,
      isDateDonation: isDateDonation,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  RegisterState copyWith({
    bool isNameValid,
    bool isEmailValid,
    bool isPasswordValid,
    bool isPhoneNumber,
    bool isWeight,
    bool isDateBirth,
    bool isDateDonation,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return RegisterState(
      isNameValid: isNameValid ?? this.isNameValid,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isPhoneNumber: isPhoneNumber ?? this.isPhoneNumber,
      isWeight: isWeight ?? this.isWeight,
      isDateBirth: isDateBirth ?? this.isDateBirth,
      isDateDonation: isDateDonation ?? this.isDateDonation,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''RegisterState {
      isNamevalid: $isNameValid,
      isEmailValid: $isEmailValid,
      isPasswordValid: $isPasswordValid,
      isPhoneNumber:$isPhoneNumber,
      isWeight:$isWeight,
      isDateBirth:$isDateBirth,
      isDateDonation:$isDateDonation,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
