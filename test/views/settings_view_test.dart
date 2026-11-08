
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:southsea_cinema/models/user_settings.dart';
import 'package:southsea_cinema/repositories/user_settings_repository.dart';
import 'package:southsea_cinema/views/settings_view.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  late InMemorySharedPreferencesAsync preferences;

  setUpAll(() {
    preferences = InMemorySharedPreferencesAsync.empty();

    SharedPreferencesAsyncPlatform.instance = preferences;
  });

  setUp(() async {
    await SharedPreferencesAsync().clear();
  });


  testWidgets('Settings loads saved preferences', (tester) async {
    await UserSettingsRepository.instance.saveSettings(
      const UserSettings(
        address: '10 Cinema Road, Portsmouth',
        email: 'customer@example.com',
        patronNumber: '5678',
        receiveNews: false,
      ),
    );

    await tester.pumpWidget(
      const MaterialApp(home: SettingsView()),
    );

    await tester.pumpAndSettle();

    final fields = tester
        .widgetList<TextFormField>(find.byType(TextFormField))
        .toList();

    expect(fields[0].controller!.text, '10 Cinema Road, Portsmouth');
    expect(fields[1].controller!.text, 'customer@example.com');
    expect(fields[2].controller!.text, '5678');
    expect(tester.widget<Switch>(find.byType(Switch)).value, false);
  });

  testWidgets('Settings saves edited preferences', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: SettingsView()),
    );

    await tester.pumpAndSettle();

    expect(tester.widget<Switch>(find.byType(Switch)).value, true);

    await tester.enterText(
      find.byType(TextFormField).at(0),
      '20 Cinema Street, Portsmouth',
    );

    await tester.enterText(
      find.byType(TextFormField).at(1),
      'newcustomer@example.com',
    );

    await tester.enterText(
      find.byType(TextFormField).at(2),
      '9876',
    );

    await tester.ensureVisible(find.byType(Switch));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    expect(tester.widget<Switch>(find.byType(Switch)).value, false);

    await tester.ensureVisible(find.text('SAVE SETTINGS'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('SAVE SETTINGS'));
    await tester.pumpAndSettle();

    final settings =
        await UserSettingsRepository.instance.loadSettings();

    expect(settings.address, '20 Cinema Street, Portsmouth');
    expect(settings.email, 'newcustomer@example.com');
    expect(settings.patronNumber, '9876');
    expect(settings.receiveNews, false);
  });

  testWidgets('Settings loads saved preferences when reopened',
      (tester) async {
    await UserSettingsRepository.instance.saveSettings(
      const UserSettings(
        address: '30 Film Road, Portsmouth',
        email: 'saved@example.com',
        patronNumber: '2468',
        receiveNews: true,
      ),
    );

    await tester.pumpWidget(
      const MaterialApp(home: SettingsView()),
    );

    await tester.pumpAndSettle();

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Text('Settings closed'),
        ),
      ),
    );

    await tester.pumpWidget(
      const MaterialApp(home: SettingsView()),
    );

    await tester.pumpAndSettle();

    final fields = tester
        .widgetList<TextFormField>(find.byType(TextFormField))
        .toList();

    expect(fields[0].controller!.text, '30 Film Road, Portsmouth');
    expect(fields[1].controller!.text, 'saved@example.com');
    expect(fields[2].controller!.text, '2468');
    expect(tester.widget<Switch>(find.byType(Switch)).value, true);
  });
}
