import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sadiqeen/features/home/data/repo/categories_repo.dart';
import 'package:sadiqeen/features/home/data/repo/sub_categories_repository.dart';
import 'package:sadiqeen/features/home/logic/categories_cubit/categories_cubit.dart';
import 'package:sadiqeen/features/home/logic/sub_categories_cubit/sub_categories_cubit.dart';
import 'package:sadiqeen/features/signup/data/repo/register_repo.dart';
import 'package:sadiqeen/features/signup/logic/register_cubit.dart';

import '../../features/login/data/repo/login_repo.dart';
import '../../features/login/logic/cubit/cubit/login_cubit.dart';
import '../networking/api_service.dart';
import '../networking/dio_factory.dart';

final getIt = GetIt.instance;

Future<void> setupGetit() async {
  Dio dio = DioFactory.getDio();

  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
  getIt.registerLazySingleton<LoginCubit>(() => LoginCubit(getIt()));

  getIt.registerLazySingleton<CategoriesRepository>(
    () => CategoriesRepository(getIt()),
  );
  getIt.registerLazySingleton<CategoriesCubit>(() => CategoriesCubit(getIt()));

  getIt.registerLazySingleton<SubCategoriesRepository>(
    () => SubCategoriesRepository(apiService: getIt()),
  );
  getIt.registerLazySingleton<SubCategoriesCubit>(() => SubCategoriesCubit(getIt()));

  getIt.registerLazySingleton<RegisterRepo>(() => RegisterRepo(getIt()));
  getIt.registerLazySingleton<RegisterCubit>(() => RegisterCubit(getIt()));
 
}
