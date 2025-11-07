import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_app/controllers/auth_controller.dart';
import 'package:my_app/core/constant/app_colors.dart';
import 'package:my_app/models/responses/user.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<AuthController, UserInfo>(
        shouldRebuild: (previous, next) => true,
        selector: (_, auth) => auth.userInfo!,
        builder: (context, authController, child) {
          return Drawer(
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(authController.firstName!),
                  accountEmail: Text(authController.email!),
                  currentAccountPicture: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child:
                        Icon(Icons.person, size: 40, color: Colors.blueAccent),
                  ),
                  decoration: BoxDecoration(color: AppColors.primaryColor),
                ),
                ListTile(
                  leading: const Icon(Icons.edit, color: Colors.blueAccent),
                  title: const Text("Edit Profile"),
                  onTap: () {},
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.redAccent),
                  title: const Text("Logout"),
                  onTap: () {},
                ),
              ],
            ),
          );
        });
  }
}
