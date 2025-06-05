import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibe_vpn/core/theme/app_theme.dart';
import 'package:vibe_vpn/data/local/app_preferences.dart';
import 'package:vibe_vpn/views/screens/vibe_vpn_home_screen.dart';

class VibeVpnApp extends StatelessWidget {
  const VibeVpnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Free Vpn',
      theme: AppThemeData.lightTheme,
      darkTheme: AppThemeData.darkTheme,
      themeMode: AppPreferences.isModeDark ? ThemeMode.dark : ThemeMode.light,
      home: VibeVpnHomeScreen(),
    );
  }
}
