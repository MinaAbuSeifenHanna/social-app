import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Core/utils/icon_broken.dart';
import 'package:social_app/Core/utils/my_colors.dart';
import 'package:social_app/Core/utils/styles.dart';
import 'package:social_app/Features/Chat/presentation/manager/chat_cubit/chat_cubit.dart';

class ChatsSearchTextField extends StatelessWidget {
  const ChatsSearchTextField({super.key, required this.searchController});

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        hintText: 'Search',
        hintMaxLines: 1,
        prefixIcon: const Icon(IconBroken.Search, size: 28),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        fillColor: MyColors.mySteelBlue.withOpacity(0.2),
        filled: true,
        hintStyle: Styles.textStyle18,
      ),
      style: Styles.textStyle18,
      onChanged: (String searchingText) =>
          BlocProvider.of<ChatCubit>(context).searchChat(searchingText),
    );
  }
}
