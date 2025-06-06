import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:vibe_vpn/core/models/vpn_configuration.dart';
import 'package:vibe_vpn/core/models/vpn_status.dart';

class VpnEngine {
  static final String eventChannelVpnStage = "vpnStage";
  static final String eventChannelVpnStatus = "vpnStatus";
  static final String methonChannelVpnControl = "vpnControl";

  //vpn connection stage snapshot

  static Stream<String> snapshotVpnStage() =>
      EventChannel(eventChannelVpnStage).receiveBroadcastStream().cast();

  // vpn connection status snapshot

  static Stream<VpnStatus?> snapshotVpnStatus() =>
      EventChannel(eventChannelVpnStatus)
          .receiveBroadcastStream()
          .map((eventStatus) => VpnStatus.fromJson(jsonDecode(eventStatus)))
          .cast();

  static Future<void> startVpnNow(VpnConfiguration vpnConfiguration) {
    return MethodChannel(methonChannelVpnControl).invokeMethod("start", {
      "config": vpnConfiguration.config,
      "country": vpnConfiguration.countryName,
      "username": vpnConfiguration.username,
      "password": vpnConfiguration.password,
    });
  }

  static Future<void> stopVpnNow() {
    return MethodChannel(methonChannelVpnControl).invokeMethod("stop");
  }

  static Future<void> killSwitchOpenNow() {
    return MethodChannel(methonChannelVpnControl).invokeMethod("kill_switch");
  }

  static Future<void> refreshStageNow() {
    return MethodChannel(methonChannelVpnControl).invokeMethod("refresh");
  }

  static Future<String?> getStageNow() {
    return MethodChannel(methonChannelVpnControl).invokeMethod("stage");
  }

  static Future<bool> isConnectedNow() {
    return getStageNow().then(
      (valueStage) => valueStage!.toLowerCase() == "connected",
    );
  }

  // stages of vpn connection

  static const String vpnConnectedNow = "connected";
  static const String vpnDisConnectedNow = "disconnected";
  static const String vpnWaitConnectionNow = "wait_connection";
  static const String vpnAuthenticationNow = "authenticating";
  static const String vpnReConnectNow = "reconnected";
  static const String vpnNoConnectionNow = "no_connected";
  static const String vpnConnectingNow = "connecting";
  static const String vpnPrepareNow = "prepare";
  static const String vpnDeniedNow = "denied";
}
