import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../apis/chat.dart';
import '../../../models/message.dart';
import '../../auth/controller/auth_controller.dart';

final messageControllerProvider =
    StateNotifierProvider<MessageController, bool>((ref) {
  final messageRepository = ref.watch(messagesApiProvider);
  return MessageController(
    messageRepository: messageRepository,
    ref: ref,
  );
});


final getOneToOneMessagesProvider = StreamProvider.family((ref,  String receiverId) {
  return ref.watch(messageControllerProvider.notifier).getOneToOneMessages(receiverId);
});

class MessageController extends StateNotifier<bool> {
  final MessagesApi _messageRepository;
  final Ref _ref;

  MessageController({
    required MessagesApi messageRepository,
    required Ref ref,
  })  : _messageRepository = messageRepository,
        _ref = ref,
        super(false);




  Stream<List<Message>> getOneToOneMessages(String receiverId) {
    return _messageRepository.getOneToOneMessages(
      uid: _ref.read(userProvider)!.uid.toString(),
      receiverUserId: receiverId,
    );
  }

  void sendTextMessage({
    required BuildContext context,
    required String text,
    required String receiverUserId,
  }) {
    final message = Message(
      id: Uuid().v1(),
      receiverId: receiverUserId,
      senderId: _ref.read(userProvider)!.uid.toString(),
      text: text,
      timestamp: Timestamp.now(),
    );

    _ref.read(messagesApiProvider).sendTextMessage(
          message: message,
        );
  }
}