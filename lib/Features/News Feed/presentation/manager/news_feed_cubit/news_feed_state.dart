part of 'news_feed_cubit.dart';

sealed class NewsFeedState extends Equatable {
  const NewsFeedState();

  @override
  List<Object> get props => [];
}

final class NewsFeedInitial extends NewsFeedState {}

// Create post
final class CreatePostSuccessState extends NewsFeedState {}

final class CreatePostFailureState extends NewsFeedState {
  final String errorMessage;

  const CreatePostFailureState({required this.errorMessage});
}

final class CreatePostLoadingState extends NewsFeedState {}

// Edit post
final class EditPostSuccessState extends NewsFeedState {}

final class EditPostFailureState extends NewsFeedState {
  final String errorMessage;

  const EditPostFailureState({required this.errorMessage});
}

final class EditPostLoadingState extends NewsFeedState {}

// Get posts
final class GetPostsSuccessState extends NewsFeedState {
  final List<PostModel> posts;

  const GetPostsSuccessState({required this.posts});
}

final class GetPostsFailureState extends NewsFeedState {
  final String errorMessage;

  const GetPostsFailureState({required this.errorMessage});
}

final class GetPostsLoadingState extends NewsFeedState {}

// Update like post
final class UpdateLikePostLoadingState extends NewsFeedState {}

final class UpdateLikePostSuccessState extends NewsFeedState {}

final class UpdateLikePostFailureState extends NewsFeedState {
  final String errorMessage;

  const UpdateLikePostFailureState({required this.errorMessage});
}

// update like comment
final class UpdateLikeCommentLoadingState extends NewsFeedState {}

final class UpdateLikeCommentSuccessState extends NewsFeedState {}

final class UpdateLikeCommentFailureState extends NewsFeedState {
  final String errorMessage;

  const UpdateLikeCommentFailureState({required this.errorMessage});
}

// add comment in post
final class CreateCommentLoadingState extends NewsFeedState {}

final class CreateCommentSuccessState extends NewsFeedState {}

final class CreateCommentFailureState extends NewsFeedState {
  final String errorMessage;

  const CreateCommentFailureState({required this.errorMessage});
}


//  Update Save post
final class UpdateSavePostLoadingState extends NewsFeedState {}

final class UpdateSavePostSuccessState extends NewsFeedState {}

final class UpdateSavePostFailureState extends NewsFeedState {
  final String errorMessage;

  const UpdateSavePostFailureState({required this.errorMessage});
}

// Upload post image
final class PostImagePickedSuccessState extends NewsFeedState {}

final class PostImagePickedFailureState extends NewsFeedState {}

final class PostImagePickedLoadingState extends NewsFeedState {}

// delete post
final class DeletePostLoadingState extends NewsFeedState {}

final class DeletePostSuccessState extends NewsFeedState {}

final class DeletePostFailureState extends NewsFeedState {
  final String errorMessage;

  const DeletePostFailureState({required this.errorMessage});
}

// remove post image

final class RemovePostImageState extends NewsFeedState {}

// Update follow user
final class UpdateFollowUserLoadingState extends NewsFeedState {}

final class UpdateFollowUserSuccessState extends NewsFeedState {}

final class UpdateFollowUserFailureState extends NewsFeedState {
  final String errorMessage;

  const UpdateFollowUserFailureState({required this.errorMessage});
}
