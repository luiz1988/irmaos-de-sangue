import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  RegisterEvent([List props = const []]) : super(props);
}

class NameChanged extends RegisterEvent {
  final String name;

  NameChanged({@required this.name}) : super([name]);

  @override
  String toString() => 'NameChanged { password: $name }';
}

class EmailChanged extends RegisterEvent {
  final String email;

  EmailChanged({@required this.email}) : super([email]);

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class PasswordChanged extends RegisterEvent {
  final String password;

  PasswordChanged({@required this.password}) : super([password]);

  @override
  String toString() => 'PasswordChanged { password: $password }';
}
class PhoneNumberChanged extends RegisterEvent {
  final String phoneNumber;

  PhoneNumberChanged({@required this.phoneNumber}) : super([phoneNumber]);

  @override
  String toString() => 'PhoneNumberChanged { phoneNumber: $phoneNumber }';
}

class WeightChanged extends RegisterEvent {
  final String weight;

  WeightChanged({@required this.weight}) : super([weight]);

  @override
  String toString() => 'WeightChanged { password: $weight }';
}

class DateBirthChanged extends RegisterEvent {
  final String dateBirth;

  DateBirthChanged({@required this.dateBirth}) : super([dateBirth]);

  @override
  String toString() => 'DateBirthChanged { password: $dateBirth }';
}

class DateDonationChanged extends RegisterEvent {
  final String dateDonation;

  DateDonationChanged({@required this.dateDonation}) : super([dateDonation]);

  @override
  String toString() => 'DateDonationChanged { password: $dateDonation }';
}

class Submitted extends RegisterEvent {
  final String name;
  final String email;
  final String password;
  final String companyId;
  final String numeroCelular;
  final String sexoId;
  final String peso;
  final String estadoCivilId;
  final String dataNascimento;
  final String tipoSanguineoId;
  final String dataDoacao;
  final String estadoId;
  final String cidadeId;
  final String photoUrl;

  Submitted(
      {@required this.name,
      @required this.email,
      @required this.password,
      @required this.companyId,
      @required this.numeroCelular,
      @required this.sexoId,
      @required this.peso,
      @required this.estadoCivilId,
      @required this.dataNascimento,
      @required this.tipoSanguineoId,
      @required this.dataDoacao,
      @required this.estadoId,
      @required this.cidadeId,
      @required this.photoUrl})
      : super([
          name,
          email,
          password,
          companyId,
          numeroCelular,
          sexoId,
          peso,
          estadoCivilId,
          dataNascimento,
          tipoSanguineoId,
          dataDoacao,
          estadoId,
          cidadeId,
          photoUrl
        ]);

  @override
  String toString() {
    return 'Submitted { email: $email, password: $password }';
  }
}
