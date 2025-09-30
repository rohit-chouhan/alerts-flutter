import 'dart:async';

import 'package:flutter/material.dart';

/// Global configuration for alerts package.
class AlertConfig {
  /// Default theme for all alerts.
  static AlertTheme? defaultTheme;

  /// Default animation for all alerts.
  static AlertAnimation defaultAnimation = AlertAnimation.fade;

  /// Default animation duration for all alerts.
  static Duration defaultAnimationDuration = const Duration(milliseconds: 300);

  /// Default auto-close duration for all alerts.
  static Duration? defaultAutoCloseDuration;

  /// Default barrier dismissible for all alerts.
  static bool defaultBarrierDismissible = true;

  /// Reset all configurations to defaults.
  static void reset() {
    defaultTheme = null;
    defaultAnimation = AlertAnimation.fade;
    defaultAnimationDuration = const Duration(milliseconds: 300);
    defaultAutoCloseDuration = null;
    defaultBarrierDismissible = true;
  }
}

/// Represents a button in the alert dialog.
class AlertButton {
  /// The text label for the button.
  final String label;

  /// The callback function when the button is pressed.
  final VoidCallback? onPressed;

  /// The style for the button text.
  final TextStyle? textStyle;

  /// The background color of the button.
  final Color? backgroundColor;

  /// Creates an [AlertButton].
  ///
  /// [label] is required and displayed on the button.
  /// [onPressed] is called when the button is tapped. If null, the button is disabled.
  /// [textStyle] customizes the button text appearance.
  /// [backgroundColor] sets the button's background color.
  const AlertButton({
    required this.label,
    this.onPressed,
    this.textStyle,
    this.backgroundColor,
  });
}

/// Represents an input field in the alert dialog.
class AlertInputField {
  /// The hint text for the input field.
  final String hintText;

  /// The controller for the input field.
  final TextEditingController? controller;

  /// Whether the input field is obscured (for passwords).
  final bool obscureText;

  /// The keyboard type for the input field.
  final TextInputType keyboardType;

  /// Creates an [AlertInputField].
  ///
  /// [hintText] provides a hint to the user.
  /// [controller] manages the text input. If null, a new controller is created.
  /// [obscureText] hides the input text if true.
  /// [keyboardType] specifies the type of keyboard to show.
  const AlertInputField({
    required this.hintText,
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });
}

/// Theme configuration for the custom alert dialog.
class AlertTheme {
  /// The background color of the dialog.
  final Color? backgroundColor;

  /// The color of the title text.
  final Color? titleColor;

  /// The color of the content text.
  final Color? contentColor;

  /// The border radius of the dialog.
  final BorderRadius? borderRadius;

  /// The padding inside the dialog.
  final EdgeInsets? padding;

  /// Creates an [AlertTheme].
  ///
  /// All properties are optional and will use default values if not provided.
  const AlertTheme({
    this.backgroundColor,
    this.titleColor,
    this.contentColor,
    this.borderRadius,
    this.padding,
  });
}

/// Animation type for the dialog appearance.
enum AlertAnimation {
  /// No animation.
  none,

  /// Fade in animation.
  fade,

  /// Slide from bottom animation.
  slideUp,

  /// Slide from left animation.
  slideLeft,

  /// Slide from right animation.
  slideRight,

  /// Scale animation.
  scale,

  /// Bounce animation.
  bounce,

  /// Rotate animation.
  rotate,
}

/// A customizable alert dialog widget.
class CustomAlertDialog extends StatefulWidget {
  /// The title of the dialog.
  final String? title;

  /// The content text of the dialog.
  final String? content;

  /// A custom content widget. If provided, [content] is ignored.
  final Widget? contentWidget;

  /// List of buttons to display in the dialog.
  final List<AlertButton> buttons;

  /// List of input fields to include in the dialog.
  final List<AlertInputField> inputFields;

  /// The theme configuration for the dialog.
  final AlertTheme? theme;

  /// The animation type for the dialog.
  final AlertAnimation animation;

  /// The duration of the animation.
  final Duration animationDuration;

