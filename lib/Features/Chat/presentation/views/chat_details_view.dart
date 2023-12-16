import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Core/utils/assets_data.dart';
import 'package:social_app/Core/widgets/custom_empty_widget.dart';
import 'package:social_app/Core/widgets/custom_loading_widget.dart';
import 'package:social_app/Features/Chat/presentation/views/widgets/chat_bubble.dart';
import 'package:social_app/Features/Chat/presentation/views/widgets/chat_bubble_for_friend.dart';
import 'package:social_app/Features/Chat/presentation/views/widgets/chat_details_view_app_bar.dart';
import 'package:social_app/Features/Chat/presentation/views/widgets/chat_details_view_message_input.dart';

import '../../../../Core/models/user_model.dart';
import '../../../../Core/utils/constants.dart';
import '../manager/chat_cubit/chat_cubit.dart';

class ChatDetailsView extends StatefulWidget {
  const ChatDetailsView({super.key, required this.userModel});

  final UserModel userModel;

  @override
  State<ChatDetailsView> createState() => _ChatDetailsViewState();
}

class _ChatDetailsViewState extends State<ChatDetailsView> {
  final messageController = TextEditingController();
  final scrollController = ScrollController();



  @override
  void initState() {
    super.initState();
    getMessages();
  }

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }

  getMessages() async {
    await BlocProvider.of<ChatCubit>(context)
        .getMessages(widget.userModel.uId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ChatDetailsViewAppBar(userModel: widget.userModel),
            BlocBuilder<ChatCubit, ChatState>(builder: (context, state) {
              if (state is GetMessagesLoadingState) {
                return const Expanded(
                  child: CustomLoadingWidget(),
                );
              } else {
                return (BlocProvider.of<ChatCubit>(context).messages.isNotEmpty)
                    ? Expanded(
                        child: ListView.builder(
                          reverse: true,
                          controller: scrollController,
                          itemBuilder: (context, index) {
                            if (BlocProvider.of<ChatCubit>(context)
                                    .messages[index]
                                    .senderId ==
                                uId) {
                              return ChatBubble(
                                message: BlocProvider.of<ChatCubit>(context)
                                    .messages[index],
                              );
                            } else {
                              return ChatBubbleForFriend(
                                message: BlocProvider.of<ChatCubit>(context)
                                    .messages[index],
                              );
                            }
                          },
                          itemCount: BlocProvider.of<ChatCubit>(context)
                              .messages
                              .length,
                        ),
                      )
                    : const Expanded(
                        child: CustomEmptyWidget(
                          title: 'There is no messages yet',
                          subTitle: 'Start your conversation now',
                          image: AssetsData.emptyChat,
                        ),
                      );
              }
            }),
            ChatDetailsViewMessageInput(
              messageController: messageController,
              scrollController: scrollController,
              userModel: widget.userModel,
            ),

          ],
        ),
      ),
    );
  }



}
