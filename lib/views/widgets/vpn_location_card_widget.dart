import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibe_vpn/controllers/home_controller.dart';
import 'package:vibe_vpn/core/constants/app_size.dart';
import 'package:vibe_vpn/core/engine/vpn_engine.dart';
import 'package:vibe_vpn/core/models/vpn_info.dart';
import 'package:vibe_vpn/core/theme/app_theme.dart';
import 'package:vibe_vpn/data/local/app_preferences.dart';

class VpnLocationCardWidget extends StatelessWidget {
  const VpnLocationCardWidget({super.key, required this.vpnInfo});
  final VpnInfo vpnInfo;

  String formatSpeedBytes(int speedBytes, int decimal) {
    if (speedBytes <= 0) {
      return "0 B";
    }
    const suffixesTitle = ["Bps", "Kbps", "Mbps", "Gbps", "Tbps"];

    var speedTitleIndex = (log(speedBytes) / log(1024)).floor();

    return "${(speedBytes / pow(1024, speedTitleIndex)).toStringAsFixed(decimal)} ${suffixesTitle[speedTitleIndex]}";
  }

  @override
  Widget build(BuildContext context) {
    sizeScreen = MediaQuery.of(context).size;

    final homeController = Get.find<HomeController>();

    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(vertical: sizeScreen.height * .01),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          homeController.vpnInfo.value = vpnInfo;
          AppPreferences.vpnInfoObj = vpnInfo;
          Get.back();

          if (homeController.vpnConnectionState.value ==
              VpnEngine.vpnConnectedNow) {
            VpnEngine.stopVpnNow();
            Future.delayed(
              Duration(seconds: 3),
              () => homeController.connectToVpnNow(),
            );
          } else {
            homeController.connectToVpnNow();
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          leading: Container(
            padding: const EdgeInsets.all(0.5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Image.asset(
              "countryFlags/${vpnInfo.countryShortName.toLowerCase()}.png",
              height: 46,
              width: sizeScreen.width * 0.15,
              fit: BoxFit.cover,
            ),
          ),
          //Country name
          title: Text(vpnInfo.countryLongName),

          //vpn speed
          subtitle: Row(
            children: [
              Icon(Icons.shutter_speed, color: Colors.redAccent, size: 20),
              const SizedBox(width: 4),
              Text(
                formatSpeedBytes(vpnInfo.speed, 2),

                style: TextStyle(fontSize: 13),
              ),
            ],
          ),

          //number of sessions
          trailing: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                vpnInfo.vpnSessionNum.toString(),

                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).lightTextColor,
                ),
              ),
              const SizedBox(width: 4),
              Icon(CupertinoIcons.person_2_alt, color: Colors.redAccent),
            ],
          ),
        ),
      ),
    );
  }
}