  /// The duration after which the dialog auto-closes. If null, no auto-close.
  final Duration? autoCloseDuration;

  /// Creates a [CustomAlertDialog].
  ///
  /// [title] and [content] are optional text displays.
  /// [contentWidget] allows custom content layout.
  /// [buttons] define the actions available.
  /// [inputFields] add text input capabilities.
  /// [theme] customizes the visual appearance.
  /// [animation] specifies the entrance animation.
  /// [animationDuration] sets the animation length.
  const CustomAlertDialog({
    super.key,
    this.title,
    this.content,
    this.contentWidget,
    this.buttons = const [],
    this.inputFields = const [],
    this.theme,
    this.animation = AlertAnimation.fade,
    this.animationDuration = const Duration(milliseconds: 300),
    this.autoCloseDuration,
  });

  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  Timer? _autoCloseTimer;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _setupAnimation();
    _animationController.forward();

    if (widget.autoCloseDuration != null) {
      _autoCloseTimer = Timer(widget.autoCloseDuration!, () {
        if (mounted) {
          Navigator.of(context).pop();
        }
      });
    }
  }

  void _setupAnimation() {
    switch (widget.animation) {
      case AlertAnimation.none:
        _animation = AlwaysStoppedAnimation(1.0);
        break;
      case AlertAnimation.fade:
        _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
        );
        break;
      case AlertAnimation.slideUp:
        _animation = Tween<double>(begin: 50.0, end: 0.0).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );
        break;
      case AlertAnimation.slideLeft:
        _animation = Tween<double>(begin: -50.0, end: 0.0).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );
        break;
      case AlertAnimation.slideRight:
        _animation = Tween<double>(begin: 50.0, end: 0.0).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );
        break;
      case AlertAnimation.scale:
        _animation = Tween<double>(begin: 0.8, end: 1.0).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.elasticOut,
          ),
        );
        break;
      case AlertAnimation.bounce:
        _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.bounceOut,
          ),
        );
        break;
      case AlertAnimation.rotate:
        _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );
        break;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _autoCloseTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? const AlertTheme();
    final defaultTheme = Theme.of(context);

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        Widget dialog = Dialog(
          backgroundColor:
              theme.backgroundColor ?? defaultTheme.dialogTheme.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: theme.borderRadius ?? BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: theme.padding ?? const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (widget.title != null) ...[
                  Text(
                    widget.title!,
                    style: defaultTheme.textTheme.headlineSmall?.copyWith(
                      color:
                          theme.titleColor ??
                          defaultTheme.textTheme.headlineSmall?.color,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8.0),
                ],
                if (widget.contentWidget != null)
                  widget.contentWidget!
                else if (widget.content != null) ...[
                  Text(
                    widget.content!,
                    style: defaultTheme.textTheme.bodyMedium?.copyWith(
                      color:
                          theme.contentColor ??
                          defaultTheme.textTheme.bodyMedium?.color,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16.0),
                ],
                ...widget.inputFields.map(
                  (field) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: TextField(
                      controller: field.controller,
                      obscureText: field.obscureText,
                      keyboardType: field.keyboardType,
                      decoration: InputDecoration(
                        hintText: field.hintText,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                if (widget.buttons.isNotEmpty) ...[
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: widget.buttons.map((button) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: ElevatedButton(
                          onPressed: button.onPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: button.backgroundColor,
                            foregroundColor: button.textStyle?.color,
                            textStyle: button.textStyle?.copyWith(color: null),
                          ),
                          child: Text(button.label),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ],
            ),
          ),
        );

        switch (widget.animation) {
          case AlertAnimation.none:
            return dialog;
          case AlertAnimation.fade:
            return Opacity(opacity: _animation.value, child: dialog);
          case AlertAnimation.slideUp:
            return Transform.translate(
              offset: Offset(0, _animation.value),
              child: dialog,
            );
          case AlertAnimation.slideLeft:
            return Transform.translate(
              offset: Offset(_animation.value, 0),
              child: dialog,
            );
          case AlertAnimation.slideRight:
            return Transform.translate(
              offset: Offset(-_animation.value, 0),
              child: dialog,
            );
          case AlertAnimation.scale:
            return Transform.scale(scale: _animation.value, child: dialog);
          case AlertAnimation.bounce:
            return Transform.scale(
              scale: 0.8 + (_animation.value * 0.2),
              child: dialog,
            );
          case AlertAnimation.rotate:
            return Transform.rotate(
              angle: (1 - _animation.value) * 0.1,
              child: dialog,
            );
        }
      },
    );
  }
}

