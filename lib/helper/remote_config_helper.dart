import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigHelper {
  final FirebaseRemoteConfig _remoteConfig;
  RemoteConfigHelper(this._remoteConfig);

  Future<void> initialize() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(minutes: 1),
    ));

    await _remoteConfig.setDefaults(const {
      "showDiscount": true,
    });
    await _remoteConfig.fetchAndActivate();
  }

  T getValue<T>(String key) {
    if (T is bool) {
      return _remoteConfig.getBool(key) as T;
    }
    //TODO:check for other datatypes
    return _remoteConfig.getBool(key) as T;
  }
}
