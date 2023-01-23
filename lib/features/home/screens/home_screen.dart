import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone_flutter/features/auth/controller/auth_controller.dart';
import 'package:reddit_clone_flutter/features/home/drawers/community_list_drawer.dart';
import 'package:reddit_clone_flutter/widgets/custom_text.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const CustomText(
          text: "Home",
        ),
        // leading: IconButton(
        //   icon: const Icon(Icons.menu),
        //   onPressed: () {},
        // ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          CircleAvatar(
            backgroundImage: NetworkImage(user.profilePic),
          )
        ],
      ),
      drawer: const CommunityListDrawer(),
    );
  }
}
