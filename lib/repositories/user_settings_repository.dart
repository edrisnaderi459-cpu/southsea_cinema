
import 'package:shared_preferences/shared_preferences.dart';
import 'package:southsea_cinema/models/user_settings.dart';

class UserSettingsRepository {
  UserSettingsRepository._();

  static final UserSettingsRepository instance = UserSettingsRepository._();

  final SharedPreferencesAsync _prefs = SharedPreferencesAsync();

  Future<UserSettings> loadSettings() async {
    final address = await _prefs.getString('customer_address');
    final email = await _prefs.getString('customer_email');
    final patronNumber = await _prefs.getString('customer_patron_number');
    final receiveNews = await _prefs.getBool('customer_receive_news');

    return UserSettings(
      address: address ??
          'Buckingham Building,\nLion Terrace,\nPortsmouth\nPO1 3HE',
      email: email ?? 'alex@example.com',
      patronNumber: patronNumber ?? '1234',
      receiveNews: receiveNews ?? true,
    );
  }

  Future<void> saveSettings(UserSettings settings) async {
    await _prefs.setString('customer_address', settings.address);
    await _prefs.setString('customer_email', settings.email);
    await _prefs.setString(
      'customer_patron_number',
      settings.patronNumber,
    );
    await _prefs.setBool('customer_receive_news', settings.receiveNews);
  }
}
