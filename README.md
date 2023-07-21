# My-ToDo-App
My-ToDo-App is a Flutter app that helps you organize your tasks and get things done. You can create tasks with different categories, priorities, and deadlines. You can also set recurring tasks and reminders to never miss a deadline. My-ToDo-App syncs your data with Firebase and stores it locally with Hive, so you can access your tasks anytime, anywhere.

## Features
* Create, edit, and delete tasks
* Categorize tasks by color and icon
* Sort tasks by priority, deadline, or category
* Set recurring tasks and skip days
* Set reminders and notifications for tasks
* Sync data with Firebase and store locally with Hive
* Login and register with Firebase Auth

## Screenshots
<p float="left">
<img src="https://github.com/somaga1/My-ToDo-App/assets/89393974/ca0e59df-1460-4a9c-9a9e-6f2dad1ed88c" alt="293209_9c235a7749e1ae47b42a38f67f06f335-11_23_2022, 2_30_35 AM" width="50%" height="50%"/>
<img src="https://github.com/somaga1/My-ToDo-App/assets/89393974/ca0e59df-1460-4a9c-9a9e-6f2dad1ed88c" alt="293209_9c235a7749e1ae47b42a38f67f06f335-11_23_2022, 2_30_35 AM" width="50%" height="50%"/>
<p/>
![293209_9c235a7749e1ae47b42a38f67f06f335-11_23_2022, 2_30_35 AM](https://github.com/somaga1/My-ToDo-App/assets/89393974/ca0e59df-1460-4a9c-9a9e-6f2dad1ed88c)
![293212_4608935fe6f86ad0dce2abdda0aec7d9-11_23_2022, 2_32_39 AM](https://github.com/somaga1/My-ToDo-App/assets/89393974/37e63297-d026-4c2d-88a1-b53a780588fc)
![293204_cdb229eb989fe22ce80ab9eb7fd17689-11_23_2022, 2_28_44 AM](https://github.com/somaga1/My-ToDo-App/assets/89393974/854cdaa7-e64b-42cb-bfcb-e2ce25298775)
![293203_d41133c2b5876411e6f39622135e5339-11_23_2022, 2_28_28 AM](https://github.com/somaga1/My-ToDo-App/assets/89393974/7b92b554-01a6-42c5-81e8-4c444bf117ec)
![293205_8abff2b0670bd2b0a393ea4e08ef4210-11_23_2022, 2_29_01 AM](https://github.com/somaga1/My-ToDo-App/assets/89393974/04558b4c-8051-40f3-af9b-685ac8b3c39c)
![293208_b4206b68e3a3088bffd96eb45f7ecf86-11_23_2022, 2_30_00 AM](https://github.com/somaga1/My-ToDo-App/assets/89393974/01eaf36e-91e0-4067-8837-32f1e191e5fb)
![293206_8537336339769c5d994fc685b833bd29-11_23_2022, 2_29_12 AM](https://github.com/somaga1/My-ToDo-App/assets/89393974/044d0573-c3f2-498a-8d84-6e7b05cca111)


## Installation
To run this app, you need to have Flutter installed on your machine. Follow the instructions <a href="https://docs.flutter.dev/">here</> to install Flutter.

Then, clone this repository and open it in your preferred IDE. Run `flutter pub get` to get the dependencies.

You also need to set up Firebase for your app. Follow the instructions <a href="https://firebase.google.com/docs">here</> to create a Firebase project and add the configuration files to your app.


Finally, run `flutter run` to launch the app on your device or emulator.

## Dependencies
This app uses the following packages:

- flutter_riverpod: A provider-based state management solution for Flutter
- get: A lightweight library for navigation, dialogs, snackbars, and more
- hive: A fast and lightweight key-value database for Flutter
- firebase_core: A plugin for Firebase Core APIs
- firebase_auth: A plugin for Firebase Authentication
- cloud_firestore: A plugin for Cloud Firestore
- flutter_local_notifications: A plugin for displaying local notifications on Flutter apps
- timezone: A library for working with time zones in Dart
- flutter_native_timezone: A plugin for getting the native time zone of the device

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^1.0.0-dev.6
  get: ^4.3.8
  hive: ^2.0.4
  hive_flutter: ^1.1.0
  firebase_core: ^1.10.6
  firebase_auth: ^3.3.5
  cloud_firestore: ^3.1.7
  flutter_local_notifications: ^9.2.0
  timezone: ^0.7.0+2
  flutter_native_timezone: ^2.0.0+1```

# License
This project is licensed under the MIT License - see the LICENSE file for details.