/// A Flutter package for highly customizable alert dialogs with themes, animations, multiple buttons, input fields, auto-close, and global configuration.
///
/// This package provides [CustomAlertDialog] widget and [Alerts.show] method
/// to display alert dialogs with enhanced customization options beyond the standard Flutter AlertDialog.
///
/// ## Features
/// - Customizable themes and styling
/// - Multiple buttons support with custom colors and text styles
/// - Input fields integration
/// - Various animation options (fade, slide, scale, bounce, rotate)
/// - Auto-close functionality
/// - Global configuration system
/// - Flexible content layout
///
/// ## Example
/// ```dart
/// showCustomAlertDialog(
///   context,
///   title: 'Confirm Action',
///   content: 'Are you sure you want to proceed?',
///   buttons: [
///     AlertButton(label: 'Cancel', onPressed: () => Navigator.of(context).pop()),
///     AlertButton(label: 'OK', onPressed: () => print('Confirmed')),
///   ],
/// );
/// ```
///
/// A utility class for displaying custom alert dialogs.
class Alerts {
  /// Shows a custom alert dialog.
  ///
  /// Returns a [Future] that completes when the dialog is dismissed.
  /// The future resolves to the value passed to [Navigator.pop] if any.
  ///
  /// [context] is required to show the dialog.
  /// [title] is the dialog title.
  /// [content] is the dialog content text.
  /// [contentWidget] allows custom content.
  /// [buttons] define the dialog actions.
  /// [inputFields] add input capabilities.
  /// [theme] customizes appearance.
  /// [animation] specifies entrance animation.
  /// [barrierDismissible] whether tapping outside dismisses the dialog.
  /// [autoCloseDuration] duration after which dialog auto-closes.
  static Future<T?> show<T>(
    BuildContext context, {
    String? title,
    String? content,
    Widget? contentWidget,
    List<AlertButton> buttons = const [],
    List<AlertInputField> inputFields = const [],
    AlertTheme? theme,
    AlertAnimation? animation,
    Duration? animationDuration,
    bool? barrierDismissible,
    Duration? autoCloseDuration,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible:
          barrierDismissible ?? AlertConfig.defaultBarrierDismissible,
      builder: (context) => CustomAlertDialog(
        title: title,
        content: content,
        contentWidget: contentWidget,
        buttons: buttons,
        inputFields: inputFields,
        theme: theme ?? AlertConfig.defaultTheme,
        animation: animation ?? AlertConfig.defaultAnimation,
        animationDuration:
            animationDuration ?? AlertConfig.defaultAnimationDuration,
        autoCloseDuration:
            autoCloseDuration ?? AlertConfig.defaultAutoCloseDuration,
      ),
    );
  }
}

/// @deprecated Use Alerts.show instead.
Future<T?> showCustomAlertDialog<T>(
  BuildContext context, {
  String? title,
  String? content,
  Widget? contentWidget,
  List<AlertButton> buttons = const [],
  List<AlertInputField> inputFields = const [],
  AlertTheme? theme,
  AlertAnimation? animation,
  Duration? animationDuration,
  bool? barrierDismissible,
  Duration? autoCloseDuration,
}) {
  return Alerts.show<T>(
    context,
    title: title,
    content: content,
    contentWidget: contentWidget,
    buttons: buttons,
    inputFields: inputFields,
    theme: theme,
    animation: animation,
    animationDuration: animationDuration,
    barrierDismissible: barrierDismissible,
    autoCloseDuration: autoCloseDuration,
  );
}
