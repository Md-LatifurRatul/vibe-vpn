import 'package:get/get.dart';
import 'package:vibe_vpn/core/models/vpn_info.dart';
import 'package:vibe_vpn/data/local/app_preferences.dart';

class HomeController extends GetxController {
  final Rx<VpnInfo> vpnInfo = AppPreferences.vpnInfoObj.obs;
}
