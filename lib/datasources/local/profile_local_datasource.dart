import 'package:flutter_tes_application/models/profile_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileLocalDatasource {
  static late SharedPreferences _prefs;

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static ProfileData getProfileStorage() {
    String name = _prefs.getString('lastName') ?? '';
    String email = _prefs.getString('lastEmail') ?? '';
    String phone = _prefs.getString('lastPhone') ?? '';
    String moto = _prefs.getString('lastMoto') ?? '';

    return ProfileData(
      name: name,
      email: email,
      phone: phone,
      moto: moto,
    );
  }

  static void saveLastProfile(ProfileData profile) {
    _prefs.setString('lastName', profile.name);
    _prefs.setString('lastEmail', profile.email);
    _prefs.setString('lastPhone', profile.phone);
    _prefs.setString('lastMoto', profile.moto);
  }
}
