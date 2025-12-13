import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app.dart';
import 'core/utils/logger.dart';
import 'shared/services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize logging
  AppLogger.i('Starting NEXUS Suite...');

  // Initialize Hive (local storage)
  await Hive.initFlutter();

  // Initialize storage service
  await StorageService.instance.init();

  AppLogger.i('Initialization complete');

  runApp(
    const ProviderScope(
      child: NexusSuiteApp(),
    ),
  );
}
