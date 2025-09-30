# 🎉 Alerts - Custom Alert Dialogs for Flutter

A powerful and flexible Flutter package that provides highly customizable alert dialogs with themes, animations, multiple buttons, and input fields. Perfect for enhancing user interactions in your Flutter applications! 🚀

![Pub Likes](https://img.shields.io/pub/likes/alerts)
![Pub Points](https://img.shields.io/pub/points/alerts)
![Pub Monthly Downloads](https://img.shields.io/pub/dm/alerts)
![GitHub Issues](https://img.shields.io/github/issues/rohit-chouhan/alerts-flutter)
![GitHub PRs](https://img.shields.io/github/issues-pr/rohit-chouhan/alerts-flutter)
![GitHub Forks](https://img.shields.io/github/forks/rohit-chouhan/alerts-flutter)

![screenshot](/images/screenshot.gif)

## ✨ Features

- 🎨 **Customizable Themes**: Easily customize colors, borders, padding, and more
- 🎭 **Multiple Animations**: Choose from fade, slide (up/left/right), scale, bounce, rotate, or no animation
- 🔘 **Flexible Buttons**: Support for multiple buttons with custom styles and text colors
- 📝 **Input Fields**: Integrated text input fields with various keyboard types
- ⏰ **Auto-Close**: Automatically close dialogs after a specified duration
- 🌐 **Global Configuration**: Set default themes, animations, and behaviors app-wide
- 📱 **Responsive Design**: Works seamlessly across different screen sizes
- 🛠️ **Easy Integration**: Simple API similar to Flutter's built-in dialogs

## 🚀 Quick Start

Import the package:

```dart
import 'package:alerts/alerts.dart';
```

### Basic Alert Dialog

```dart
Alerts.show(
  context,
  title: 'Hello World! 🌍',
  content: 'This is a basic alert dialog.',
  buttons: [
    AlertButton(
      label: 'OK',
      onPressed: () => Navigator.of(context).pop(),
    ),
  ],
);
```

### Advanced Alert with Multiple Buttons and Input

```dart
Alerts.show(
  context,
  title: 'User Input Required 📝',
  content: 'Please enter your name and email.',
  inputFields: [
    AlertInputField(hintText: 'Name'),
    AlertInputField(hintText: 'Email', keyboardType: TextInputType.emailAddress),
  ],
  buttons: [
    AlertButton(
      label: 'Cancel',
      onPressed: () => Navigator.of(context).pop(),
      backgroundColor: Colors.grey,
    ),
    AlertButton(
      label: 'Submit',
      onPressed: () {
        // Handle submission
        Navigator.of(context).pop();
      },
      backgroundColor: Colors.blue,
    ),
  ],
  theme: AlertTheme(
    backgroundColor: Colors.white,
    borderRadius: BorderRadius.circular(16.0),
  ),
  animation: AlertAnimation.scale,
);
```

## 📚 API Reference

### `Alerts.show<T>`

The main function to display a custom alert dialog.

| Parameter | Type | Description | Default |
|-----------|------|-------------|---------|
| `context` | `BuildContext` | The build context | Required |
| `title` | `String?` | Dialog title | `null` |
| `content` | `String?` | Dialog content text | `null` |
| `contentWidget` | `Widget?` | Custom content widget | `null` |
| `buttons` | `List<AlertButton>` | List of action buttons | `[]` |
| `inputFields` | `List<AlertInputField>` | List of input fields | `[]` |
| `theme` | `AlertTheme?` | Dialog theme configuration | `null` |
| `animation` | `AlertAnimation` | Entrance animation type | `AlertAnimation.fade` |
| `animationDuration` | `Duration` | Animation duration | `300ms` |
| `barrierDismissible` | `bool` | Dismiss on barrier tap | `true` |
| `autoCloseDuration` | `Duration?` | Auto-close duration | `null` |

### `AlertButton`

Represents a button in the alert dialog.

| Property | Type | Description |
|----------|------|-------------|
| `label` | `String` | Button text |
| `onPressed` | `VoidCallback?` | Press callback |
| `textStyle` | `TextStyle?` | Text styling |
| `backgroundColor` | `Color?` | Button background color |

### `AlertInputField`

Represents an input field in the dialog.

| Property | Type | Description | Default |
|----------|------|-------------|---------|
| `hintText` | `String` | Input hint text | Required |
| `controller` | `TextEditingController?` | Text controller | `null` |
| `obscureText` | `bool` | Hide input text | `false` |
| `keyboardType` | `TextInputType` | Keyboard type | `TextInputType.text` |

### `AlertTheme`

Theme configuration for the dialog.

| Property | Type | Description |
|----------|------|-------------|
| `backgroundColor` | `Color?` | Dialog background |
| `titleColor` | `Color?` | Title text color |
| `contentColor` | `Color?` | Content text color |
| `borderRadius` | `BorderRadius?` | Dialog border radius |
| `padding` | `EdgeInsets?` | Internal padding |

### `AlertAnimation`

Animation types for dialog appearance.

- `none`: No animation
- `fade`: Fade in effect
- `slideUp`: Slide from bottom
- `slideLeft`: Slide from left
- `slideRight`: Slide from right
- `scale`: Scale animation
- `bounce`: Bounce animation
- `rotate`: Rotate animation

### `AlertConfig`

Global configuration class for setting default behaviors.

| Property | Type | Description |
|----------|------|-------------|
| `defaultTheme` | `AlertTheme?` | Default theme for all alerts |
| `defaultAnimation` | `AlertAnimation` | Default animation type |
| `defaultAnimationDuration` | `Duration` | Default animation duration |
| `defaultAutoCloseDuration` | `Duration?` | Default auto-close duration |
| `defaultBarrierDismissible` | `bool` | Default barrier dismissible |

## 🎨 Customization Examples

### Dark Theme Alert

```dart
Alerts.show(
  context,
  title: 'Dark Mode Alert 🌙',
  content: 'This alert uses a dark theme.',
  theme: AlertTheme(
    backgroundColor: Colors.grey[900],
    titleColor: Colors.white,
    contentColor: Colors.white70,
    borderRadius: BorderRadius.circular(12.0),
  ),
  buttons: [
    AlertButton(
      label: 'Got it!',
      onPressed: () => Navigator.of(context).pop(),
      backgroundColor: Colors.blueAccent,
    ),
  ],
);
```

### Animated Alert with Custom Content

```dart
Alerts.show(
  context,
  contentWidget: Column(
    children: [
      Icon(Icons.warning, size: 48, color: Colors.orange),
      SizedBox(height: 16),
      Text('Custom content with icon!'),
    ],
  ),
  animation: AlertAnimation.slideUp,
  buttons: [
    AlertButton(label: 'Dismiss', onPressed: () => Navigator.of(context).pop()),
  ],
);
```

### Auto-Close Alert

```dart
Alerts.show(
  context,
  title: 'Success!',
  content: 'Operation completed successfully.',
  autoCloseDuration: Duration(seconds: 3), // Closes after 3 seconds
  buttons: [
    AlertButton(
      label: 'Close Now',
      onPressed: () => Navigator.of(context).pop(),
    ),
  ],
);
```

### Global Configuration

```dart
// Set global defaults
AlertConfig.defaultTheme = AlertTheme(
  backgroundColor: Colors.grey[900],
  titleColor: Colors.white,
  borderRadius: BorderRadius.circular(16.0),
);

AlertConfig.defaultAnimation = AlertAnimation.bounce;
AlertConfig.defaultAutoCloseDuration = Duration(seconds: 5);

// Now all alerts will use these defaults unless overridden
Alerts.show(
  context,
  title: 'Configured Alert',
  content: 'This uses global configuration.',
);
```

## 🤝 Contributors

Have you found a bug or have a suggestion of how to enhance Alerts Package? Open an issue or pull request and we will take a look at it as soon as possible.

## 🐛 Report bugs or issues

You are welcome to open a _[ticket](https://github.com/rohit-chouhan/alerts-flutter/issues)_ on github if any problems arise. New ideas are always welcome.

## 📄 Copyright and License

> Copyright © 2025 **[Rohit Chouhan](https://rohitchouhan.com)**. Licensed under the _[MIT LICENSE](https://github.com/rohit-chouhan/alerts-flutter/blob/main/LICENSE)_.
---

Made with ❤️ for the Flutter community!
