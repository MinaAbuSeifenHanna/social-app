import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/Features/News%20Feed/data/models/comment_model.dart';
import 'package:social_app/Features/News%20Feed/data/repos/news_feed_repo_impl.dart';

import '../../../data/models/post_model.dart';

part 'news_feed_state.dart';

class NewsFeedCubit extends Cubit<NewsFeedState> {
  NewsFeedCubit(this.newsFeedRepo) : super(NewsFeedInitial());

  final NewsFeedRepoImpl newsFeedRepo;

  File? postImage;
  var picker = ImagePicker();

  // get post image
  Future<void> getPostImage() async {
    emit(PostImagePickedLoadingState());
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(PostImagePickedSuccessState());
    } else {
      emit(PostImagePickedFailureState());
    }
  }

  // remove post image
  void removePostImage() {
    postImage = null;
    emit(RemovePostImageState());
  }

  // create post
  Future<void> createPost({
    required String text,
    required String dateTime,
  }) async {
    emit(CreatePostLoadingState());

    var result = await newsFeedRepo.createPost(
      dateTime: dateTime,
      text: text,
      postImage: postImage,
    );

    result.fold(
      (failure) =>
          emit(CreatePostFailureState(errorMessage: failure.errMessage)),
      (_) {
        getPosts();
        emit(CreatePostSuccessState());
      },
    );
  }

  // edit post
  Future<void> editPost({
    required String text,
    required String dateTime,
    required String postId,
    required List<String> likes,
  }) async {
    emit(EditPostLoadingState());

    var result = await newsFeedRepo.editPost(
      dateTime: dateTime,
      text: text,
      postImage: postImage,
      postId: postId,
      likes: likes,
    );

    result.fold(
      (failure) => emit(EditPostFailureState(errorMessage: failure.errMessage)),
      (_) {
        getPosts();
        emit(EditPostSuccessState());
      },
    );
  }

  // get all posts
  List<PostModel> posts = [];
  Future<void> getPosts() async {
    emit(GetPostsLoadingState());

    var result = await newsFeedRepo.getPosts();

    result.fold(
      (failure) => emit(GetPostsFailureState(errorMessage: failure.errMessage)),
      (posts) {
        this.posts = posts;
        emit(GetPostsSuccessState(posts: posts));
      },
    );
  }

  // update like post
  Future<void> updateLikePost({required PostModel postModel}) async {
    emit(UpdateLikePostLoadingState());
    var result = await newsFeedRepo.updateLikePost(postModel: postModel);

    result.fold(
      (failure) => emit(GetPostsFailureState(errorMessage: failure.errMessage)),
      (posts) => emit(UpdateLikePostSuccessState()),
    );
  }

  // update like comment
  Future<void> updateLikeComment({
    required PostModel postModel,
    required CommentModel commentModel,
  }) async {
    emit(UpdateLikeCommentLoadingState());
    var result = await newsFeedRepo.updateLikeComment(
      postModel: postModel,
      commentModel: commentModel,
    );

    result.fold(
      (failure) =>
          emit(UpdateLikeCommentFailureState(errorMessage: failure.errMessage)),
      (_) => emit(UpdateLikeCommentSuccessState()),
    );
  }

  // add comment in post
  Future<void> createComment({
    required String text,
    required String dateTime,
    required String postId,
  }) async {
    emit(CreateCommentLoadingState());
    var result = await newsFeedRepo.createComment(
      dateTime: dateTime,
      text: text,
      postId: postId,
    );

    result.fold(
      (failure) =>
          emit(CreateCommentFailureState(errorMessage: failure.errMessage)),
      (_) {
        getPosts();
        emit(CreateCommentSuccessState());
      },
    );
  }

  // update save post
  Future<void> updateSavePost({required PostModel postModel}) async {
    emit(UpdateSavePostLoadingState());
    var result = await newsFeedRepo.updateSavePost(postModel: postModel);

    result.fold(
      (failure) =>
          emit(UpdateSavePostFailureState(errorMessage: failure.errMessage)),
      (_) => emit(UpdateSavePostSuccessState()),
    );
  }

  // update follow user
  Future<void> updateFollowUser({required String uid}) async {
    emit(UpdateFollowUserLoadingState());
    var result = await newsFeedRepo.updateFollowUser(uid: uid);

    result.fold(
      (failure) =>
          emit(UpdateFollowUserFailureState(errorMessage: failure.errMessage)),
      (_) => emit(UpdateFollowUserSuccessState()),
    );
  }

  // update delete post
  Future<void> deletePost({required PostModel postModel}) async {
    emit(DeletePostLoadingState());
    var result = await newsFeedRepo.deletePost(postModel: postModel);
    result.fold(
      (failure) =>
          emit(DeletePostFailureState(errorMessage: failure.errMessage)),
      (_) {
        getPosts();
        emit(DeletePostSuccessState());
      },
    );
  }
}
