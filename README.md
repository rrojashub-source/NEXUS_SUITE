# 🚀 NEXUS_SUITE

**The unified application suite for the NEXUS ecosystem.**

![Status](https://img.shields.io/badge/status-initialization-yellow)
![Platform](https://img.shields.io/badge/platform-Android%20%7C%20Windows-blue)
![Framework](https://img.shields.io/badge/framework-Flutter-02569B)

## 🎯 Vision

A single application that connects Ricardo to his entire digital ecosystem:

- **💬 CEREBRO Client** - Chat with NEXUS brain, search memories, create episodes
- **📄 PDF Toolkit** - Merge, split, compress, OCR - no more paid subscriptions
- **🤖 ARIA Assistant** - Email management, task sync, smart reminders

## 🏗️ Architecture

```
┌─────────────────────────────────────────┐
│              NEXUS_SUITE                │
│         (Flutter Application)           │
├─────────────┬─────────────┬─────────────┤
│   CEREBRO   │  PDF Tools  │    ARIA     │
│   Module    │   Module    │   Module    │
└──────┬──────┴──────┬──────┴──────┬──────┘
       │             │             │
       └─────────────┼─────────────┘
                     │ HTTPS/API
                     ▼
         ┌───────────────────────┐
         │      VPS Backend      │
         │  (FastAPI + CEREBRO)  │
         └───────────────────────┘
```

## 📱 Platforms

| Platform | Status | Notes |
|----------|--------|-------|
| Android | 🟡 Planned | Primary target |
| Windows | 🟡 Planned | Desktop companion |
| iOS | ⚪ Future | If needed |
| Web | ⚪ Future | Dashboard only |

## 🛠️ Tech Stack

- **Framework:** Flutter 3.x
- **Language:** Dart
- **State:** Riverpod
- **HTTP:** Dio
- **Storage:** Hive
- **Backend:** FastAPI (Python)
- **Database:** PostgreSQL + pgvector
- **Cache:** Redis

## 🚦 Roadmap

### Phase 1: Foundation (Current)
- [x] Repository setup
- [x] Architecture definition
- [ ] Flutter project init
- [ ] Base UI components
- [ ] API service layer

### Phase 2: CEREBRO Module
- [ ] Chat interface
- [ ] Memory search
- [ ] Episode viewer
- [ ] Voice input

### Phase 3: PDF Toolkit
- [ ] File picker
- [ ] Merge/Split
- [ ] Compress
- [ ] OCR

### Phase 4: ARIA Assistant
- [ ] Email integration
- [ ] Task sync
- [ ] Calendar view
- [ ] Reminders

## 🏃 Quick Start

```bash
# Clone repository
git clone https://github.com/rrojashub-source/NEXUS_SUITE.git
cd NEXUS_SUITE

# Initialize Flutter (first time only)
flutter create . --org com.nexus --project-name nexus_suite

# Get dependencies
flutter pub get

# Run
flutter run
```

## 📖 Documentation

- [CLAUDE.md](./CLAUDE.md) - Project constitution
- [TRACKING.md](./TRACKING.md) - Session logs
- [tasks/](./tasks/) - Implementation plans

## 🤖 Development Protocol

This project follows the **NEXUS Methodology**:

1. **EXPLORAR** - Understand before coding
2. **PLANIFICAR** - Create persistent plans
3. **CODIFICAR** - TDD implementation
4. **CONFIRMAR** - Commit with documentation

## 👤 Author

**Ricardo Rojas** - Guardian of NEXUS
- GitHub: [@rrojashub-source](https://github.com/rrojashub-source)

## 📄 License

Private - NEXUS Ecosystem

---

*Built with 🧠 by NEXUS@CLI, NEXUS@WEB, and the NEXUS ecosystem*
