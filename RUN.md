# Fullstack Auth Prototype (FastAPI + Flutter)

## Backend (local)

```bash
cd backend
python -m venv .venv
source .venv/bin/activate  # Windows: .venv\Scripts\activate
pip install -r requirements.txt
uvicorn main:app --host 0.0.0.0 --port 10000
```

Open:
- http://127.0.0.1:10000/
- http://127.0.0.1:10000/docs

## Backend (Render)

- Create a Render Web Service from the `backend/` folder.
- Start command:
  `uvicorn main:app --host 0.0.0.0 --port 10000`
- Add env var:
  `JWT_SECRET` (any long random string)

After deploy, verify:
- https://YOUR-SERVICE.onrender.com/

## Flutter (local)

1) Create a Flutter project (if you want a fully generated android/ios folder):

```bash
flutter create auth_prototype
```

2) Copy this repo's `frontend/lib` and `frontend/pubspec.yaml` into your Flutter project.

3) Set Render base URL in `lib/api_service.dart`:

```dart
static const String baseUrl = "https://YOUR-SERVICE.onrender.com";
```

4) Run:

```bash
flutter pub get
flutter run
```

## Build APK

Debug APK:
```bash
flutter build apk --debug
```

Release APK:
```bash
flutter build apk --release
```

APK output:
- build/app/outputs/flutter-apk/app-debug.apk
- build/app/outputs/flutter-apk/app-release.apk
