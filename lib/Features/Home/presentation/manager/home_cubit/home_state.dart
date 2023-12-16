part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class ChangeBottomNavBarLoadingState extends HomeState {}

final class ChangeBottomNavBarSuccessState extends HomeState {}

final class NewPostState extends HomeState {}

// get user data states
final class GetUserDataLoadingState extends HomeState {}

final class GetUserDataSuccessState extends HomeState {}

final class GetUserDataFailureState extends HomeState {
  final String errorMessage;

  const GetUserDataFailureState({required this.errorMessage});
}


// get all users
final class GetAllUsersLoadingState extends HomeState {}

final class GetAllUsersSuccessState extends HomeState {}

final class GetAllUsersFailureState extends HomeState {
  final String errorMessage;

  const GetAllUsersFailureState({required this.errorMessage});
}