import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibe_vpn/controllers/home_controller.dart';
import 'package:vibe_vpn/core/constants/app_size.dart';
import 'package:vibe_vpn/core/engine/vpn_engine.dart';
import 'package:vibe_vpn/core/models/vpn_status.dart';
import 'package:vibe_vpn/data/local/app_preferences.dart';
import 'package:vibe_vpn/views/widgets/custom_widget.dart';
import 'package:vibe_vpn/views/widgets/select_bottom_nav.dart';

class VibeVpnHomeScreen extends StatelessWidget {
  VibeVpnHomeScreen({super.key});

  final homeController = Get.put<HomeController>(HomeController());

  @override
  Widget build(BuildContext context) {
    VpnEngine.snapshotVpnStage().listen((event) {
      homeController.vpnConnectionState.value = event;
    });
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
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomWidget(
                  titleText:
                      homeController.vpnInfo.value.countryLongName.isEmpty
                          ? "Location"
                          : homeController.vpnInfo.value.countryLongName,
                  subTitleText: "FREE",
                  widgetWithIcon: CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.redAccent,
                    backgroundImage:
                        homeController.vpnInfo.value.countryLongName.isEmpty
                            ? null
                            : AssetImage(
                              "countryFlags/${homeController.vpnInfo.value.countryShortName.toLowerCase()}.png",
                            ),
                    child:
                        homeController.vpnInfo.value.countryLongName.isEmpty
                            ? Icon(
                              Icons.flag_circle,
                              size: 30,
                              color: Colors.white,
                            )
                            : null,
                  ),
                ),

                CustomWidget(
                  titleText:
                      homeController.vpnInfo.value.countryLongName.isEmpty
                          ? "60 ms"
                          : "${homeController.vpnInfo.value.ping} ms",
                  subTitleText: "PING",
                  widgetWithIcon: CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.black54,
                    child: Icon(
                      Icons.graphic_eq,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          //! button vpn
          Obx(() => vpnRoundButton()),

          //another 2 round widget

          // download + upload
          StreamBuilder<VpnStatus?>(
            initialData: VpnStatus(),
            stream: VpnEngine.snapshotVpnStatus(),
            builder: (context, dataSnapshot) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomWidget(
                    titleText: dataSnapshot.data?.byteIn ?? "0 kbps",
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
                    titleText: dataSnapshot.data?.byteOut ?? "0 kbps",
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
              );
            },
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
            onTap: () {
              homeController.connectToVpnNow();
            },
            borderRadius: BorderRadius.circular(100),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: homeController.getRoundVpnButtonColor.withValues(
                  alpha: 0.1,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: homeController.getRoundVpnButtonColor.withValues(
                    alpha: 0.3,
                  ),
                ),
                child: Container(
                  height: sizeScreen.height * .14,
                  width: sizeScreen.height * .14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: homeController.getRoundVpnButtonColor,
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
                        homeController.getRoundVpnButonText,

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
