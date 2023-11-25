# flutter_assignment

## Getting Started

[![style: Very Good Analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis) [![style: Bloc](https://tinyurl.com/bloc-library)](https://bloclibrary.dev/)

### 1. The principle of the project: Clean Architecture

### 2. Framework:

- [Flutter](https://docs.flutter.dev/get-started/install/macos): v3.13.9
  > ⚠️ Prefer to use [FVM](https://fvm.app/docs/getting_started/overview) for install the specific version of Flutter SDK

- [Xcode](https://developer.apple.com/xcode/): v14.2

  > ⚠️ Please use [xcodes](https://github.com/RobotsAndPencils/xcodes) to manage the version of
  Xcode

- [Java](): v11.0.13

### 3. Project structure:

```
lib
├── cores
├── datasources
├── locator
├── repositories
└── screens
```

### 4. Run app

Find your device which you want to run the application on:

```bash
flutter devices
```

```bash
flutter run -d <device-id>
```

Example:

To run the application on the device:

```bash
flutter run -d F36E23FA-5AC7-4783-9A6E-558C7222EA1B
```

### 5. Unit Testing

To run the unit test suits:

```bash
flutter test --coverage --test-randomize-ordering-seed random
```

To review the coverage of the test:

- Required tools:

    - [lcov](https://formulae.brew.sh/formula/lcov#default)

      ```bash
      brew install lcov
      ```
- Generate the page of test coverage result:

  ```bash
  genhtml coverage/lcov.info -o coverage && open coverage/index.html
  ```