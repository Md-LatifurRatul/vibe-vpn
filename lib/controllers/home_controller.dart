import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibe_vpn/core/engine/vpn_engine.dart';
import 'package:vibe_vpn/core/models/vpn_configuration.dart';
import 'package:vibe_vpn/core/models/vpn_info.dart';
import 'package:vibe_vpn/data/local/app_preferences.dart';

class HomeController extends GetxController {
  final Rx<VpnInfo> vpnInfo = AppPreferences.vpnInfoObj.obs;

  final vpnConnectionState = VpnEngine.vpnDisConnectedNow.obs;

  Future<void> connectToVpnNow() async {
    if (vpnInfo.value.base64OpenVPNConfigurationData.isEmpty) {
      Get.snackbar(
        "Country / Location",
        "Please select country / location first",
      );
      return;
    }

    if (vpnConnectionState.value == VpnEngine.vpnDisConnectedNow) {
      final dataConfigVpn = Base64Decoder().convert(
        vpnInfo.value.base64OpenVPNConfigurationData,
      );
      final configuration = Utf8Decoder().convert(dataConfigVpn);
      final vpnConfiguration = VpnConfiguration(
        username: "vpn",
        password: "vpn",
        countryName: vpnInfo.value.countryLongName,
        config: configuration,
      );

      await VpnEngine.startVpnNow(vpnConfiguration);
    } else {
      await VpnEngine.stopVpnNow();
    }
  }

  Color get getRoundVpnButtonColor {
    switch (vpnConnectionState.value) {
      case VpnEngine.vpnDisConnectedNow:
        return Colors.redAccent;
      case VpnEngine.vpnConnectedNow:
        return Colors.green;

      default:
        return Colors.orangeAccent;
    }
  }

  String get getRoundVpnButonText {
    switch (vpnConnectionState.value) {
      case VpnEngine.vpnDisConnectedNow:
        return "Let's Connect";
      case VpnEngine.vpnConnectedNow:
        return "Disconnect";

      default:
        return "Connecting...";
    }
  }
}
