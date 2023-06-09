import 'package:agentsvalorant/helpers/loading_screen.dart';
import 'package:agentsvalorant/services/auth/bloc/auth_bloc.dart';
import 'package:agentsvalorant/services/auth/bloc/auth_event.dart';
import 'package:agentsvalorant/services/auth/bloc/auth_state.dart';
import 'package:agentsvalorant/services/auth/firebase_auth_provider.dart';
import 'package:agentsvalorant/ui/screens/detail_agent.dart';
import 'package:agentsvalorant/ui/screens/navigation_main.dart';
import 'package:agentsvalorant/ui/views/user/forgot_password_view.dart';
import 'package:agentsvalorant/ui/views/user/login_view.dart';
import 'package:agentsvalorant/ui/views/user/register_view.dart';
import 'package:agentsvalorant/ui/views/user/verify_email_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constants/navigation_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'HOME',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const MyApp(),
      ),
      routes: {
        detailRoute: (context) => const AgentDetail(),
        registerRoute: (context) => const RegisterView(),
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(
            context: context,
            text: state.loadingText ?? 'Please wait a moment',
          );
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const HomeScreen();
        } else if (state is AuthStateNeedsVerification) {
          return const VerifyEmailView();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else if (state is AuthStateForgotPassword) {
          return const ForgotPasswordView();
        } else if (state is AuthStateRegistering) {
          return const RegisterView();
        } else {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
