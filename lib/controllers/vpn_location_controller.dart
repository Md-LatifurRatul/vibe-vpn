import 'package:get/get.dart';
import 'package:vibe_vpn/core/models/vpn_info.dart';
import 'package:vibe_vpn/data/local/app_preferences.dart';
import 'package:vibe_vpn/data/remote/api_vpn_gate.dart';

class VpnLocationController extends GetxController {
  List<VpnInfo> vpnFreeServerAvailableList = AppPreferences.vpnList;
  final RxBool isLoadingNewLocations = false.obs;

  Future<void> retrieveVpnInformation() async {
    isLoadingNewLocations.value = true;

    vpnFreeServerAvailableList.clear();

    vpnFreeServerAvailableList =
        await ApiVpnGate.retrieveAllAvailableFreevpnServers();

    isLoadingNewLocations.value = false;
  }
}
