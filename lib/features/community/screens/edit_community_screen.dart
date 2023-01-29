import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone_flutter/core/common/error_text.dart';
import 'package:reddit_clone_flutter/core/common/loader.dart';
import 'package:reddit_clone_flutter/core/constants/constants.dart';
import 'package:reddit_clone_flutter/features/community/controller/community_controller.dart';
import 'package:reddit_clone_flutter/theme/pallete.dart';
import 'package:reddit_clone_flutter/widgets/custom_text.dart';

class EditCommunityScreen extends ConsumerStatefulWidget {
  final String name;
  const EditCommunityScreen({super.key, required this.name});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditCommunityScreenState();
}

class _EditCommunityScreenState extends ConsumerState<EditCommunityScreen> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(getCommunityByNameProvider(widget.name)).when(
          data: (community) => Scaffold(
            backgroundColor: Pallete.darkModeAppTheme.backgroundColor,
            appBar: AppBar(
              centerTitle: true,
              title: const CustomText(text: "Edit Community"),
              actions: [
                TextButton(
                    onPressed: () {}, child: const CustomText(text: "Save"))
              ],
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DottedBorder(
                      // radius: const Radius.circular(30),
                      color: Colors.white,
                      child: SizedBox(
                        width: double.infinity,
                        height: 150,
                        child: community.banner.isEmpty ||
                                community.banner == Constants.bannerDefault
                            ? Center(
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.camera_alt_outlined,
                                      size: 40,
                                    )),
                              )
                            : Image.network(community.banner),
                      )),
                )
              ],
            ),
          ),
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => const Loader(),
        );
  }
}
