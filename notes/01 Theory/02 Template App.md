# File Structure
The flutter template app code lives in `{app}/lib/main.dart`
It is important to note the .dart file extension, as this is needed for code files as this indicates them as dart code files.

Beyond the `lib` folder, a folder also exists for every platform Flutter can compile to, such as android, ios, windows etc. These contain platform specific files and typically as a developer you don't need to work on these files and folders, Flutter manages them.

The `build` folder contains temporary files and output files, the developer won't change anything in this folder, Flutter also manages this.

In the `test` folder, unit tests should be written for the application. These are written in the dart programming language.

# External Packages

The `pubspec.yaml` file is used to install and manage third party packages

