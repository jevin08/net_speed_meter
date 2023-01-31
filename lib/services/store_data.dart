// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:net_speed_meter/models/application.dart';
//
// class StorageService {
//   final _secureStorage = const FlutterSecureStorage();
//   Future<void> writeSecureData(AppModel newItem) async {
//     await _secureStorage.write(
//         key: newItem.authKey,
//         value: AppModel.serialize(newItem),
//         aOptions: _getAndroidOptions());
//   }
//   Future<String?> readSecureData(String key) async {
//     var readData =
//     await _secureStorage.read(key: key, aOptions: _getAndroidOptions());
//     return readData;
//   }
//   Future<void> deleteSecureData(AppModel item) async {
//     await _secureStorage.delete(key: item.authKey, aOptions: _getAndroidOptions());
//   }
//   Future<bool> containsKeyInSecureData(String key) async {
//     var containsKey = await _secureStorage.containsKey(key: key, aOptions: _getAndroidOptions());
//     return containsKey;
//   }
//
//   AndroidOptions _getAndroidOptions() => const AndroidOptions(
//     encryptedSharedPreferences: true,
//   );
//
// }
//
//
