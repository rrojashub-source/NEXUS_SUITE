# NEXUS_SUITE - Complete Roadmap

**Project:** NEXUS_SUITE - Unified Flutter Application
**Owner:** Ricardo Rojas
**Created:** December 13, 2025
**Last Updated:** December 13, 2025

---

## 🎯 Vision

Una aplicación Flutter unificada que conecta a Ricardo con todo su ecosistema digital:
- 💬 CEREBRO Client - Chat con el cerebro NEXUS, búsqueda de memoria
- 📄 PDF Toolkit - Herramientas PDF sin suscripciones
- 🤖 ARIA Assistant - Gestión de email, tareas, calendario

---

## 📊 Phases Overview

| Phase | Status | Progress | Duration Est. |
|-------|--------|----------|---------------|
| Phase 0: Initialization | ✅ COMPLETE | 100% | ~60 min |
| Phase 1: Foundation | 🔵 NEXT | 0% | ~4-6 hours |
| Phase 2: CEREBRO Module | ⚪ PENDING | 0% | ~8-10 hours |
| Phase 3: PDF Toolkit | ⚪ PENDING | 0% | ~6-8 hours |
| Phase 4: ARIA Assistant | ⚪ PENDING | 0% | ~10-12 hours |
| Phase 5: Polish & Deploy | ⚪ PENDING | 0% | ~4-6 hours |

**Total Estimated:** ~32-42 hours

---

## ✅ PHASE 0: INITIALIZATION (COMPLETE)

**Status:** ✅ 100% Complete
**Duration:** ~60 minutes
**Completed:** December 13, 2025

### Objectives
- Initialize Flutter project
- Setup dependencies
- Create base folder structure
- Configure Git and GitHub

### Completed Tasks
- [x] Flutter 3.38.3 project initialized (48 files)
- [x] 120 dependencies installed (Riverpod, Dio, Hive, etc.)
- [x] Base structure: lib/{core, features, shared}
- [x] Module folders: cerebro, pdf_tools, aria
- [x] Analysis passed: No issues found
- [x] Pushed to GitHub: commit 6c8fc4e

### Deliverables
- ✅ Working Flutter project (Android + Windows)
- ✅ All dependencies configured
- ✅ Clean analysis (no errors)
- ✅ GitHub repository synced

---

## 🔵 PHASE 1: FOUNDATION (NEXT)

**Status:** 🔵 Next in Queue
**Progress:** 0%
**Estimated Duration:** 4-6 hours

### Objectives
- Create app entry point with Riverpod
- Implement base UI theme system
- Setup API service layer
- Create reusable UI components

### Tasks

#### 1.1 App Entry Point
- [ ] Create `lib/app.dart` with ProviderScope
- [ ] Setup routing (go_router or similar)
- [ ] Implement splash screen
- [ ] Add error boundary

**Files to create:**
```
lib/
├── app.dart
└── core/
    └── routing/
        └── app_router.dart
```

#### 1.2 Theme System
- [ ] Create color palette (lib/core/theme/app_colors.dart)
- [ ] Define typography system (app_typography.dart)
- [ ] Create ThemeData (app_theme.dart)
- [ ] Support light/dark mode

**Files to create:**
```
lib/core/theme/
├── app_colors.dart
├── app_typography.dart
├── app_theme.dart
└── theme_provider.dart
```

#### 1.3 API Service Layer
- [ ] Setup Dio client (lib/shared/services/api_service.dart)
- [ ] Configure interceptors (logging, auth, errors)
- [ ] Create API endpoints constants
- [ ] Add error handling

**Files to create:**
```
lib/
├── core/
│   └── config/
│       └── api_config.dart
└── shared/
    └── services/
        ├── api_service.dart
        └── interceptors/
            ├── auth_interceptor.dart
            └── logging_interceptor.dart
```

#### 1.4 Base UI Components
- [ ] AppBar custom widget
- [ ] Loading indicator
- [ ] Error display widget
- [ ] Empty state widget
- [ ] Custom buttons

