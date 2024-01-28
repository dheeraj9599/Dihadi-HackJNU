
import 'package:dihadi/features/chatbot/controller/chat_bot_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/app_constant.dart';
import '../../../core/common/error_text.dart';
import '../../../core/common/loader.dart';
import '../../../routes/route_utils.dart';
import '../../../theme/app_text_style.dart';
import '../../auth/controller/auth_controller.dart';
import '../../message/widgets/chat_bubble.dart';
import '../../message/widgets/custom_chat_field.dart';

class ChatBotScreen extends ConsumerStatefulWidget {
  const ChatBotScreen({
    super.key,
  });

  @override
  ChatBotScreenState createState() => ChatBotScreenState();
}

class ChatBotScreenState extends ConsumerState<ChatBotScreen> {
  late TextEditingController _messageController;
  late ScrollController _scrollController;

  @override
  void initState() {
    _messageController = TextEditingController();
    _scrollController = ScrollController();

    super.initState();
  }



  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final chatMessages = ref.watch(chatMessagesProvider);

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
               const  Text(
                    'ChatBot',
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
            child: ListView.builder(
              itemCount: chatMessages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(chatMessages[index]),
                );
              },
            ),
          ),
          ChatTextFieldBar( 
            controller: _messageController,
            onSend: (){
               final message = _messageController.text.trim();
                    if (message.isNotEmpty) {
                      ref.read(chatBotControllerProvider.notifier).sendMessageAndFetchAnswer(message);
                      _messageController.clear();
            }
            },
          )
        ],
      ),
    );
  }
}