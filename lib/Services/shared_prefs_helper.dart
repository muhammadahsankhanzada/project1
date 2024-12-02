import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static const String userIdKey = 'UserIdKey';
  static const String userNameKey = 'UserNameKey';
  static const String userImageKey = 'UserImageKey';
  static const String userCnicKey = 'UserCnicKey';
  static const String userEmailKey = 'UserEmailKey';
  static const String userContactKey = 'UserContactKey';
  static const String userAddressKey = 'UserAddressKey';
  static const String userAgeKey = 'UserAgeKey';
  static const String salesmanRouteKey = 'SalesmanRouteKey';
  static const String salesmanVehicleKey = 'SalesmanVehicleKey';
  static const String managerWarehouseKey = 'ManagerWarehouseKey';

  // Methods to save User Data in Shared Preferences
  static Future<bool> setUserId(String getUserId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userIdKey, getUserId);
  }

  static Future<bool> setUserName(String getUserName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userNameKey, getUserName);
  }

  static Future<bool> setUserImage(String getUserImage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userImageKey, getUserImage);
  }

  static Future<bool> setUserCnic(String getUserCnic) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userCnicKey, getUserCnic);
  }

  static Future<bool> setUserEmail(String getUserEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userEmailKey, getUserEmail);
  }

  static Future<bool> setUserContact(String getUserContact) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userContactKey, getUserContact);
  }

  static Future<bool> setUserAddress(String getUserAddress) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userAddressKey, getUserAddress);
  }

  static Future<bool> setUserAge(int getUserAge) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(userAgeKey, getUserAge);
  }

  static Future<bool> setSalesmanRoute(String getSalesmanRoute) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(salesmanRouteKey, getSalesmanRoute);
  }

  static Future<bool> setSalesmanVehicle(String getSalesmanVehicle) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(salesmanVehicleKey, getSalesmanVehicle);
  }

  static Future<bool> setManagerWarehouse(String getManagerWarehouse) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(managerWarehouseKey, getManagerWarehouse);
  }

  // Methods to retrieve User Data from Shared Preferences
  static Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }

  static Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);
  }

  static Future<String?> getUserImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userImageKey);
  }

  static Future<String?> getUserCnic() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userCnicKey);
  }

  static Future<String?> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailKey);
  }

  static Future<String?> getUserContact() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userContactKey);
  }

  static Future<String?> getUserAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userAddressKey);
  }

  static Future<int?> getUserAge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(userAgeKey);
  }

  static Future<String?> getSalesmanRoute() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(salesmanRouteKey);
  }

  static Future<String?> getSalesmanVehicle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(salesmanVehicleKey);
  }

  static Future<String?> getManagerWarehouse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(managerWarehouseKey);
  }
}
