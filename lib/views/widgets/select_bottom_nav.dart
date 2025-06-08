import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibe_vpn/core/constants/app_size.dart';
import 'package:vibe_vpn/views/screens/available_servers_locations_screen.dart';

class SelectBottomNav extends StatelessWidget {
  const SelectBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Semantics(
        button: true,
        child: InkWell(
          onTap: () {
            Get.to(() => AvailableServersLocationsScreen());
          },

          child: Container(
            color: Colors.redAccent,
            padding: EdgeInsets.symmetric(horizontal: sizeScreen.width * .041),
            height: 62,
            child: Row(
              children: [
                Icon(CupertinoIcons.flag_circle, color: Colors.white, size: 26),

                const SizedBox(width: 12),

                Text(
                  "Select Country / Location",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Spacer(),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.redAccent,
                    size: 36,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
