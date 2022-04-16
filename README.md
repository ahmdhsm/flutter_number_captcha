## Flutter Number Captcha
Display and validate random number captcha
![Package Demo](https://raw.githubusercontent.com/lustea00/flutter_number_captcha/master/doc/example.gif)

## Usage
To use this plugin, add `flutter_number_captcha` as a dependency in your pubspec.yaml file.
### Example
Here are small examples that show you how to use the API.
#### Default
```dart
bool isValid = await FlutterNumberCaptcha.show(context);
// return true if entered number is right
// return false if dialog closed by user
```
#### Custom Property
```dart
bool isValid = await  FlutterNumberCaptcha.show(
	context,
	titleText: 'Enter correct number',
	placeholderText: 'Enter Number',
	checkCaption: 'Check',
);
// return true if entered number is right
// return false if dialog closed by user
```
## Contributing to this plugin[](https://pub.dev/packages/in_app_purchase#contributing-to-this-plugin)

If you would like to contribute to the plugin, check out our [contribution guide](https://github.com/flutter/plugins/blob/master/CONTRIBUTING.md).
