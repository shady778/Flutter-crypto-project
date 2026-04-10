# First Flutter Project 🚀

A modern, feature-rich Flutter application built with **Clean Architecture** and **Bloc Pattern**. This project demonstrates a complete flow from onboarding and authentication to complex dashboard screens.

## ✨ Features

- **Onboarding Experience:** Smooth introduction screens for new users.
- **Authentication:** Fully functional Sign In and Sign Up screens.
- **Dynamic Dashboard:** A main wrapper containing:
    - **Home:** Overview and quick actions.
    - **Market:** Real-time data or item listings.
    - **Wallet:** Financial overview and transactions.
    - **Activity:** History and logs.
- **Profile & Settings:** User management and app configuration.
- **Advanced UI:** Custom widgets, SVGs, and a consistent color palette.

## 🛠️ Tech Stack & Architecture

- **State Management:** [Flutter Bloc](https://pub.dev/packages/flutter_bloc) for predictable state transitions.
- **Navigation:** [GoRouter](https://pub.dev/packages/go_router) for declarative routing.
- **Networking:** [Dio](https://pub.dev/packages/dio) for API calls.
- **Local Database:** [Sqflite](https://pub.dev/packages/sqflite) for persistent data storage.
- **Local Storage:** [Shared Preferences](https://pub.dev/packages/shared_preferences) for simple key-value pairs.
- **Data Modeling:** [Equatable](https://pub.dev/packages/equatable) for value-based comparisons.
- **Assets:** Custom SVG integration using [Flutter SVG](https://pub.dev/packages/flutter_svg).

## 📁 Project Structure

```text
lib/
├── core/          # Constants, themes, and utilities
├── data/          # Models, repositories, and data providers
└── presentation/  # UI Layer
    ├── ui/        # Screens (Home, Market, Wallet, etc.)
    ├── cubits/    # Logic and state management
    ├── widgets/   # Reusable UI components
    └── colors/    # App color palette
```

## 🚀 Getting Started

1.  **Clone the repo:**
    ```bash
    git clone https://github.com/YOUR_USERNAME/first_flutter_project.git
    ```
2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```
3.  **Run the app:**
    ```bash
    flutter run
    ```

## 📸 Screenshots

*(Add your screenshots here later to make it even more professional!)*
