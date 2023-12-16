import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:social_app/Core/errors/failures.dart';
import 'package:social_app/Core/models/user_model.dart';
import 'package:social_app/Core/utils/constants.dart';
import 'package:social_app/Features/Chat/data/repos/chat_repo.dart';

import '../models/message_model.dart';

class ChatRepoImpl implements ChatRepo {
  @override
  Future<Either<Failure, List<UserModel>>> getAllUsers() async {
    try {
      List<UserModel> users = [];

      QuerySnapshot<Map<String, dynamic>> data =
          await FirebaseFirestore.instance.collection('users').get();

      for (var item in data.docs) {
        users.add(UserModel.fromMap(item.data()));
      }
      return right(users);
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MessageModel>>> getMessages(
      {required String receiverId}) async {
    try {
      List<MessageModel> messages = [];

      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .collection('chats')
          .doc(receiverId)
          .collection('messages')
          .orderBy('dateTime', descending: true)
          .snapshots()
          .listen((event) {
        messages.clear();
        for (var item in event.docs) {
          messages.add(MessageModel.fromMap(item.data()));
        }
      });

      if (messages.isEmpty) {
        var querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(uId)
            .collection('chats')
            .doc(receiverId)
            .collection('messages')
            .orderBy('dateTime', descending: true)
            .get();

        messages.clear();
        for (var item in querySnapshot.docs) {
          messages.add(MessageModel.fromMap(item.data()));
        }
      }

      return right(messages);
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) async {
    try {
      MessageModel messageModel = MessageModel(
        senderId: uId,
        receiverId: receiverId,
        dateTime: dateTime,
        text: text,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .collection('chats')
          .doc(receiverId)
          .collection('messages')
          .add(messageModel.toMap());

      await FirebaseFirestore.instance
          .collection('users')
          .doc(receiverId)
          .collection('chats')
          .doc(uId)
          .collection('messages')
          .add(messageModel.toMap());

      return right(true);
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }



  @override
  Future<Either<Failure, Unit>> sendVoiceMessage({
    required String receiverId,
    required String dateTime,
    required String voiceMessagePath,
  }) async {
    try {
      // Logic for sending the voice message to the server or external service
      // Example: Make an API call to send the voice message

      // If successful, return Right(Unit)
      return const Right(unit);
    } catch (e) {
      // If an error occurs, return Left(Failure)
      return Left(ServerFailure(errMessage: 'Failed to send voice message: $e'));
    }
  }
}
