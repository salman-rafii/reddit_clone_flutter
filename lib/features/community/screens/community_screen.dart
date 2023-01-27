import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone_flutter/core/common/error_text.dart';
import 'package:reddit_clone_flutter/core/common/loader.dart';
import 'package:reddit_clone_flutter/features/community/controller/community_controller.dart';

class CommunityScreen extends ConsumerWidget {
  final String name;
  const CommunityScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ref.watch(getCommunityByNameProvider(name)).when(
            data: (community) => NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      expandedHeight: 150,
                      floating: true,
                      snap: true,
                      flexibleSpace: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.network(
                              community.banner,
                              fit: BoxFit.cover,
                            ),
                          )
                        ],
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(16),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Align(
                              alignment: Alignment.topLeft,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(community.avatar),
                                radius: 35,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ];
                },
                body: const Text("displaying community posts")),
            error: (error, stackTrace) => ErrorText(error: error.toString()),
            loading: () => const Loader(),
          ),
    );
  }
}
