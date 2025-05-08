# 🔔 Notification App

Welcome to the Notification App, a Flutter application that demonstrates how to receive and display both push and local notifications. The app features two main screens and utilizes the BLoC (Business Logic Component) pattern for robust state management.

## Features

- **Push Notification Handling**: Receives and displays push notifications sent via Firebase Cloud Messaging (FCM).
- **Local Notification Handling**: Schedules and displays local notifications triggered within the app.
- **Notification Listing**: A home screen that displays a list of all received notifications.
- **Notification Details**: A dedicated screen to view the detailed content of a selected notification.
- **BLoC State Management**: Employs the BLoC pattern to manage the state of notifications and UI updates.

## Screenshots

*(Include screenshots of your app here. If you don't have them yet, you can add placeholders like the ones below and replace them later.)*

<img src="screenshots/home_screen.png" height="350" alt="Home Screen" />
<img src="screenshots/details_screen.png" height="350" alt="Details Screen" />

## Requirements

- **Flutter CLI Installed**: Ensure you have the Flutter command-line interface (CLI) installed and configured on your system. You can find installation instructions on the official Flutter website: [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install).
- **Dart SDK**: Flutter comes bundled with the Dart SDK, so installing Flutter will also install Dart.
- **Firebase Project**: To enable push notification functionality, you need to have a Firebase project created and configured.

## Installation

1. **Clone the repository**:
   Open your terminal or command prompt and navigate to the directory where you want to clone the project. Then, run the following command, replacing `https://github.com/lauritaila/local_push_notifications_flutter.git` with the actual URL of your project's repository:
   ```bash
   git clone https://github.com/lauritaila/local_push_notifications_flutter.git
   ```
   2.**Navigate to the project directory**: 
   Once the repository is cloned, navigate into the project directory using the cd command:
   ```bash
   cd local_push_notifications_flutter
   ```
   3.**Set up Firebase (for push notifications)**:
    + **Create a Firebase Project**: Go to the Firebase Console ([https://console.firebase.google.com/]) and create a new project. Follow the on-screen instructions.
    + **Add Firebase to your Flutter app**: For both Android and iOS, you need to add your Flutter app to your Firebase project:
      - **Android**: Follow the steps in the Firebase console to register your Android app, providing your app's package name (found in `android/app/build.gradle` under `defaultConfig/applicationId`). Download the `google-services.json` file and place it in the `android/app` directory of your Flutter project.
      - **iOS**: Follow the steps in the Firebase console to register your iOS app, providing your app's bundle identifier (found in `ios/Runner/Info.plist` under `CFBundleIdentifier`). Download the `Runner-Info.plist` file and place it in the `ios/Runner` directory of your Flutter project.
    + **Enable Firebase Cloud Messaging (FCM)**: In your Firebase project, navigate to "Project settings" -> "Cloud Messaging" and ensure that the FCM service is enabled.    
   4. **Install dependencies**:
   Run the following command to install the project's dependencies:
   ```bash
   flutter pub get
   ```
   5. **Run the app**:
    Connect a physical device (for push notifications to work correctly on iOS) or use an emulator/simulator. Then, run the Flutter app using the following command:
   ```bash
   flutter run
   ```
## Project Structure
The app follows a structured approach, separating concerns into different layers and utilizing the BLoC pattern within the presentation layer.

```
local_push_notifications_flutter/
├── lib/
│   ├── config/
│   │   └── router/
│   │       └── app_router.dart       # Defines the app's navigation routes
│   ├── domain/
│   │   └── entities/
│   │       └── push_messages.dart    # Defines the structure for notification data
│   ├── presentation/
│   │   ├── blocs/
│   │   │   └── notifications/
│   │   │       ├── notifications_bloc.dart  # Manages the state of notifications
│   │   │       ├── notifications_event.dart # Defines events related to notifications
│   │   │       └── notifications_state.dart # Defines the different states of notifications
│   │   └── screens/
│   │       ├── details_screen.dart    # Screen to display detailed notification content
│   │       └── home_screen.dart       # Screen to list all received notifications
│   ├── firebase_options.dart       # Configuration for Firebase
│   └── main.dart                   # Entry point of the application
├── android/
├── ios/
├── test/
└── pubspec.yaml                  # Project dependencies
```

## Dependencies
The following dependencies are used in this project:

`equatable: ^2.0.7`: Helps in comparing objects for equality, especially useful in BLoC for state management.  
`firebase_core: ^3.13.0`: Provides core functionality for Firebase integration.  
`firebase_messaging: ^15.2.5`: Enables receiving and handling push notifications from Firebase Cloud Messaging.  
`flutter: sdk: flutter`: The core Flutter SDK.  
`flutter_bloc: ^9.1.0`: Implements the BLoC/Cubit pattern for state management.  
`go_router: ^15.1.1`: A declarative routing package for Flutter that simplifies navigation.  

## Contributing
Contributions are welcome! If you have any suggestions, bug reports, or would like to add new features, please feel free to open an issue or submit a pull request.