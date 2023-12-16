import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/Core/errors/failures.dart';
import 'package:social_app/Core/utils/constants.dart';
import 'package:social_app/Features/News%20Feed/data/models/post_model.dart';
import 'package:social_app/Features/News%20Feed/data/repos/news_feed_repo.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../models/comment_model.dart';

class NewsFeedRepoImpl implements NewsFeedRepo {
  @override
  Future<Either<Failure, void>> createPost({
    required String text,
    required String dateTime,
    required File? postImage,
  }) async {
    try {
      String postImageUrl = '';
      if (postImage != null) {
        firebase_storage.Reference refPath = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('posts/')
            .child(Uri.file(postImage.path).pathSegments.last);

        Uint8List imageData = await XFile(postImage.path).readAsBytes();
        firebase_storage.UploadTask uploadTask = refPath.putData(imageData);

        await uploadTask.then((firebase_storage.TaskSnapshot taskSnapshot) {
          return taskSnapshot.ref.getDownloadURL().then((value) {
            postImageUrl = value.toString();
            return value;
          });
        }).catchError((e) {
          return ('Failed to upload image to storage: $e');
        });
      }

      PostModel postModel = PostModel(
        uId: user.uId,
        text: text,
        dateTime: dateTime,
        postImage: postImageUrl,
        likes: const [],
      );

      CollectionReference postsCollection =
          FirebaseFirestore.instance.collection('posts');

      DocumentReference newPostRef =
          await postsCollection.add(postModel.toMap());

      String newPostId = newPostRef.id;

      await newPostRef.set(
        {'postId': newPostId},
        SetOptions(merge: true),
      );

      return right(null);
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> editPost({
    required String text,
    required String dateTime,
    required File? postImage,
    required String postId,
    required List<String> likes,
  }) async {
    try {
      String postImageUrl = '';
      if (postImage != null) {
        firebase_storage.Reference refPath = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('posts/')
            .child(Uri.file(postImage.path).pathSegments.last);

        Uint8List imageData = await XFile(postImage.path).readAsBytes();
        firebase_storage.UploadTask uploadTask = refPath.putData(imageData);

        await uploadTask.then((firebase_storage.TaskSnapshot taskSnapshot) {
          return taskSnapshot.ref.getDownloadURL().then((value) {
            postImageUrl = value.toString();
            return value;
          });
        }).catchError((e) {
          return ('Failed to upload image to storage: $e');
        });
      }

      PostModel postModel = PostModel(
        uId: user.uId,
        text: text,
        dateTime: dateTime,
        postImage: postImageUrl,
        likes: likes,
        postId: postId,
      );

      await FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .update(postModel.toMap());

      return right(null);
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PostModel>>> getPosts() async {
    try {
      List<PostModel> posts = [];
      QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore
          .instance
          .collection('posts')
          .orderBy('dateTime', descending: true)
          .get();
      for (var item in data.docs) {
        Map<String, dynamic> map = item.data();
        // get comments and add to map variable
        QuerySnapshot<Map<String, dynamic>> commentsData =
            await FirebaseFirestore.instance
                .collection('posts')
                .doc(map['postId'])
                .collection('comments')
                .orderBy('dateTime', descending: true)
                .get();
        List<Map<String, dynamic>> comments = [];
        for (var item in commentsData.docs) {
          comments.add(item.data());
        }
        map.addAll({'comments': comments});
        // print('-------------');
        // print(map);
        posts.add(PostModel.fromMap(map));
      }

      return right(posts);
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> updateLikePost(
      {required PostModel postModel}) async {
    try {
      if (postModel.likes!.contains(user.uId)) {
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(postModel.postId)
            .update({
          'likes': FieldValue.arrayRemove([user.uId]),
        });
        // update likes in postModel
        postModel.likes!.remove(user.uId);
      } else {
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(postModel.postId)
            .update({
          'likes': FieldValue.arrayUnion([user.uId]),
        });
        // update likes in postModel
        postModel.likes!.add(user.uId!);
      }
      return right(postModel.likes!.length);
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  // update like comment
  @override
  Future<Either<Failure, int>> updateLikeComment({
    required PostModel postModel,
    required CommentModel commentModel,
  }) async {
    try {
      if (commentModel.likes!.contains(user.uId)) {
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(postModel.postId)
            .collection('comments')
            .doc(commentModel.commentId)
            .update({
          'likes': FieldValue.arrayRemove([user.uId]),
        });
        // update likes in commentModel
        commentModel.likes!.remove(user.uId);
      } else {
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(postModel.postId)
            .collection('comments')
            .doc(commentModel.commentId)
            .update({
          'likes': FieldValue.arrayUnion([user.uId]),
        });
        // update likes in commentModel
        commentModel.likes!.add(user.uId!);
      }
      return right(commentModel.likes!.length);
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  // create comment
  @override
  Future<Either<Failure, void>> createComment({
    required String text,
    required String dateTime,
    required String postId,
  }) async {
    try {
      CommentModel commentModel = CommentModel(
        userId: user.uId,
        text: text,
        dateTime: dateTime,
        likes: const [],
      );

      CollectionReference commentsCollection = FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('comments');

      DocumentReference newCommentRef =
          await commentsCollection.add(commentModel.toMap());

      String newCommentId = newCommentRef.id;

      await newCommentRef.set(
        {'commentId': newCommentId},
        SetOptions(merge: true),
      );
      return right(null);
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  // update save post
  @override
  Future<Either<Failure, void>> updateSavePost(
      {required PostModel postModel}) async {
    try {
      if (user.savedPosts!.contains(postModel.postId)) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uId)
            .update({
          'savedPosts': FieldValue.arrayRemove([postModel.postId]),
        });
        // update savedPosts in user
        user.savedPosts!.remove(postModel.postId);
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uId)
            .update({
          'savedPosts': FieldValue.arrayUnion([postModel.postId]),
        });
        // update savedPosts in user
        user.savedPosts!.add(postModel.postId!);
      }
      return right(null);
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  // update follow user
  @override
  Future<Either<Failure, void>> updateFollowUser({required String uid}) async {
    try {
      if (user.following!.contains(uid)) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uId)
            .update({
          'following': FieldValue.arrayRemove([uid]),
        });
        // update following in user
        user.following!.remove(uid);
        await FirebaseFirestore.instance.collection('users').doc(uid).update({
          'followers': FieldValue.arrayRemove([user.uId]),
        });
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uId)
            .update({
          'following': FieldValue.arrayUnion([uid]),
        });
        // update following in user
        user.following!.add(uid);
        await FirebaseFirestore.instance.collection('users').doc(uid).update({
          'followers': FieldValue.arrayUnion([user.uId]),
        });
      }
      return right(null);
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  // delete post
  @override
  Future<Either<Failure, void>> deletePost(
      {required PostModel postModel}) async {
    try {
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(postModel.postId)
          .delete();
      return right(null);
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}
