import 'package:pet_care_icp/models/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedStorage {
  addTokenKey(StorageItem $storageIetm) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString($storageIetm.key, $storageIetm.value);
  }

  addUserId(String key, int idUser) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, idUser);
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringValue = prefs.getString('token');
    return stringValue;
  }

  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? idUser = prefs.getInt('idUser');
    return idUser;
  }

  isToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool CheckValue = prefs.containsKey('token');
    return CheckValue;
  }

  isUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool CheckValue = prefs.containsKey('idUser');
    return CheckValue;
  }

  deleteToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove("token");
  }
}
