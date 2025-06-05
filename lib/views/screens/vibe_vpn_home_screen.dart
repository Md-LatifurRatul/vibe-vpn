import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibe_vpn/core/constants/app_size.dart';
import 'package:vibe_vpn/data/local/app_preferences.dart';
import 'package:vibe_vpn/views/widgets/custom_widget.dart';
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: [
          //! 2 rounded widget
          // Location + ping
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomWidget(
                titleText: "Location",
                subTitleText: "FREE",
                widgetWithIcon: CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.redAccent,
                  child: Icon(Icons.flag_circle, size: 30, color: Colors.white),
                ),
              ),

              CustomWidget(
                titleText: "60 ms",
                subTitleText: "ping",
                widgetWithIcon: CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.black54,
                  child: Icon(Icons.graphic_eq, size: 30, color: Colors.white),
                ),
              ),
            ],
          ),

          //! button vpn
          vpnRoundButton(),

          //another 2 round widget

          // download + upload
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomWidget(
                titleText: "0 kbps",
                subTitleText: "DOWNLOAD",
                widgetWithIcon: CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.arrow_circle_down,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),

              CustomWidget(
                titleText: "0 kbps",
                subTitleText: "UPLOAD",
                widgetWithIcon: CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.purpleAccent,
                  child: Icon(
                    Icons.arrow_circle_up_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget vpnRoundButton() {
    return Column(
      children: [
        Semantics(
          button: true,
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(100),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
                child: Container(
                  height: sizeScreen.height * .14,
                  width: sizeScreen.width * .14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.pink,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.power_settings_new,
                        size: 30,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Tap to Connect",

                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
