import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Core/utils/constants.dart';
import 'package:social_app/Core/utils/my_colors.dart';
import 'package:social_app/Features/Home/data/repos/home_repo_impl.dart';
import 'package:social_app/Features/Home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:social_app/Features/News%20Feed/data/repos/news_feed_repo_impl.dart';
import 'package:social_app/Features/News%20Feed/presentation/manager/news_feed_cubit/news_feed_cubit.dart';

import 'Core/utils/app_router.dart';
import 'Core/utils/cache_network.dart';
import 'Core/utils/service_locator.dart';
import 'firebase_options.dart';

void main() async {
  setupServiceLocator();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheNetwork.cacheInitialization();
  uId = await CacheNetwork.getCacheData(key: 'uId');
  if (uId != null) {
    await getIt.get<HomeRepoImpl>().getUserData();
  }
  runApp(
    // DevicePreview(
    //   builder: (context) => const SocialApp(),
    // ),
    const SocialApp(),
  );
}

class SocialApp extends StatelessWidget {
  const SocialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsFeedCubit(getIt.get<NewsFeedRepoImpl>()),
        ),
        BlocProvider(
          create: (context) => HomeCubit(getIt.get<HomeRepoImpl>()),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        builder: DevicePreview.appBuilder,
        routerConfig: AppRouter.router,
        theme: ThemeData.dark().copyWith(
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: MyColors.myAquamarine,
            elevation: 1,
            backgroundColor: MyColors.myDarkCerulean,
          ),
          scaffoldBackgroundColor: MyColors.myDarkCerulean,
        ),
      ),
    );
  }
}
