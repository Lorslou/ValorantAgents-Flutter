/*
  Define different events that can occur in the context of authentication within the application. The events represent 
  actions that the user can perform. These events are used to communicate with the AuthBloc and 
  trigger the corresponding state updates
*/

import 'package:flutter/foundation.dart';

// base class for all the events of authentication to ensure that event subclasses are immutable
@immutable
abstract class AuthEvent {
  const AuthEvent();
}

// indicates that the authentication in the application should be initialized
class AuthEventInitialize extends AuthEvent {
  const AuthEventInitialize();
}

class AuthEventRegister extends AuthEvent {
  final String email;
  final String password;
  const AuthEventRegister(this.email, this.password);
}

class AuthEventSendEmailVerification extends AuthEvent {
  const AuthEventSendEmailVerification();
}

class AuthEventLogIn extends AuthEvent {
  final String email;
  final String password;
  const AuthEventLogIn(this.email, this.password);
}

class AuthEventForgotPassword extends AuthEvent {
  final String? email;
  const AuthEventForgotPassword({this.email});
}

class AuthEventShouldRegisterFirst extends AuthEvent {
  const AuthEventShouldRegisterFirst();
}

class AuthEventLogOut extends AuthEvent {
  const AuthEventLogOut();
}
