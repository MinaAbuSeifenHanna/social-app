import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:social_app/Features/Auth/data/repos/auth_repo_impl.dart';
import 'package:social_app/Features/Home/data/repos/home_repo_impl.dart';
import 'package:social_app/Features/News%20Feed/data/repos/news_feed_repo_impl.dart';

import '../../Features/Chat/data/repos/chat_repo_impl.dart';
import '../../Features/Profile/data/repos/edit_profile_repo_impl.dart';
import 'api_service.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<ApiService>(ApiService(Dio()));

  getIt.registerSingleton<AuthRepoImpl>(AuthRepoImpl());

  getIt.registerSingleton<HomeRepoImpl>(HomeRepoImpl());

  getIt.registerSingleton<NewsFeedRepoImpl>(NewsFeedRepoImpl());

  getIt.registerSingleton<ChatRepoImpl>(ChatRepoImpl());

  getIt.registerSingleton<EditProfileRepoImpl>(EditProfileRepoImpl());
}
