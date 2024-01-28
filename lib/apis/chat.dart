import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';


import '../constants/firebase_constants.dart';
import '../core/failure.dart';
import '../core/providers.dart';
import '../core/type_defs.dart';
import '../models/message.dart';

final messagesApiProvider = Provider<MessagesApi>((ref) {
  return MessagesApi(
    firestore: ref.watch(firestoreProvider),
  );
});

abstract class IMessagesApi {
  Stream<List<Message>> getOneToOneMessages({
    required String receiverUserId,
    required String uid,
  });
  FutureVoid sendTextMessage({
    required Message message,
  });
}

class MessagesApi implements IMessagesApi {
  final FirebaseFirestore _firestore;

  MessagesApi({required FirebaseFirestore firestore}) : _firestore = firestore;



  @override
  Stream<List<Message>> getOneToOneMessages({
    required String receiverUserId,
    required String uid,
  }) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('chats')
        .doc(receiverUserId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .map((event) {
      List<Message> messages = [];
      for (var document in event.docs) {
        messages.add(
          Message.fromMap(
            document.data(),
          ),
        );
      }
      return messages;
    });
  }


  @override
  FutureVoid sendTextMessage({
    required Message message,
  }) async {
    // Sender
    // users -> sender id -> receiver id -> messages -> message id -> store message
    await _firestore
        .collection('users')
        .doc(message.senderId)
        .collection('chats')
        .doc(message.receiverId)
        .collection('messages')
        .doc(message.id)
        .set(
          message.toMap(),
        );
    //  Receiver
    // users -> receiver id  -> sender id -> messages -> message id -> store message
    await _firestore
        .collection('users')
        .doc(message.receiverId)
        .collection('chats')
        .doc(message.senderId)
        .collection('messages')
        .doc(message.id)
        .set(
          message.toMap(),
        );
  }
}