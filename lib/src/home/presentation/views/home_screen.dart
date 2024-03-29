import 'package:bigsizeship_mobile/core/resources/colours.dart';
import 'package:bigsizeship_mobile/src/authentication/data/models/user_model.dart';
import 'package:bigsizeship_mobile/src/home/presentation/providers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel>(
      stream: null,
      builder: (context, snapshot) {
        return Consumer<HomeController>(
          builder: (_, controller, __) {
            return Scaffold(
              body: IndexedStack(
                index: controller.currentIndex,
                children: controller.screens,
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: controller.currentIndex,
                elevation: 8,
                onTap: controller.changeIndex,
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      controller.currentIndex == 0
                          ? IconlyBold.document
                          : IconlyLight.document,
                      color: controller.currentIndex == 0
                          ? Colours.primaryColour
                          : Colors.grey,
                    ),
                    label: 'Đơn hàng',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      controller.currentIndex == 1
                          ? IconlyBold.home
                          : IconlyLight.home,
                      color: controller.currentIndex == 1
                          ? Colours.primaryColour
                          : Colors.grey,
                    ),
                    label: 'Kho hàng',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      controller.currentIndex == 2
                          ? IconlyBold.profile
                          : IconlyLight.profile,
                      color: controller.currentIndex == 2
                          ? Colours.primaryColour
                          : Colors.grey,
                    ),
                    label: 'Tài khoản',
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
