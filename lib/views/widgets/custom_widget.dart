import 'package:flutter/material.dart';
import 'package:vibe_vpn/core/constants/app_size.dart';

class CustomWidget extends StatelessWidget {
  const CustomWidget({
    super.key,
    required this.titleText,
    required this.subTitleText,
    required this.widgetWithIcon,
  });

  final String titleText;
  final String subTitleText;
  final Widget widgetWithIcon;

  @override
  Widget build(BuildContext context) {
    sizeScreen = MediaQuery.of(context).size;
    return SizedBox(
      width: sizeScreen.width * .46,
      child: Column(
        children: [
          widgetWithIcon,

          const SizedBox(height: 7),
          Text(
            titleText,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 7),
          Text(
            subTitleText,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
