# 🔄 HANDOFF: NEXUS@WEB → NEXUS@CLI

**Fecha:** 2025-12-13
**De:** NEXUS@WEB (Supervisor)
**Para:** NEXUS@CLI (Ejecutor)
**Prioridad:** HIGH

---

## 📋 Resumen de Sesión

Ricardo y yo (NEXUS@WEB) diseñamos la arquitectura completa de **NEXUS_SUITE** - una app Flutter unificada para el ecosistema NEXUS. Toda la documentación está en GitHub, pero **falta inicializar Flutter**.

---

## ✅ Lo que ya hicimos

| Item | Estado |
|------|--------|
| Repo GitHub | ✅ https://github.com/rrojashub-source/NEXUS_SUITE |
| CLAUDE.md | ✅ Constitución del proyecto |
| README.md | ✅ Documentación completa |
| tasks/001_flutter_initialization.md | ✅ Plan con pubspec.yaml |
| tasks/002_cerebro_module.md | ✅ Plan módulo CEREBRO |
| memory/shared/current_phase.md | ✅ Estado dinámico |
| Push a GitHub | ✅ Commit 69e177fb |

---

## ❌ Lo que falta

| Item | Estado |
|------|--------|
| `flutter create` | ❌ NO ejecutado |
| pubspec.yaml | ❌ No existe |
| lib/ folder | ❌ No existe |
| android/ folder | ❌ No existe |
| windows/ folder | ❌ No existe |

---

## 🚨 Problema Actual

Ricardo instaló Flutter pero el comando no funciona en terminal. Posibles causas:
1. PATH no configurado
2. Terminal no reiniciada
3. Instalación incompleta

---

## 📝 INSTRUCCIONES PARA NEXUS@CLI

### Paso 1: Verificar Flutter
```bash
flutter doctor
```

Si no funciona, agregar al PATH:
```bash
# Buscar donde se instaló Flutter
where flutter
# O agregar manualmente:
setx PATH "%PATH%;C:\flutter\bin"
```

### Paso 2: Ir a la carpeta
```bash
cd D:\01_PROYECTOS_ACTIVOS\NEXUS_SUITE
```

### Paso 3: Sincronizar con GitHub
```bash
git pull origin main
```

### Paso 4: Crear proyecto Flutter
```bash
flutter create . --org com.nexus --project-name nexus_suite --platforms android,windows
```

### Paso 5: Actualizar pubspec.yaml
Copiar dependencias de `tasks/001_flutter_initialization.md`

### Paso 6: Instalar dependencias
```bash
flutter pub get
```

### Paso 7: Crear estructura lib/
Seguir arquitectura de `CLAUDE.md`:
```
lib/
├── core/
├── features/
│   ├── cerebro/
│   ├── pdf_tools/
│   └── aria/
├── shared/
└── main.dart
```

### Paso 8: Verificar que compile
```bash
flutter run
```

### Paso 9: Commit y Push
```bash
git add .
git commit -m "feat(flutter): initialize Flutter project with base structure"
git push origin main
```

---

## 📚 Archivos Clave a Leer

1. **CLAUDE.md** - Constitución del proyecto (arquitectura, comandos, estándares)
2. **tasks/001_flutter_initialization.md** - Plan detallado con pubspec.yaml completo
3. **tasks/002_cerebro_module.md** - Plan del módulo CEREBRO (siguiente fase)
4. **memory/shared/current_phase.md** - Estado actual del proyecto

---

## 🎯 Objetivo Final

App Flutter funcionando que:
- Compile en Android y Windows
- Tenga estructura modular (cerebro, pdf_tools, aria)
- Use Riverpod para state management
- Se conecte a CEREBRO API en VPS

---

## 💡 Notas

- GitHub MCP funciona con nuevo PAT token
- Workflow validado: Mobile → RustDesk → Desktop → GitHub
- Si `flutter doctor` reporta problemas de Android SDK, ejecutar:
  ```bash
  flutter doctor --android-licenses
  ```

---

**¡Éxito NEXUS@CLI! El proyecto está bien definido, solo falta ejecutar.** 🚀

---
*Generado por NEXUS@WEB - 2025-12-13*
