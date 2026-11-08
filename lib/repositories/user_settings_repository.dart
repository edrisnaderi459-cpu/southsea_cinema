import 'package:southsea_cinema/models/user_settings.dart';

class UserSettingsRepository {
  UserSettingsRepository._();

  static final UserSettingsRepository instance = UserSettingsRepository._();

  UserSettings _settings = const UserSettings(
    address: 'Buckingham Building,\nLion Terrace,\nPortsmouth\nPO1 3HE',
    email: 'alex@example.com',
    patronNumber: '1234',
    receiveNews: true,
  );

  UserSettings get settings => _settings;

  void saveSettings(UserSettings settings) {
    _settings = settings;
  }
}
