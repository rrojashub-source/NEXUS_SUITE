# NEXUS_SUITE - Project Constitution

## Project Mission
Build a unified Flutter application suite that serves as the primary interface for the NEXUS ecosystem. Connects to CEREBRO brain, provides PDF tools, and evolves into ARIA personal assistant. Success = Ricardo can interact with his entire digital ecosystem from phone or desktop.

## Technology Stack
- **Framework:** Flutter 3.x (Dart)
- **Platforms:** Android, Windows (single codebase)
- **Backend:** FastAPI on VPS (Hostinger)
- **Database:** PostgreSQL 16 + pgvector (port 5436)
- **Cache:** Redis (port 5437)
- **State Management:** Riverpod 2.x
- **HTTP Client:** Dio
- **Local Storage:** Hive / SharedPreferences

## Architecture

```
lib/
├── core/                    # Core utilities, constants, themes
│   ├── config/              # App configuration, API endpoints
│   ├── theme/               # App theming
│   ├── utils/               # Helper functions
│   └── constants/           # App constants
├── features/                # Feature modules
│   ├── cerebro/             # CEREBRO chat & memory interface
│   ├── pdf_tools/           # PDF toolkit module
│   └── aria/                # ARIA assistant (future)
├── shared/                  # Shared widgets & services
│   ├── widgets/             # Reusable UI components
│   └── services/            # API services, auth
└── main.dart                # App entry point
```

## Modules Roadmap

### Module 1: CEREBRO Client (MVP)
- Chat interface with NEXUS
- Search CEREBRO memory
- View/create episodes
- Voice input (optional)

### Module 2: PDF Toolkit
- Merge, split, compress PDFs
- OCR text extraction
- Convert formats
- Process via VPS backend

### Module 3: ARIA Assistant
- Email management
- Task sync (ClickUp)
- Calendar integration
- Smart reminders

## API Endpoints (VPS)

Base URL: `https://[VPS_DOMAIN]/api/v1`

```
# CEREBRO
POST   /cerebro/chat          # Send message, get response
GET    /cerebro/search        # Semantic search
GET    /cerebro/episodes      # List recent episodes
POST   /cerebro/episodes      # Create episode

# PDF Tools
POST   /pdf/merge             # Merge PDFs
POST   /pdf/split             # Split PDF
POST   /pdf/compress          # Compress PDF
POST   /pdf/ocr               # Extract text (OCR)

# ARIA (future)
GET    /aria/emails           # Get prioritized emails
GET    /aria/tasks            # Get pending tasks
POST   /aria/remind           # Create reminder
```

## Commands

```bash
# Run app (debug)
flutter run

# Run on specific device
flutter run -d windows
flutter run -d [android_device_id]

# Build APK
flutter build apk --release

# Build Windows
flutter build windows --release

# Run tests
flutter test

# Analyze code
flutter analyze
```

## Coding Standards
- Dart analysis: strict mode
- Naming: camelCase for variables, PascalCase for classes
- Files: snake_case.dart
- Widgets: One widget per file
- State: Riverpod providers in `providers/` subfolder
- Tests: Mirror lib/ structure in test/

## DO NOT TOUCH
- `android/app/google-services.json` - Firebase config (if added)
- `.env.production` - Production secrets
- `lib/core/config/api_config.dart` - API keys (use env vars)

## Memory Protocol
- **Session start:** Read `memory/shared/current_phase.md`
- **During session:** Update `memory/[module]/` with discoveries
- **Session end:** Update `current_phase.md` + `TRACKING.md`

## Git Workflow
- Branch: `feature/[module]-[feature]`
- Commits: `<type>(<scope>): <message>`
- Types: feat, fix, refactor, test, docs, chore
- Always include: `Co-Authored-By: Claude <noreply@anthropic.com>`
