import 'package:apple_music/components/AudioController/AudioManager.dart';
import 'package:apple_music/components/AudioController/AudioPageRouteManager.dart';
import 'package:apple_music/manager/CurrentUserManager.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setUpGetIt() {
  // set up audio state manager
  getIt.registerLazySingleton<AudioManager>(() => AudioManager());
  getIt.registerLazySingleton<AudioPageRouteManager>(() => AudioPageRouteManager());
  getIt.registerLazySingleton<CurrentUserManager>(() => CurrentUserManager());

}