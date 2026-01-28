# Break Timer App

A polished and functional Break Timer application built with Flutter, designed to help users manage their break times effectively. The app features a modern UI with smooth animations, customizable timer settings, and a robust architecture.

## 🌟 Features

-   **Customizable Timer:** Choose from preset durations (10, 15, 30, 45, 60 minutes) to suit your break needs.
-   **Dynamic Adjustments:** Changing the timer duration mid-break intelligently adjusts the remaining time based on what has already elapsed.
-   **Visual Progress:** A beautiful circular progress indicator that visually represents time remaining.
-   **Collapsing Header:** A sophisticated scrolling effect where the header collapses and the timer card transitions seamlessly as you scroll.
-   **Status Timeline:** A visual timeline tracking your session status (Login, Lunch in Progress, Logout).
-   **Smart Notifications:** Confirmation prompts prevent accidental break cancellations.
-   **Theming:** Centralized design system with custom `ThemeExtension` for consistent colors and typography.

## 🛠️ Tech Stack

-   **Flutter:** UI Toolkit.
-   **Bloc / Cubit:** State Management for predictable state changes and business logic separation.
-   **Equatable:** Value equality for efficient state comparison.
-   **Intl:** Date and time formatting.
-   **Bloc Test & Mocktail:** Comprehensive unit and widget testing.

## 📂 Project Structure

The project follows a **Feature-First** architecture with a clear separation of concerns:

```
lib/
├── timer/                  # Feature: Timer
│   ├── bloc/               # State Management (Cubit & State)
│   └── presentation/       # UI Layer
│       ├── view/           # Screens (TimerPage, SettingsPage)
│       └── widgets/        # Reusable Components (TimerCard, Timeline, etc.)
├── values/                 # Design System
│   ├── app_colors.dart     # Color Palette
│   ├── app_text_styles.dart # Typography
│   └── app_theme.dart      # ThemeData & Extensions
└── main.dart               # Entry Point
```

## 🚀 Getting Started

### Prerequisites

-   [Flutter SDK](https://flutter.dev/docs/get-started/install) installed.
-   An IDE (VS Code, Android Studio, or IntelliJ) with Flutter plugins.

### Installation

1.  **Clone the repository:**
    ```bash
    git clone <repository-url>
    cd timer
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Run the app:**
    ```bash
    flutter run
    ```

4.  **Run tests:**
    ```bash
    flutter test
    ```

## 📦 Building for Production

To generate a release build for Android or iOS:

**Android (APK):**
```bash
flutter build apk --release
```

**Android (App Bundle):**
```bash
flutter build appbundle --release
```

**iOS (Requires Xcode):**
```bash
flutter build ios --release
```

## 🎨 Design Highlights

-   **Overlapping UI:** The `TimerCard` visually overlaps the app bar for a layered, depth-rich effect.
-   **Animations:** `TweenAnimationBuilder` ensures the timer progress arc animates smoothly (60 FPS).
-   **Consistent Styling:** All colors and text styles are derived from `Theme.of(context)`, making the app easy to maintain and skin.