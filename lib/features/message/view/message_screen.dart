import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/app_constant.dart';
import '../../../core/common/error_text.dart';
import '../../../core/common/loader.dart';
import '../../../routes/route_utils.dart';
import '../../../theme/app_text_style.dart';
import '../../auth/controller/auth_controller.dart';
import '../controller/message_controller.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/custom_chat_field.dart';

class OneToOneChatScreen extends ConsumerStatefulWidget {
  final String userId;
  const OneToOneChatScreen({
    super.key,
    required this.userId,
  });

  @override
  OneToOneChatScreenState createState() => OneToOneChatScreenState();
}

class OneToOneChatScreenState extends ConsumerState<OneToOneChatScreen> {
  late TextEditingController messageController;
  late ScrollController _scrollController;

  @override
  void initState() {
    messageController = TextEditingController();
    _scrollController = ScrollController();

    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void sendMessage() {
    ref.read(messageControllerProvider.notifier).sendTextMessage(
          context: context,
          text: messageController.text.trim(),
          receiverUserId: widget.userId,
        );

    // Clear the text field
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(userProvider)!;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0.4,
        automaticallyImplyLeading: false,
        title: Row(
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigation.navigateToBack(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
              ),
            ),
            Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.fromLTRB(0, 5, 10, 0),
              child: CircleAvatar(
                backgroundImage: const AssetImage(
                  IMAGE_PATH_DEFAULT_USER_PROFILE_IMAGE,
                ),
                backgroundColor: Colors.grey[200],
                minRadius: 30,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Aditya Shahi',
                  style: AppTextStyle.displayBold,
                ),
                Text(
                  'Online Now',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                )
              ],
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              reverse: true,
              child: Column(
                children: ref.watch(getOneToOneMessagesProvider(widget.userId)).when(
                      data: (messages) {
                        return messages
                            .map((message) => Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Bubble(
                                    message: message.text,
                                    isMe: message.senderId ==
                                        currentUser.uid.toString(),
                                    sender: message.senderId,
                                  ),
                                ))
                            .toList();
                      },
                      error: (error, stackTrace) => [
                        ErrorText(
                          error: error.toString(),
                        ),
                      ],
                      loading: () => [const Loader()],
                    ),
              ),
            ),
          ),
          ChatTextFieldBar(
            controller: messageController,
            onSend: sendMessage,
          )
        ],
      ),
    );
  }
}