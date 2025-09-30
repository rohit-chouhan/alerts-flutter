import 'package:flutter/material.dart';
import 'package:flutter_alerts/flutter_alerts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alerts Package Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alerts Package Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              '🎉 Welcome to Alerts Package Demo!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              'Tap the buttons below to see different alert dialog examples:',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            _buildDemoButton(
              context,
              'Basic Alert',
              'Simple alert with title and message',
              () => _showBasicAlert(context),
            ),
            _buildDemoButton(
              context,
              'Alert with Buttons',
              'Alert with multiple action buttons',
              () => _showAlertWithButtons(context),
            ),
            _buildDemoButton(
              context,
              'Alert with Input Fields',
              'Alert containing text input fields',
              () => _showAlertWithInputs(context),
            ),
            _buildDemoButton(
              context,
              'Custom Themed Alert',
              'Alert with custom colors and styling',
              () => _showCustomThemedAlert(context),
            ),
            _buildDemoButton(
              context,
              'Animated Alert (Scale)',
              'Alert with scale animation',
              () => _showAnimatedAlert(context, AlertAnimation.scale),
            ),
            _buildDemoButton(
              context,
              'Animated Alert (Slide)',
              'Alert with slide up animation',
              () => _showAnimatedAlert(context, AlertAnimation.slideUp),
            ),
            _buildDemoButton(
              context,
              'Alert with Custom Content',
              'Alert with custom widget content',
              () => _showCustomContentAlert(context),
            ),
            _buildDemoButton(
              context,
              'Auto-Close Alert',
              'Alert that closes automatically after 3 seconds',
              () => _showAutoCloseAlert(context),
            ),
            _buildDemoButton(
              context,
              'Bounce Animation',
              'Alert with bounce animation',
              () => _showAnimatedAlert(context, AlertAnimation.bounce),
            ),
            _buildDemoButton(
              context,
              'Rotate Animation',
              'Alert with rotate animation',
              () => _showAnimatedAlert(context, AlertAnimation.rotate),
            ),
            _buildDemoButton(
              context,
              'Slide Left Animation',
              'Alert with slide left animation',
              () => _showAnimatedAlert(context, AlertAnimation.slideLeft),
            ),
            _buildDemoButton(
              context,
              'Slide Right Animation',
              'Alert with slide right animation',
              () => _showAnimatedAlert(context, AlertAnimation.slideRight),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDemoButton(
    BuildContext context,
    String title,
    String subtitle,
    VoidCallback onPressed,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onPressed,
      ),
    );
  }

  void _showBasicAlert(BuildContext context) {
    Alerts.show(
      context,
      title: 'Hello World! 🌍',
      content: 'This is a basic alert dialog with title and content.',
      buttons: [
        AlertButton(label: 'OK', onPressed: () => Navigator.of(context).pop()),
      ],
    );
  }

  void _showAlertWithButtons(BuildContext context) {
    Alerts.show(
      context,
      title: 'Choose Action',
      content: 'What would you like to do?',
      buttons: [
        AlertButton(
          label: 'Cancel',
          onPressed: () => Navigator.of(context).pop(),
          backgroundColor: Colors.grey,
          textStyle: const TextStyle(color: Colors.white),
        ),
        AlertButton(
          label: 'Delete',
          onPressed: () {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Delete action performed')),
            );
          },
          backgroundColor: Colors.red,
          textStyle: const TextStyle(color: Colors.white),
        ),
        AlertButton(
          label: 'Save',
          onPressed: () {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Save action performed')),
            );
          },
          backgroundColor: Colors.green,
          textStyle: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  void _showAlertWithInputs(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();

    Alerts.show(
      context,
      title: 'User Information 📝',
      content: 'Please enter your details:',
      inputFields: [
        AlertInputField(hintText: 'Full Name', controller: nameController),
        AlertInputField(
          hintText: 'Email Address',
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
        ),
      ],
      buttons: [
        AlertButton(
          label: 'Cancel',
          onPressed: () => Navigator.of(context).pop(),
          backgroundColor: Colors.grey,
          textStyle: const TextStyle(color: Colors.white),
        ),
        AlertButton(
          label: 'Submit',
          onPressed: () {
            final name = nameController.text;
            final email = emailController.text;
            Navigator.of(context).pop();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Submitted: $name, $email')));
          },
          backgroundColor: Colors.blue,
          textStyle: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  void _showCustomThemedAlert(BuildContext context) {
    Alerts.show(
      context,
      title: 'Dark Mode Alert 🌙',
      content: 'This alert uses a custom dark theme with rounded corners.',
      theme: AlertTheme(
        backgroundColor: Colors.grey[900],
        titleColor: Colors.white,
        contentColor: Colors.white70,
        borderRadius: BorderRadius.circular(16.0),
        padding: const EdgeInsets.all(24.0),
      ),
      buttons: [
        AlertButton(
          label: 'Got it!',
          onPressed: () => Navigator.of(context).pop(),
          backgroundColor: Colors.blueAccent,
          textStyle: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  void _showAnimatedAlert(BuildContext context, AlertAnimation animation) {
    String animationName;
    switch (animation) {
      case AlertAnimation.none:
        animationName = 'No';
        break;
      case AlertAnimation.fade:
        animationName = 'Fade';
        break;
      case AlertAnimation.slideUp:
        animationName = 'Slide Up';
        break;
      case AlertAnimation.slideLeft:
        animationName = 'Slide Left';
        break;
      case AlertAnimation.slideRight:
        animationName = 'Slide Right';
        break;
      case AlertAnimation.scale:
        animationName = 'Scale';
        break;
      case AlertAnimation.bounce:
        animationName = 'Bounce';
        break;
      case AlertAnimation.rotate:
        animationName = 'Rotate';
        break;
    }
    Alerts.show(
      context,
      title: '$animationName Animation 🎭',
      content: 'This alert uses $animationName animation for entrance.',
      animation: animation,
      buttons: [
        AlertButton(
          label: 'Cool!',
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  void _showCustomContentAlert(BuildContext context) {
    Alerts.show(
      context,
      contentWidget: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            size: 48,
            color: Colors.orange,
          ),
          const SizedBox(height: 16),
          const Text(
            'Custom Content Alert!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'This alert uses a custom content widget instead of simple text.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'You can put any widget here!',
              style: TextStyle(color: Colors.blue),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      buttons: [
        AlertButton(
          label: 'Dismiss',
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  void _showAutoCloseAlert(BuildContext context) {
    Alerts.show(
      context,
      title: 'Auto-Close Alert ⏰',
      content: 'This alert will close automatically in 3 seconds.',
      autoCloseDuration: const Duration(seconds: 3),
      buttons: [
        AlertButton(
          label: 'Close Now',
          onPressed: () => Navigator.of(context).pop(),
          backgroundColor: Colors.red,
          textStyle: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