**Files to create:**
```
lib/shared/widgets/
├── app_bar.dart
├── loading_indicator.dart
├── error_display.dart
├── empty_state.dart
└── buttons/
    ├── primary_button.dart
    └── secondary_button.dart
```

### Success Criteria
- [ ] App runs on Windows with splash screen
- [ ] Theme toggles between light/dark
- [ ] API service makes test request successfully
- [ ] Base widgets render correctly
- [ ] Code analysis: 0 issues

---

## 🧠 PHASE 2: CEREBRO MODULE

**Status:** ⚪ Pending
**Progress:** 0%
**Estimated Duration:** 8-10 hours
**Dependencies:** Phase 1 complete

### Objectives
- Implement chat interface with NEXUS brain
- Enable semantic memory search
- Create episode viewer
- Add voice input (optional)

### Features

#### 2.1 Chat Interface
- [ ] Chat screen UI (messages list, input field)
- [ ] Message bubbles (user vs NEXUS)
- [ ] Typing indicator
- [ ] Auto-scroll to latest message
- [ ] Copy message functionality

**API Endpoint:**
```
POST /api/v1/cerebro/chat
Body: { "message": string, "context_episodes": int[] }
Response: { "response": string, "sources": Episode[] }
```

#### 2.2 Memory Search
- [ ] Search bar with filters
- [ ] Results list with relevance scores
- [ ] Episode detail view
- [ ] Tag filtering
- [ ] Date range filter

**API Endpoint:**
```
GET /api/v1/cerebro/search?q={query}&limit={n}&tags={tags}
Response: { "episodes": Episode[], "total": int }
```

#### 2.3 Episode Viewer
- [ ] Episode detail screen
- [ ] Related episodes section
- [ ] Tags display
- [ ] Metadata (date, importance, etc.)
- [ ] Share episode functionality

**API Endpoint:**
```
GET /api/v1/cerebro/episodes/{id}
Response: { "episode": Episode, "related": Episode[] }
```

#### 2.4 Create Episode
- [ ] Form to create new episode
- [ ] Content input (markdown support?)
- [ ] Tag selection/creation
- [ ] Metadata fields
- [ ] Save to CEREBRO

**API Endpoint:**
```
POST /api/v1/cerebro/episodes
Body: { "content": string, "tags": string[], "metadata": object }
Response: { "episode": Episode }
```

#### 2.5 Voice Input (Optional)
- [ ] Voice recording button
- [ ] Audio to text conversion
- [ ] Send transcribed message
- [ ] Show recording indicator

### Files Structure
```
lib/features/cerebro/
├── screens/
│   ├── chat_screen.dart
│   ├── search_screen.dart
│   └── episode_detail_screen.dart
├── widgets/
│   ├── message_bubble.dart
│   ├── typing_indicator.dart
│   ├── search_result_card.dart
│   └── episode_card.dart
├── providers/
│   ├── chat_provider.dart
│   ├── search_provider.dart
│   └── episodes_provider.dart
└── models/
    ├── message.dart
    ├── episode.dart
    └── search_result.dart
```

### Success Criteria
- [ ] Can send messages and receive responses
- [ ] Search returns relevant results
- [ ] Episodes display correctly
- [ ] Can create new episodes
- [ ] Works offline (shows cached data)
- [ ] Response time <500ms

---

## 📄 PHASE 3: PDF TOOLKIT

**Status:** ⚪ Pending
**Progress:** 0%
**Estimated Duration:** 6-8 hours
**Dependencies:** Phase 1 complete

### Objectives
- Implement PDF manipulation tools
- Replace paid subscriptions with free functionality
- Process PDFs locally when possible, VPS for heavy tasks

### Features

#### 3.1 File Picker & Preview
- [ ] Multi-file picker (file_picker package)
- [ ] PDF thumbnail preview
- [ ] File size display
- [ ] Remove selected file

