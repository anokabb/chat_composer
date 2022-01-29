# chat_composer

[pub package](https://pub.dartlang.org/packages/chat_composer)

<p><br/>
<a href="https://www.buymeacoffee.com/anokab" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-green.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>
</p> 
<br/>

A Flutter package for easy implementation of chat composer.

![Gif](https://github.com/anokabb/chat_composer/blob/main/assets/example.gif "Fancy Gif")

## Setup

### Android

**Permissions**

```
    ...
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.RECORD_AUDIO" />
    ...
   <application
```

**AndroidX**

1. Add the following to your "gradle.properties" file:

```
android.useAndroidX=true
android.enableJetifier=true
```

2. Make sure you set the `compileSdkVersion` in your "android/app/build.gradle" file to 31:

```
android {
  compileSdkVersion 31
  ...
}
```

3. Make sure you replace all the `android.` dependencies to their AndroidX counterparts (a full list can be found here: https://developer.android.com/jetpack/androidx/migrate ).

### Add dependency

```yaml
dependencies:
  chat_composer: ^1.0.0 #latest version
```

### Import

```dart
import 'package:chat_composer/chat_composer.dart';
```

### Easy to use

```dart
ChatComposer(
    onReceiveText: (str) {
    print('TEXT : ' + str!);
    },
    onRecordEnd: (path) {
    print('AUDIO PATH : ' + path!);
    },
)
```

### Attributes

`leading`: A widget to display before the [TextField].\
`actions`: A list of Widgets to display in a row after the [TextField] widget.\
`onReceiveText`: A callback when submit Text Message.\
`onRecordStart`: A callback when start recording.\
`onRecordEnd`: A callback when end recording, return the recorder audio path.\
`onRecordCancel`: A callback when cancel recording.\
`onPanCancel`: A callback when the user does not lock the recording or does not hold.\
`maxRecordLength`: Audio max duration should record then return recorder audio path.\
