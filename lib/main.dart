import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:restaurant_pos/generated/l10n.dart';
import 'cubits/category/category_cubit.dart';
import 'cubits/menu/menu_cubit.dart';
import 'cubits/order/order_cubit.dart';
import 'cubits/settings/settings_cubit.dart';
import 'data/init_db.dart';
import 'config/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await SharedPreferences.getInstance();
  await initializeDatabase();
  runApp(MyApp(preferences: preferences));
}

class MyApp extends StatelessWidget {
  final SharedPreferences preferences;

  const MyApp({super.key, required this.preferences});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CategoryCubit()),
        BlocProvider(create: (_) => MenuCubit()),
        BlocProvider(create: (_) => OrderCubit()),
        BlocProvider(create: (_) => SettingsCubit(preferences: preferences)),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return MaterialApp.router(
            locale: state.locale,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            routerConfig: router,
            title: 'POS Food',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: const ColorScheme.dark(
                primary: Colors.deepOrange,
                secondary: Colors.deepOrangeAccent,
                surface: Color(0xff17181f),
              ),
              scaffoldBackgroundColor: const Color(0xff1f2029),
              useMaterial3: true,
            ),
          );
        },
      ),
    );
  }
}
