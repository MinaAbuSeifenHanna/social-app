import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'comment_model.dart';

class PostModel extends Equatable {
  final String? uId;
  final String? postImage;
  final String? text;
  final String? dateTime;
  final String? postId;
  final List<String>? likes;
  final List<CommentModel>? comments;

  const PostModel({
    this.uId,
    this.postImage,
    this.text,
    this.dateTime,
    this.postId,
    this.likes,
    this.comments,
  });

  factory PostModel.fromMap(Map<String, dynamic> data) => PostModel(
        uId: data['uId'] as String?,
        postImage: data['postImage'] as String?,
        text: data['text'] as String?,
        dateTime: data['dateTime'] as String?,
        postId: data['postId'] as String?,
        likes: data['likes'] != null
            ? List<String>.from(data['likes'] as List<dynamic>)
            : [],
        comments: data['comments'] != null
            ? List<CommentModel>.from(
                (data['comments'] as List<dynamic>).map(
                  (dynamic x) =>
                      CommentModel.fromMap(x as Map<String, dynamic>),
                ),
              )
            : [],
      );

  Map<String, dynamic> toMap() => {
        'uId': uId,
        'postImage': postImage,
        'text': text,
        'dateTime': dateTime,
        'postId': postId,
        'likes': likes,
        'comments': comments?.map((x) => x.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PostModel].
  factory PostModel.fromJson(String data) {
    return PostModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PostModel] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props {
    return [
      uId,
      postImage,
      text,
      dateTime,
      postId,
      likes,
      comments,
    ];
  }
}
