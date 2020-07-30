import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:irmaos_de_sangue/pages/register/bloc/bloc.dart';
import 'package:irmaos_de_sangue/services/user_repository.dart';
import 'package:irmaos_de_sangue/utils/validators.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;

  RegisterBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  RegisterState get initialState => RegisterState.empty();

  @override
  Stream<RegisterState> transformEvents(
    Stream<RegisterEvent> events,
    Stream<RegisterState> Function(RegisterEvent event) next,
  ) {
    final observableStream = events as Observable<RegisterEvent>;
    final nonDebounceStream = observableStream.where((event) {
      return (event is! EmailChanged &&
          event is! PasswordChanged &&
          event is! NameChanged &&
          event is! PhoneNumberChanged &&
          event is! WeightChanged &&
          event is! DateBirthChanged &&
          event is! DateDonationChanged);
    });
    final debounceStream = observableStream.where((event) {
      return (event is EmailChanged ||
          event is PasswordChanged ||
          event is NameChanged ||
          event is PhoneNumberChanged ||
          event is WeightChanged ||
          event is DateBirthChanged ||
          event is! DateDonationChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super
        .transformEvents(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is NameChanged) {
      yield* _mapNameChangeToState(event.name);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is PhoneNumberChanged) {
      yield* _mapPhoneNumberToState(event.phoneNumber);
    } else if (event is WeightChanged) {
      yield* _mapWeightToState(event.weight);
    } else if (event is DateBirthChanged) {
      yield* _mapDateBirthToState(event.dateBirth);
    } else if (event is DateDonationChanged) {
      yield* _mapDateDonationToState(event.dateDonation);
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(
        event.name,
        event.email,
        event.password,
        event.companyId,
        event.numeroCelular,
        event.sexoId,
        event.peso,
        event.estadoCivilId,
        event.dataNascimento,
        event.tipoSanguineoId,
        event.dataDoacao,
        event.estadoId,
        event.cidadeId,
        event.photoUrl,
      );
    }
  }

  Stream<RegisterState> _mapEmailChangedToState(String email) async* {
    yield currentState.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<RegisterState> _mapPasswordChangedToState(String password) async* {
    yield currentState.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<RegisterState> _mapNameChangeToState(String name) async* {
    yield currentState.update(
      isNameValid: Validators.isNameValid(name),
    );
  }

  Stream<RegisterState> _mapPhoneNumberToState(String phoneNumber) async* {
    yield currentState.update(
      isPhoneNumber: Validators.isPhoneNumberValid(phoneNumber),
    );
  }

  Stream<RegisterState> _mapWeightToState(String weight) async* {
    yield currentState.update(
      isWeight: Validators.isWeightValid(weight),
    );
  }

  Stream<RegisterState> _mapDateBirthToState(String dateBirth) async* {
    yield currentState.update(
      isDateBirth: Validators.isDateBirthValid(dateBirth),
    );
  }

  Stream<RegisterState> _mapDateDonationToState(String dateDonation) async* {
    yield currentState.update(
      isDateDonation: Validators.isDateDonationValid(dateDonation),
    );
  }

  Stream<RegisterState> _mapFormSubmittedToState(
    String name,
    String email,
    String password,
    String companyId,
    String numeroCelular,
    String sexoId,
    String peso,
    String estadoCivilId,
    String dataNascimento,
    String dataDoacao,
    String tipoSanguineoId,
    String estadoId,
    String cidadeId,
    String photoUrl,
  ) async* {
    yield RegisterState.loading();
    try {
      await _userRepository.signUp(
          name: name,
          email: email,
          password: password,
          companyId: companyId,
          numeroCelular: numeroCelular,
          sexoId: sexoId,
          peso: peso,
          estadoCivilId: estadoCivilId,
          dataNascimento: dataNascimento,
          tipoSanguineoId: tipoSanguineoId,
          dataDoacao: dataDoacao,
          estadoId: estadoId,
          cidadeId: cidadeId,
          photoUrl: photoUrl);
      yield RegisterState.success();
    } catch (_) {
      yield RegisterState.failure();
    }
  }
}
