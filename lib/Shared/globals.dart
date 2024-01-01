import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

Logger logger = Logger();
String BASE_URL = "http://fatoura.valuwitapps.co/api";
String baseUrlWithoutApi = "http://fatoura.valuwitapps.co/public/";

class InitStorage {
  static final storage = FlutterSecureStorage(
    iOptions: getIOSOptions(),
    aOptions: getAndroidOptions(),
  );

  static Future<void> readAll() async {
    await storage
        .readAll(
      iOptions: getIOSOptions(),
      aOptions: getAndroidOptions(),
    )
        .then((value) {
      value.forEach((key, value) async {
        logger.i("$key : $value");
        await storage.write(
          key: key,
          value: value,
          iOptions: getIOSOptions(),
          aOptions: getAndroidOptions(),
        );
      });
    });
  }

  static Future<void> deleteAll() async {
    await storage.deleteAll(
      iOptions: getIOSOptions(),
      aOptions: getAndroidOptions(),
    );
    readAll();
  }

  // static Future<void> addNewItem(String key, String value) async {
  //   await storage.write(
  //     key: key,
  //     value: value,
  //     iOptions: getIOSOptions(),
  //     aOptions: getAndroidOptions(),
  //   );
  //   readAll();
  // }

  static IOSOptions getIOSOptions() => const IOSOptions();

  static AndroidOptions getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
        // sharedPreferencesName: 'Test2',
        // preferencesKeyPrefix: 'Test'
      );
}
