import 'package:dropili/Presentation/Nfc/bloc/nfc_bloc.dart';
import 'package:dropili/Presentation/home/ProfilePage/bloc/profileScreen_bloc.dart';
import 'package:dropili/Presentation/home/root/bloc/navigation_bloc.dart';
import 'package:dropili/Presentation/localization/bloc/language_bloc.dart';
import 'package:dropili/core/api/post_get.dart';
import 'package:dropili/domain/repositories/auth_repository.dart';
import 'package:dropili/domain/repositories/profile_repository.dart';
import 'package:get_it/get_it.dart';

final getItInstace = GetIt.I;

Future init() async {
  getItInstace.registerLazySingleton<Network>(() => Network());
  getItInstace.registerLazySingleton<AuthRepository>(
      () => AuthRepository(getItInstace()));

  getItInstace.registerLazySingleton<ProfileRepository>(
      () => ProfileRepository(getItInstace()));

  getItInstace.registerLazySingleton<NavigationBloc>(() => NavigationBloc());

  getItInstace.registerLazySingleton<ProfileBloc>(
      () => ProfileBloc(ProfileRepository: getItInstace()));

  getItInstace.registerLazySingleton<NfcBloc>(() => NfcBloc());

  getItInstace.registerLazySingleton<LanguageBloc>(() => LanguageBloc());
}
