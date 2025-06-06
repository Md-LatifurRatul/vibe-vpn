import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:vibe_vpn/core/models/ip_info.dart';
import 'package:vibe_vpn/core/models/vpn_info.dart';
import 'package:vibe_vpn/data/local/app_preferences.dart';
import 'package:vibe_vpn/utils/api_vpn.dart';

class ApiVpnGate {
  static Future<List<VpnInfo>> retrieveAllAvailableFreevpnServers() async {
    final List<VpnInfo> vpnServersList = [];

    try {
      final responseFromApi = await http.get(Uri.parse(ApiVpn.vpnApi));
      final commaSeparatedValueString = responseFromApi.body
          .split("#")[1]
          .replaceAll("*", "");
      List<List<dynamic>> listData = const CsvToListConverter().convert(
        commaSeparatedValueString,
      );
      final header = listData[0];

      for (int counter = 1; counter < listData.length - 1; counter++) {
        Map<String, dynamic> jsonData = {};

        for (
          int innerCounter = 1;
          innerCounter < header.length;
          innerCounter++
        ) {
          jsonData.addAll({
            header[innerCounter].toString(): listData[counter][innerCounter],
          });
        }

        vpnServersList.add(VpnInfo.fromJson(jsonData));
      }
    } catch (e) {
      Get.snackbar(
        'Error Occured',
        e.toString(),

        colorText: Colors.white,
        backgroundColor: Colors.redAccent.withValues(alpha: 0.8),
      );
    }
    vpnServersList.shuffle();
    if (vpnServersList.isNotEmpty) AppPreferences.vpnList = vpnServersList;

    return vpnServersList;
  }

  static Future<void> retrieveIPDetails({
    required Rx<IpInfo> ipInformation,
  }) async {
    try {
      final responseFromApi = await http.get(Uri.parse(ApiVpn.vpnIP));

      final dataFromApi = jsonDecode(responseFromApi.body);

      ipInformation.value = IpInfo.fromJson(dataFromApi);
    } catch (e) {
      Get.snackbar(
        'Error Occured Retrieve IP',
        e.toString(),

        colorText: Colors.white,
        backgroundColor: Colors.redAccent.withValues(alpha: 0.8),
      );
    }
  }
}
