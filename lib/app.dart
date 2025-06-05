import 'package:flutter/material.dart';
import 'package:vibe_vpn/core/app_theme.dart';

class VibeVpnApp extends StatelessWidget {
  const VibeVpnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Free Vpn',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: Scaffold(),
    );
  }
}
