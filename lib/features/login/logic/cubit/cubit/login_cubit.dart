import 'package:bloc/bloc.dart';
import 'package:sadiqeen/core/networking/api_result.dart';
import 'package:sadiqeen/features/login/logic/cubit/cubit/login_state.dart';

import '../../../data/models/login_request_body.dart';
import '../../../data/repo/login_repo.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginRepol) : super(const LoginState.initial());

  final LoginRepo _loginRepol;

  void emitLoginState(LoginRequestBody loginRequestBody) async {
    if (isClosed) return;
    emit(const LoginState.loading());

    final response = await _loginRepol.login(loginRequestBody);

    if (isClosed) return;
    response.when(
      success: (loginResponse) {
        emit(LoginState.success(loginResponse));
      },

      failure: (error) {
        emit(LoginState.error(error: error.apiErrorModel.message));
      },
    );
  }
}
