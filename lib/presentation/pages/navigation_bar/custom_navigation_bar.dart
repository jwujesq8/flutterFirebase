import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lsm_project/presentation/pages/navigation_bar/bar_button.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        color: Colors.white,
        child: Container(
          padding: const EdgeInsets.fromLTRB(15,5, 4, 10),
          height: 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BarButton(
                icon: Icons.collections_bookmark_sharp,
                text: "library",
                onPressed: () {
                  Get.offAllNamed("/library");
                },
              ),
              BarButton(
                icon: Icons.hotel_class_rounded,
                text: "home",
                onPressed: () {
                  Get.offAllNamed("/home");
                },
              ),
              BarButton(
                icon: Icons.adb_sharp,
                text: "settings",
                onPressed: () {
                  Get.offAllNamed("/settings");
                },
              ),
            ],
          ),
        )
    );
  }
}