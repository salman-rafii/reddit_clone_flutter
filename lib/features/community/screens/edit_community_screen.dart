import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone_flutter/core/common/error_text.dart';
import 'package:reddit_clone_flutter/core/common/loader.dart';
import 'package:reddit_clone_flutter/core/constants/constants.dart';
import 'package:reddit_clone_flutter/core/utils.dart';
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
  File? bannerFile;
  File? profileFile;
//function to select banner image
  void selectBannerImage() async {
    final res = await pickImage();
    if (res != null) {
      setState(() {
        bannerFile = File(res.files.first.path!);
      });
    }
  }

//function to select banner image
  void selectProfileImage() async {
    final res = await pickImage();
    if (res != null) {
      setState(() {
        bannerFile = File(res.files.first.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(getCommunityByNameProvider(widget.name)).when(
          data: (community) => Scaffold(
            // backgroundColor: Pallete.darkModeAppTheme.colorScheme.background,
            appBar: AppBar(
              centerTitle: true,
              title: const CustomText(text: "Edit Community"),
              actions: [
                TextButton(
                    onPressed: () {}, child: const CustomText(text: "Save"))
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 200,
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: selectBannerImage,
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              dashPattern: const [10, 4],
                              strokeCap: StrokeCap.round,
                              radius: const Radius.circular(10),
                              color: Pallete.darkModeAppTheme.textTheme
                                  .bodyMedium!.color!,
                              child: SizedBox(
                                width: double.infinity,
                                height: 150,
                                child: bannerFile != null
                                    ? Image.file(bannerFile!)
                                    : community.banner.isEmpty ||
                                            community.banner ==
                                                Constants.bannerDefault
                                        ? Center(
                                            child: IconButton(
                                                onPressed: () {},
                                                icon: const Icon(
                                                  Icons.camera_alt_outlined,
                                                  size: 40,
                                                )),
                                          )
                                        : Image.network(community.banner),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            left: 20,
                            child: GestureDetector(
                              onTap: selectProfileImage,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(community.avatar),
                                radius: 32,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => const Loader(),
        );
  }
}
