import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:social_app/Features/News%20Feed/data/models/comment_model.dart';

import '../../../../Core/errors/failures.dart';
import '../models/post_model.dart';

abstract class NewsFeedRepo {
  //create post
  Future<Either<Failure, void>> createPost({
    required String text,
    required String dateTime,
    required File postImage,
  });

  // edit post
  Future<Either<Failure, void>> editPost({
    required String text,
    required String dateTime,
    required File postImage,
    required String postId,
    required List<String> likes,
  });

  // get posts
  Future<Either<Failure, List<PostModel>>> getPosts();

  // update like post
  Future<Either<Failure, int>> updateLikePost({required PostModel postModel});

  // update like comment
  Future<Either<Failure, int>> updateLikeComment({
    required PostModel postModel,
    required CommentModel commentModel,
  });

  // create comment
  Future<Either<Failure, void>> createComment({
    required String text,
    required String dateTime,
    required String postId,
  });

  // update save post
  Future<Either<Failure, void>> updateSavePost({required PostModel postModel});

  // update follow user
  Future<Either<Failure, void>> updateFollowUser({required String uid});

  // delete post
  Future<Either<Failure, void>> deletePost({required PostModel postModel});
}
