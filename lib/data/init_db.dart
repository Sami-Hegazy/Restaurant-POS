import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter/foundation.dart';

Future<void> initializeDatabase() async {
  if (!kIsWeb &&
      defaultTargetPlatform != TargetPlatform.iOS &&
      defaultTargetPlatform != TargetPlatform.android) {
    // Initialize FFI for desktop
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
}
