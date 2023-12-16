import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Core/utils/constants.dart';
import 'package:social_app/Features/Home/data/repos/home_repo_impl.dart';
import 'package:social_app/Features/Profile/presentation/views/profile_view.dart';

import '../../../../../Core/models/user_model.dart';
import '../../../../Chat/presentation/views/chats_view.dart';
import '../../../../News Feed/presentation/views/news_feed_view.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepoImpl) : super(HomeInitial());

  final HomeRepoImpl homeRepoImpl;

  List<Widget> views = [const NewsFeedView(), ChatsView(), const ProfileView()];

  int currentIndex = 0;

  void changeBottomNavBarState(int index) {
    emit(ChangeBottomNavBarLoadingState());

    currentIndex = index;
    emit(ChangeBottomNavBarSuccessState());
  }

  late List<UserModel> usersModel = [];

  Future<void> getUserData() async {
    emit(GetUserDataLoadingState());

    var result = await homeRepoImpl.getUserData();

    result.fold(
      (failure) =>
          emit(GetUserDataFailureState(errorMessage: failure.errMessage)),
      (userModel) {
        user = userModel;
        emit(GetUserDataSuccessState());
      },
    );
  }

  Future<void> getAllUsers() async {
    emit(GetAllUsersLoadingState());
    var result = await homeRepoImpl.getAllUsers();
    result.fold(
      (failure) =>
          emit(GetAllUsersFailureState(errorMessage: failure.errMessage)),
      (usersModel) {
        users = usersModel;
        this.usersModel = usersModel;
        emit(GetAllUsersSuccessState());
      },
    );
  }
}
