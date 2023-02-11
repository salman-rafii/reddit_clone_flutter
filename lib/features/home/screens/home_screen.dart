import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone_flutter/features/auth/controller/auth_controller.dart';
import 'package:reddit_clone_flutter/features/home/delegates/search_community_delegate.dart';
import 'package:reddit_clone_flutter/features/home/drawers/community_list_drawer.dart';
import 'package:reddit_clone_flutter/features/home/drawers/profile_drawer.dart';
import 'package:reddit_clone_flutter/widgets/custom_text.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void displayEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

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
            onPressed: () {
              showSearch(
                  context: context, delegate: SearchCommunityDelegate(ref));
            },
            icon: const Icon(Icons.search),
          ),
          Builder(builder: (context) {
            return GestureDetector(
              child: CircleAvatar(
                backgroundImage: NetworkImage(user.profilePic),
              ),
              onTap: () => displayEndDrawer(context),
            );
          })
        ],
      ),
      drawer: const CommunityListDrawer(),
      endDrawer: const ProfileDrawer(),
    );
  }
}
