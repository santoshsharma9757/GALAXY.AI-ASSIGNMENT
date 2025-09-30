import 'package:flutter/material.dart';
import 'config/theme/app_theme.dart';
import 'core/utils/snackbar_utils.dart';
import 'features/home/presentation/screens/home_screen.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // Create a global key for ScaffoldMessenger
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = 
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    // Initialize toast with ScaffoldMessenger key
    ToastUtils.init(scaffoldMessengerKey);
    
    return MaterialApp(
      title: 'ChatGPT Clone',
      theme: AppTheme.lightTheme,
      scaffoldMessengerKey: scaffoldMessengerKey,
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
