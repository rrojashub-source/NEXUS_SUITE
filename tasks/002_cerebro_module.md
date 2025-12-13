# Task: CEREBRO Module Implementation

## Metadata
- **Task ID:** TASK-002
- **Module:** CEREBRO
- **Priority:** HIGH
- **Estimated Time:** 4-6 hours
- **Dependencies:** TASK-001 (Flutter Init)

## Objective
Implement the CEREBRO client module - chat interface with NEXUS brain, memory search, and episode management.

## Features

### Feature 1: Chat Interface
- Text input for messages
- Message history display
- Typing indicators
- Auto-scroll to latest

### Feature 2: Memory Search
- Search bar with semantic query
- Results list with relevance score
- Tap to view full episode
- Filter by tags/date

### Feature 3: Episode Viewer
- View episode details
- See related episodes
- Create new episode from app

## API Endpoints Required

```
POST /api/v1/cerebro/chat
Request: { "message": string, "context_episodes": int[] }
Response: { "response": string, "sources": Episode[] }

GET /api/v1/cerebro/search?q={query}&limit={n}
Response: { "episodes": Episode[], "total": int }

GET /api/v1/cerebro/episodes?limit={n}&offset={o}
Response: { "episodes": Episode[], "total": int }

POST /api/v1/cerebro/episodes
Request: { "content": string, "tags": string[], "metadata": object }
Response: { "episode": Episode }
```

## UI Mockup

```
┌─────────────────────────────┐
│  ◀  CEREBRO          🔍 ⚙️  │
├─────────────────────────────┤
│                             │
│  ┌───────────────────────┐  │
│  │ 🧠 NEXUS              │  │
│  │ Hola Ricardo, ¿en qué │  │
│  │ puedo ayudarte?       │  │
│  └───────────────────────┘  │
│                             │
│      ┌───────────────────┐  │
│      │ Busca información │  │
│      │ sobre el proyecto │  │
│      │ ARIA              │  │
│      └───────────────────┘  │
│                             │
├─────────────────────────────┤
│ ┌─────────────────────┐ 📎  │
│ │ Escribe un mensaje  │  ➤  │
│ └─────────────────────┘     │
└─────────────────────────────┘
```

## Success Criteria
- [ ] Can send messages and receive responses
- [ ] Can search CEREBRO memory
- [ ] Can view episode details
- [ ] Works offline (shows cached data)
- [ ] Handles errors gracefully
