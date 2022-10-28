import 'package:dropili/Presentation/home/root/bloc/navigation_bloc.dart';
import 'package:dropili/Presentation/localization/bloc/language_bloc.dart';
import 'package:dropili/core/api/post_get.dart';
import 'package:dropili/domain/repositories/auth_repository.dart';
import 'package:dropili/domain/repositories/edit_profile_repository.dart';
import 'package:dropili/domain/repositories/profile_repository.dart';
import 'package:get_it/get_it.dart';

final getItInstace = GetIt.I;

Future init() async {
  getItInstace.registerLazySingleton<Network>(() => Network());
  getItInstace.registerLazySingleton<AuthRepository>(
      () => AuthRepository(getItInstace()));

  getItInstace
      .registerLazySingleton<ProfileRepository>(() => ProfileRepository());

  getItInstace.registerLazySingleton<EditProfileRepository>(
      () => EditProfileRepository());

  getItInstace.registerLazySingleton<LanguageBloc>(() => LanguageBloc());

  getItInstace.registerLazySingleton<NavigationBloc>(() => NavigationBloc());
}
