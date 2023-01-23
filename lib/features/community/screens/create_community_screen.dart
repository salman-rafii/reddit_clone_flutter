import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone_flutter/core/common/loader.dart';
import 'package:reddit_clone_flutter/features/community/controller/community_controller.dart';
import 'package:reddit_clone_flutter/widgets/custom_button.dart';
import 'package:reddit_clone_flutter/widgets/custom_text.dart';

class CreateCommunityScreen extends ConsumerStatefulWidget {
  const CreateCommunityScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateCommunityScreenState();
}

class _CreateCommunityScreenState extends ConsumerState<CreateCommunityScreen> {
  final communityNameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    communityNameController.dispose();
  }

  void createCommunity() {
    ref
        .read(communityControllerProvider.notifier)
        .createCommunity(communityNameController.text.trim(), context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(communityControllerProvider);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const CustomText(
            text: "Create a community",
          ),
        ),
        body: isLoading
            ? const Loader()
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: "Community name",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: communityNameController,
                      decoration: const InputDecoration(
                          hintText: "r/Community_name",
                          filled: true,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(18)),
                      maxLength: 21,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomButton(
                      buttonText: "Create Community",
                      fontSize: 17.0,
                      onPressed: createCommunity,
                      borderRadius: 20.0,
                    )
                  ],
                ),
              ));
  }
}
