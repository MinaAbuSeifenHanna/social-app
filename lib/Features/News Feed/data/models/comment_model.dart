import 'dart:convert';

import 'package:equatable/equatable.dart';

class CommentModel extends Equatable {
  final String? commentId;
  final String? userId;
  final String? text;
  final String? dateTime;
  final List<String>? likes;

  const CommentModel({
    this.commentId,
    this.userId,
    this.text,
    this.dateTime,
    this.likes,
  });

  factory CommentModel.fromMap(Map<String, dynamic> data) => CommentModel(
        commentId: data['commentId'] as String?,
        userId: data['userId'] as String?,
        text: data['text'] as String?,
        dateTime: data['dateTime'] as String?,
        likes: data['likes'] != null
            ? List<String>.from(data['likes'] as List<dynamic>)
            : [],
      );

  Map<String, dynamic> toMap() => {
        'commentId': commentId,
        'userId': userId,
        'text': text,
        'dateTime': dateTime,
        'likes': likes,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CommentModel].
  factory CommentModel.fromJson(String data) {
    return CommentModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CommentModel] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [commentId, userId, text, dateTime, likes];
}