#### 3.2 Merge PDFs
- [ ] Select multiple PDFs
- [ ] Reorder files (drag & drop)
- [ ] Preview merged result
- [ ] Download merged PDF

**API Endpoint:**
```
POST /api/v1/pdf/merge
Body: { "files": [File], "order": int[] }
Response: { "merged_file": File }
```

#### 3.3 Split PDF
- [ ] Upload single PDF
- [ ] Select page ranges to split
- [ ] Preview splits
- [ ] Download individual PDFs

**API Endpoint:**
```
POST /api/v1/pdf/split
Body: { "file": File, "ranges": [[1,3], [4,10]] }
Response: { "split_files": [File] }
```

#### 3.4 Compress PDF
- [ ] Upload PDF
- [ ] Select compression level (low, medium, high)
- [ ] Show size reduction estimate
- [ ] Download compressed PDF

**API Endpoint:**
```
POST /api/v1/pdf/compress
Body: { "file": File, "level": "medium" }
Response: { "compressed_file": File, "size_reduction": "40%" }
```

#### 3.5 OCR (Text Extraction)
- [ ] Upload PDF/image
- [ ] Extract text via OCR
- [ ] Display extracted text
- [ ] Copy text functionality
- [ ] Export as .txt

**API Endpoint:**
```
POST /api/v1/pdf/ocr
Body: { "file": File, "language": "es" }
Response: { "text": string, "confidence": float }
```

### Files Structure
```
lib/features/pdf_tools/
├── screens/
│   ├── pdf_home_screen.dart
│   ├── merge_pdf_screen.dart
│   ├── split_pdf_screen.dart
│   ├── compress_pdf_screen.dart
│   └── ocr_screen.dart
├── widgets/
│   ├── pdf_file_card.dart
│   ├── pdf_thumbnail.dart
│   └── compression_slider.dart
├── providers/
│   └── pdf_provider.dart
└── models/
    └── pdf_file.dart
```

### Success Criteria
- [ ] Can merge multiple PDFs successfully
- [ ] Split works with page ranges
- [ ] Compression reduces file size
- [ ] OCR extracts text accurately
- [ ] Handles large files (>10MB)
- [ ] Error handling for corrupted PDFs

---

## 🤖 PHASE 4: ARIA ASSISTANT

**Status:** ⚪ Pending
**Progress:** 0%
**Estimated Duration:** 10-12 hours
**Dependencies:** Phase 1 complete

### Objectives
- Integrate email management
- Sync tasks with ClickUp
- Display calendar events
- Create smart reminders

### Features

#### 4.1 Email Management
- [ ] List prioritized emails (inbox)
- [ ] Email detail view
- [ ] Mark as read/unread
- [ ] Archive/delete
- [ ] Quick reply
- [ ] Smart filters (important, unread, starred)

**API Endpoint:**
```
GET /api/v1/aria/emails?filter={filter}&limit={n}
Response: { "emails": Email[], "total": int }
```

#### 4.2 Task Sync (ClickUp)
- [ ] List pending tasks
- [ ] Task detail view
- [ ] Mark task as complete
- [ ] Create new task
- [ ] Filter by project/list
- [ ] Due date alerts

**API Endpoint:**
```
GET /api/v1/aria/tasks?status={status}&project={id}
Response: { "tasks": Task[], "total": int }

POST /api/v1/aria/tasks
Body: { "title": string, "description": string, "due_date": date }
Response: { "task": Task }
```

#### 4.3 Calendar View
- [ ] Monthly/weekly calendar view
- [ ] Event list view
- [ ] Event detail
- [ ] Create new event
- [ ] Reminders for upcoming events

**API Endpoint:**
```
GET /api/v1/aria/calendar?from={date}&to={date}
Response: { "events": Event[] }
```

#### 4.4 Smart Reminders
- [ ] Create reminder with natural language
- [ ] Recurring reminders
- [ ] Location-based reminders (optional)
- [ ] Notification system
- [ ] Snooze functionality

