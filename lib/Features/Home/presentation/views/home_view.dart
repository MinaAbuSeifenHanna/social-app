import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_app/Core/utils/app_router.dart';
import 'package:social_app/Features/Home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:social_app/Features/News%20Feed/presentation/manager/news_feed_cubit/news_feed_cubit.dart';

import '../../../../Core/utils/icon_broken.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    getUserData();
    getAllUsers();
    getAllPosts();
  }

  getAllUsers() async {
    await BlocProvider.of<HomeCubit>(context).getAllUsers();
  }

  getUserData() async {
    await BlocProvider.of<HomeCubit>(context).getUserData();
  }

  getAllPosts() async {
    await BlocProvider.of<NewsFeedCubit>(context).getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is NewPostState) {
          GoRouter.of(context).push(AppRouter.kNewPostView);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: BlocProvider.of<HomeCubit>(context)
                .views[BlocProvider.of<HomeCubit>(context).currentIndex],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Chat),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Setting),
                label: 'Settings',
              ),
            ],
            currentIndex: BlocProvider.of<HomeCubit>(context).currentIndex,
            onTap: (value) {
              BlocProvider.of<HomeCubit>(context)
                  .changeBottomNavBarState(value);
            },
          ),
        );
      },
    );
  }
}
