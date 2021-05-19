# Fishapp Mobile App
This application was developed as part of a bachelor thesis at NTNU Ålesund.

# Versions
The software has been built and tested with the following SDK versions:
```
Dart 2.10.5
Flutter 1.22.6
```
# Folder structure
The most important folders in the project is listed below.
 * *assets* - contains static images, fonts and generated locatizations
 * *dev_tools* - various utility scripts used during development
 * *lib* - source code of the project

```
(*) = must be runned at first start

├── android
├── assets
│   ├── fonts <-- fonts packages embedded in app
│   ├── images <-- static images in-app
│   └── l10n <-- translation source files, one per language
├── dev_tools 
│   ├── build_local.sh <-- build translation output files (*)
│   ├── jsonbuild.sh <-- build JSON-serialization code (*)
│   ├── jsonclean.sh <-- removes generated JSON-serialization code
│   └── jsonwatch.sh
├── flutter.yml
├── ios
├── l10n.yaml
├── lib
│   ├── config
│   ├── constants <-- contains server endpoint and other static definitions
│   ├── entities
│   ├── generated
│   ├── main.dart <-- main class for project
│   ├── pages
│   ├── utils
│   └── widgets
├── pubspec.lock
├── pubspec.yaml 
└── README.md
```
