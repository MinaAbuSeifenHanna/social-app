import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Core/utils/assets_data.dart';
import 'package:social_app/Core/utils/styles.dart';
import 'package:social_app/Core/widgets/custom_empty_widget.dart';
import 'package:social_app/Features/Chat/presentation/manager/chat_cubit/chat_cubit.dart';
import 'package:social_app/Features/Chat/presentation/views/widgets/chat_item.dart';
import 'package:social_app/Features/Chat/presentation/views/widgets/chats_search_text_field.dart';
import 'package:social_app/Features/News%20Feed/presentation/views/widgets/custom_divider.dart';

import '../../../../Core/widgets/custom_failure_widget.dart';
import '../../../../Core/widgets/custom_loading_widget.dart';

class ChatsView extends StatelessWidget {
  ChatsView({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        if (state is GetUsersForChatLoadingState) {
          return const CustomLoadingWidget();
        } else if (state is GetUsersForChatFailureState) {
          return CustomFailureWidget(errMessage: state.errorMessage);
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                Text(
                  'Chats',
                  style: Styles.textStyle34,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                ChatsSearchTextField(searchController: searchController),
                const SizedBox(height: 20),
                (BlocProvider.of<ChatCubit>(context).searchedChats.isNotEmpty)
                    ? Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => ChatItem(
                            userModel: BlocProvider.of<ChatCubit>(context)
                                .searchedChats[index],
                          ),
                          separatorBuilder: (context, index) =>
                              const CustomDivider(),
                          itemCount: BlocProvider.of<ChatCubit>(context)
                              .searchedChats
                              .length,
                        ),
                      )
                    : const Expanded(
                        child: CustomEmptyWidget(
                          title: 'No results found',
                          image: AssetsData.emptyChat,
                        ),
                      ),
              ],
            ),
          );
        }
      },
    );
  }
}
