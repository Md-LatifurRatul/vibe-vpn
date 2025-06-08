import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:vibe_vpn/controllers/vpn_location_controller.dart';
import 'package:vibe_vpn/views/widgets/vpn_location_card_widget.dart';

class AvailableServersLocationsScreen extends StatelessWidget {
  AvailableServersLocationsScreen({super.key});

  final vpnLocationController = VpnLocationController();

  @override
  Widget build(BuildContext context) {
    if (vpnLocationController.vpnFreeServerAvailableList.isEmpty) {
      vpnLocationController.retrieveVpnInformation();
    }

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text(
            "VPN Locations ${vpnLocationController.vpnFreeServerAvailableList.length} ",
          ),
        ),

        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10, right: 10),

          child: FloatingActionButton(
            onPressed: () {
              vpnLocationController.retrieveVpnInformation();
            },
            backgroundColor: Colors.redAccent,

            child: Icon(CupertinoIcons.refresh_circled, size: 40),
          ),
        ),

        body:
            vpnLocationController.isLoadingNewLocations.value
                ? loadingProgessIndicatorWidget()
                : vpnLocationController.vpnFreeServerAvailableList.isEmpty
                ? noVpnServerFoundWidget()
                : vpnAvaibaleServersData(),
      ),
    );
  }

  Widget loadingProgessIndicatorWidget() {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
          ),
          const SizedBox(height: 8),
          Text(
            "Gathering Free VPN Locations",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget noVpnServerFoundWidget() {
    return Center(
      child: Text(
        "No VPNs Found, Try Again.",

        style: TextStyle(
          fontSize: 16,
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget vpnAvaibaleServersData() {
    return ListView.builder(
      itemCount: vpnLocationController.vpnFreeServerAvailableList.length,
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.all(3),

      itemBuilder: (context, index) {
        return VpnLocationCardWidget(
          vpnInfo: vpnLocationController.vpnFreeServerAvailableList[index],
        );
      },
    );
  }
}