**API Endpoint:**
```
POST /api/v1/aria/reminders
Body: { "title": string, "datetime": datetime, "recurrence": string }
Response: { "reminder": Reminder }
```

### Files Structure
```
lib/features/aria/
├── screens/
│   ├── aria_home_screen.dart
│   ├── emails_screen.dart
│   ├── tasks_screen.dart
│   ├── calendar_screen.dart
│   └── reminders_screen.dart
├── widgets/
│   ├── email_card.dart
│   ├── task_card.dart
│   ├── calendar_widget.dart
│   └── reminder_card.dart
├── providers/
│   ├── email_provider.dart
│   ├── tasks_provider.dart
│   ├── calendar_provider.dart
│   └── reminders_provider.dart
└── models/
    ├── email.dart
    ├── task.dart
    ├── event.dart
    └── reminder.dart
```

### Success Criteria
- [ ] Emails load and display correctly
- [ ] Can mark emails as read/delete
- [ ] ClickUp tasks sync bidirectionally
- [ ] Calendar shows events
- [ ] Reminders trigger notifications
- [ ] Offline mode shows cached data

---

## 🎨 PHASE 5: POLISH & DEPLOY

**Status:** ⚪ Pending
**Progress:** 0%
**Estimated Duration:** 4-6 hours
**Dependencies:** Phases 2-4 complete

### Objectives
- Polish UI/UX
- Optimize performance
- Add onboarding
- Prepare for deployment

### Tasks

#### 5.1 UI/UX Polish
- [ ] Consistent spacing and padding
- [ ] Smooth animations and transitions
- [ ] Loading states for all async operations
- [ ] Error states with helpful messages
- [ ] Empty states with CTAs

#### 5.2 Performance Optimization
- [ ] Image caching optimization
- [ ] Lazy loading for lists
- [ ] Reduce bundle size
- [ ] Optimize API calls (batching, caching)
- [ ] Profile app performance

#### 5.3 Onboarding
- [ ] Welcome screen
- [ ] Feature tour (optional)
- [ ] Initial setup wizard
- [ ] VPS connection configuration
- [ ] Permissions requests

#### 5.4 Testing
- [ ] Unit tests for critical logic
- [ ] Widget tests for key screens
- [ ] Integration tests for main flows
- [ ] Manual testing on Android
- [ ] Manual testing on Windows

#### 5.5 Deployment Preparation
- [ ] Build APK (release mode)
- [ ] Build Windows installer
- [ ] Create app icons
- [ ] Prepare screenshots
- [ ] Write release notes

### Success Criteria
- [ ] App feels smooth and polished
- [ ] No performance issues (60fps)
- [ ] Test coverage >70%
- [ ] APK builds successfully
- [ ] Windows app runs on fresh install

---

## 🎯 Success Metrics

### MVP (Minimum Viable Product)
- [ ] Chat with CEREBRO from phone ✅
- [ ] PDF tools work end-to-end
- [ ] ARIA shows emails and tasks
- [ ] Response time <500ms
- [ ] Works offline (cached data)

### Nice to Have
- [ ] Voice input in CEREBRO
- [ ] Location-based reminders
- [ ] Biometric authentication
- [ ] Dark mode animations
- [ ] iOS support

---

## 📝 Notes

### Technical Decisions
- **State Management:** Riverpod (chosen for type safety and testability)
- **HTTP Client:** Dio (chosen for interceptors and better error handling)
- **Local Storage:** Hive (chosen for performance and simplicity)
- **Routing:** TBD (go_router or auto_route)

### Architecture
- Feature-first folder structure
- Shared widgets and services in `/shared`
- Core utilities in `/core`
- Provider pattern for state management

### Backend Requirements
- VPS with FastAPI server
- PostgreSQL + pgvector for CEREBRO
- Redis for caching
- API authentication (JWT or similar)

---

**Updated:** December 13, 2025 by NEXUS@CLI
