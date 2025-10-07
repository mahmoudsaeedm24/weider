import 'package:shared_preferences/shared_preferences.dart';

enum SharedPrefKeys {imagePath}

class SharedPrefPrepared {
  SharedPrefPrepared._();

  static Future<bool> storedImagePath({required String imagePath})async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.setString(SharedPrefKeys.imagePath.name, imagePath);
  }


  static Future<String?> getImagePath() async{
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getString(SharedPrefKeys.imagePath.name);
  }
}
