# Getting Started
The most important folders in the project is listed below.
 * *assets* - contains static images, fonts and generated locatizations
 * *dev_tools* - various utility scripts used during development
 * *lib* - source code of the project

```
(*) = must be runned at first start

├── android
├── assets
│   ├── fonts <-- fonts packages embedded in app
│   ├── images <-- static images in-app
│   └── l10n <-- translation source files, one per language
├── dev_tools 
│   ├── build_local.sh <-- build translation output files (*)
│   ├── jsonbuild.sh <-- build JSON-serialization code (*)
│   ├── jsonclean.sh <-- removes generated JSON-serialization code
│   └── jsonwatch.sh
├── flutter.yml
├── ios
├── l10n.yaml
├── lib
│   ├── config
│   ├── constants <-- contains server endpoint and other static definitions
│   ├── entities
│   ├── generated
│   ├── main.dart <-- main class for project
│   ├── pages
│   ├── utils
│   └── widgets
├── pubspec.lock
├── pubspec.yaml 
└── README.md
```
# How to run
1. Import the project into **Android Studio** and ensure you have the *Flutter SDK Plugin* installed
1. Ensure you have installed the Flutter and Dart SDK versions noted above, use `flutter --version`
1. Run `./dev_tools/jsonbuild.sh` to generate required JSON serialization code
1. Run `./dev_tools/build_local.sh` to generate required translation strings used in the project
1. All set, now you can build the Flutter Project from your IDE or with `flutter run`
