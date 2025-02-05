import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsState {
  final Locale locale;

  SettingsState({required this.locale});
}

class SettingsCubit extends Cubit<SettingsState> {
  final SharedPreferences preferences;

  SettingsCubit({required this.preferences})
      : super(SettingsState(
          locale: Locale(preferences.getString('language') ?? 'en'),
        ));

  Future<void> changeLocale(String languageCode) async {
    await preferences.setString('language', languageCode);
    emit(SettingsState(locale: Locale(languageCode)));
  }
}
