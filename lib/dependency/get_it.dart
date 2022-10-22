import 'package:dropili/core/api/post_get.dart';
import 'package:dropili/domain/repositories/auth_repository.dart';
import 'package:get_it/get_it.dart';

final getItInstace = GetIt.I;

Future init() async {
  getItInstace.registerLazySingleton<Network>(() => Network());
  getItInstace.registerLazySingleton<AuthRepository>(() => AuthRepository(getItInstace()));
}
