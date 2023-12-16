import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Features/Chat/data/models/message_model.dart';
import 'package:social_app/Features/Chat/data/repos/chat_repo_impl.dart';

import '../../../../../Core/models/user_model.dart';
import '../../../../../Core/utils/constants.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.chatRepo) : super(ChatInitialState());

  final ChatRepoImpl chatRepo;

  late final List<UserModel> usersChat;
  List<UserModel> searchedChats = [];

  List<MessageModel> messages = [];

  Future<void> getUsersForChat() async {
    emit(GetUsersForChatLoadingState());
    var result = await chatRepo.getAllUsers();
    result.fold(
      (failure) =>
          emit(GetUsersForChatFailureState(errorMessage: failure.errMessage)),
      (users) {
        usersChat = users.where((element) => element.uId != uId).toList();
        searchedChats = usersChat;
        emit(GetUsersForChatSuccessState());
      },
    );
  }

  Future<void> searchChat(String query) async {
    emit(ChatsSearching());
    searchedChats = usersChat
        .where((element) =>
            element.name!.toLowerCase().startsWith(query.toLowerCase()))
        .toList();
    emit(GetUsersForChatSuccessState());
  }

  Future<void> getMessages(String receiverId) async {
    emit(GetMessagesLoadingState());
    var result = await chatRepo.getMessages(receiverId: receiverId);

    result.fold(
      (failure) =>
          emit(GetMessagesFailureState(errorMessage: failure.errMessage)),
      (messages) {
        this.messages = messages;
        emit(GetMessagesSuccessState());
      },
    );
  }

  Future<void> sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) async {
    emit(SendMessageLoadingState());
    var result = await chatRepo.sendMessage(
      receiverId: receiverId,
      dateTime: dateTime,
      text: text,
    );

    result.fold(
      (failure) =>
          emit(GetMessagesFailureState(errorMessage: failure.errMessage)),
      (isSend) {
        emit(GetMessagesSuccessState());
      },
    );
  }


}
