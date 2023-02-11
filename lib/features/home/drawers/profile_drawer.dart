import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone_flutter/features/auth/controller/auth_controller.dart';
import 'package:reddit_clone_flutter/theme/pallete.dart';
import 'package:reddit_clone_flutter/widgets/custom_text.dart';

class ProfileDrawer extends ConsumerWidget {
  const ProfileDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Drawer(
      child: SafeArea(
          child: Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(user.profilePic),
            radius: 70,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomText(
            text: "u/${user.name}",
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.person,
              color: Pallete.redColor,
            ),
            title: const CustomText(
              text: "Create Community",
            ),
          )
        ],
      )),
    );
  }
}