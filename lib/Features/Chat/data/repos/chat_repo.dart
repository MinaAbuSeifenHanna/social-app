import 'package:dartz/dartz.dart';
import 'package:social_app/Core/errors/failures.dart';
import 'package:social_app/Features/Chat/data/models/message_model.dart';

import '../../../../Core/models/user_model.dart';

abstract class ChatRepo {
  Future<Either<Failure, List<UserModel>>> getAllUsers();

  Future<Either<Failure, List<MessageModel>>> getMessages({
    required String receiverId,
  });

  Future<Either<Failure, bool>> sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  });


  Future<void> sendVoiceMessage({
    required String receiverId,
    required String dateTime,
    required String voiceMessagePath,
  }) async {
    // Logic for sending the voice message to the server or external service
    // Example: Make an API call to send the voice message
  }
}
