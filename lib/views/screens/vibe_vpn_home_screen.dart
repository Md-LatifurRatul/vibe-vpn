import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibe_vpn/core/constants/app_size.dart';
import 'package:vibe_vpn/data/local/app_preferences.dart';
import 'package:vibe_vpn/views/widgets/select_bottom_nav.dart';

class VibeVpnHomeScreen extends StatelessWidget {
  const VibeVpnHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    sizeScreen = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("Vibe VPN"),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.perm_device_info),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.changeThemeMode(
                AppPreferences.isModeDark ? ThemeMode.light : ThemeMode.dark,
              );
              AppPreferences.isModeDark = !AppPreferences.isModeDark;
            },
            icon: Icon(Icons.brightness_2_outlined),
          ),
        ],
      ),

      bottomNavigationBar: SelectBottomNav(),
    );
  }
}
