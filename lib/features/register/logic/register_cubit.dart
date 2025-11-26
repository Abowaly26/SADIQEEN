import 'package:bloc/bloc.dart';
import 'package:sadiqeen/core/networking/api_result.dart';
import 'package:sadiqeen/features/register/logic/register_state.dart';

import '../data/models/register_request_model.dart';
import '../data/repo/register_repo.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterRepo _registerRepo;

  RegisterCubit(this._registerRepo) : super(const RegisterState.initial());

  Future<void> registerUser(RegisterRequestModel registerRequestBody) async {
    if (isClosed) return;
    emit(const RegisterState.loading());

    final response = await _registerRepo.register(registerRequestBody);

    if (isClosed) return;
    response.when(
      success: (registerResponse) {
        emit(RegisterState.success(registerResponse));
      },
      failure: (error) {
        emit(RegisterState.error(error: error.apiErrorModel.message));
      },
    );
  }
}
