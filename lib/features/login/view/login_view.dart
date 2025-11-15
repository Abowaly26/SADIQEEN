import 'package:flutter/material.dart';
import 'package:sadiqeen/features/login/view/widgets/login_view_bloc_listener.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoginViewBlocConsumer();
  }
}
