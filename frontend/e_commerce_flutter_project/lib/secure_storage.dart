import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  static final FlutterSecureStorage? _instance;
  Storage._();

  static FlutterSecureStorage get instance{
    return _instance ?? FlutterSecureStorage(
      aOptions: const AndroidOptions(encryptedSharedPreferences: true),
    );
  }

  static write({
    required String key,
    required String value,
  }) async {
    await instance.write(key: key, value: value);
  }
  
  static read({required String key}) async {
    return await instance.read(key: key);
  }


}