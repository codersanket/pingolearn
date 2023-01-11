import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';
import 'package:pingolearn/app/modal_helper.dart';
import 'package:pingolearn/helper/remote_config_helper.dart';
import 'package:pingolearn/respository/auth_repo.dart';
import 'package:pingolearn/respository/home_repo.dart';
import 'package:pingolearn/screens/authentication/auth_provider.dart';
import 'package:pingolearn/screens/home/home_provider.dart';
import 'package:rxdart/subjects.dart';

final locator = GetIt.instance;

class AppBootStrapper {
  static final instance = AppBootStrapper._();
  AppBootStrapper._();

  final BehaviorSubject<bool> isInitialized = BehaviorSubject.seeded(false);

  Future<void> initialize() async {
    isInitialized.value = false;

    final firebaseAuth = FirebaseAuth.instance;
    final fireStore = FirebaseFirestore.instance;
    final firebaseRemoteConfig = FirebaseRemoteConfig.instance;

    final remoteConfigHelper = RemoteConfigHelper(firebaseRemoteConfig);
    await remoteConfigHelper.initialize();
    locator.registerLazySingleton(() => HomeRepo());
    locator.registerLazySingleton(() => ModalHelper());
    locator.registerSingleton(remoteConfigHelper);
    locator.registerLazySingleton(() => AuthRepo(firebaseAuth, fireStore));

    locator.registerFactory(() => AuthProvider(locator(), locator()));
    locator.registerFactory(() => HomeProvider(locator(), locator()));

    isInitialized.value = true;
  }
}
