# Weider App

Weider is a modern Flutter mobile application built for gym management and member tracking.  
It enables adding, editing, and displaying gym members, managing their subscription dates, and handling notifications and storage efficiently through a clean and structured architecture.

---

## Features

- User management (add, edit, delete)
- Image handling with image picker and local storage
- Subscription date tracking and automatic calculation of end dates
- Local notifications for subscription renewals or reminders
- Offline local storage using Hive
- Shared preferences for lightweight settings
- Dependency injection using GetIt
- State management using Flutter BLoC
- Custom reusable input components
- Light and dark theme support
- Responsive typography and custom text extensions

---

## Tech Stack

|         Layer        |                Package                |            Purpose            |
|----------------------|---------------------------------------|-------------------------------|
| State Management     | flutter_bloc                          | Reactive UI updates           |
| Dependency Injection | get_it                                | Global service management     |
| Database             | hive_flutter, hive_generator          | Local NoSQL storage           |
| Media & Files        | image_picker, path_provider           | File and image handling       |
| Notifications        | flutter_local_notifications, timezone | Local notifications           |
| Device Handling      | device_preview                        | UI testing and responsiveness |
| Utilities            | shared_preferences, uuid              | Persistent settings & unique IDs |

---

## Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/weider.git
cd weider
````

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Generate Hive Adapters (if any models use annotations)

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 4. Run the App

```bash
flutter run
```

---

## Building for Release

### Standard Release Build

```bash
flutter build apk --release
```

### Split per ABI (to reduce size)

```bash
flutter build apk --release --split-per-abi
```

This generates multiple APKs (for different device architectures) under:

```URL
build/app/outputs/flutter-apk/
```

### App Bundle for Google Play

```bash
flutter build appbundle --release
```

This creates a single `.aab` file:

```URL
build/app/outputs/bundle/release/app-release.aab
```

which should be uploaded to Google Play Console.
Google Play will automatically generate smaller APKs for each device architecture and language.

---

## Development Tools

- Flutter DevTools for performance and widget rebuild tracking
- Device Preview for testing layouts on different devices

---

## Theming

The app uses a centralized theme system (`AppTheme`) with:

- Light and Dark modes
- `TextThemeExtension` for consistent typography
- Color management through `AppColors`

---

## Key Components

- `MyApp`: Main entry point
- `DisplayUsersScreen`: Displays all members
- `AddEditUserScreen`: Handles user creation and editing
- `CustomTextInputField`: Smart form field with validation and edit toggling
- `UserImageCubit`: Handles image picking and preview
- `HivePrepared` & `NotificationPrepared`: Initialize local storage and notifications

---

## Permissions

The app requires:

- Storage access (to pick and save images)
- Notification access (for scheduled reminders)

---

## Future Improvements

- Add cloud synchronization (Firebase / Supabase)
- Add localization (English & Arabic)
- Create dashboard with statistics (active vs expired members)
- Export data to CSV or Excel

---

## Author

**Mahmoud Saeed**
Flutter Developer
Email: [mahmoudsaeedm24@gmail.com](mailto:mahmoudsaeedm24@gmail.com)
