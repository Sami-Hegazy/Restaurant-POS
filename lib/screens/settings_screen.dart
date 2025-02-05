import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/settings/settings_cubit.dart';
import '../generated/l10n.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).settings,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 32),
          Card(
            color: const Color(0xff1f2029),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.language,
                    color: Colors.deepOrangeAccent,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    S.of(context).language,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  BlocBuilder<SettingsCubit, SettingsState>(
                    builder: (context, state) {
                      return DropdownButton<String>(
                        value: state.locale.languageCode,
                        dropdownColor: const Color(0xff1f2029),
                        underline: Container(),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.deepOrangeAccent,
                        ),
                        items: [
                          DropdownMenuItem(
                            value: 'en',
                            child: Text(
                              S.of(context).english,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'ar',
                            child: Text(
                              S.of(context).arabic,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            context.read<SettingsCubit>().changeLocale(value);
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
