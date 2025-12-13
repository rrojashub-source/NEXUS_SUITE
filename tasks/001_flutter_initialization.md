# Task: Flutter Project Initialization

## Metadata
- **Task ID:** TASK-001
- **Module:** Foundation
- **Priority:** CRITICAL
- **Estimated Time:** 1-2 hours
- **Assigned To:** NEXUS@CLI / Ricardo

## Objective
Initialize Flutter project with proper structure, dependencies, and base configuration.

## Prerequisites
- [ ] Flutter SDK installed (3.x)
- [ ] Android Studio with Android SDK
- [ ] Windows development tools (for Windows build)

## Implementation Plan

### Step 1: Initialize Flutter Project
```bash
cd D:\01_PROYECTOS_ACTIVOS\NEXUS_SUITE
flutter create . --org com.nexus --project-name nexus_suite --platforms android,windows
```

### Step 2: Update pubspec.yaml
```yaml
name: nexus_suite
description: NEXUS ecosystem unified application suite
version: 0.1.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  
  # State Management
  flutter_riverpod: ^2.4.0
  riverpod_annotation: ^2.3.0
  
  # Networking
  dio: ^5.4.0
  
  # Local Storage
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  shared_preferences: ^2.2.2
  
  # UI
  google_fonts: ^6.1.0
  flutter_svg: ^2.0.9
  cached_network_image: ^3.3.1
  
  # Utils
  intl: ^0.18.1
  path_provider: ^2.1.2
  url_launcher: ^6.2.2
  
  # File handling (for PDF module)
  file_picker: ^6.1.1
  open_file: ^3.3.2

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.1
  riverpod_generator: ^2.3.0
  build_runner: ^2.4.8
  hive_generator: ^2.0.1

flutter:
  uses-material-design: true
  
  assets:
    - assets/images/
    - assets/icons/
```

### Step 3: Create Base Files

**lib/main.dart:**
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  
  runApp(
    const ProviderScope(
      child: NexusSuiteApp(),
    ),
  );
}
```

### Step 4: Run & Verify
```bash
flutter pub get
flutter analyze
flutter run
```

## Success Criteria
- [ ] App compiles without errors
- [ ] Runs on Android emulator
- [ ] Runs on Windows
- [ ] Folder structure matches architecture
- [ ] Theme applies correctly
