import 'dart:convert';

import 'package:equatable/equatable.dart';

class MessageModel extends Equatable {
  final String? senderId;
  final String? receiverId;
  final String? text;
  final String? dateTime;

  const MessageModel({
    this.senderId,
    this.receiverId,
    this.text,
    this.dateTime,
  });

  factory MessageModel.fromMap(Map<String, dynamic> data) => MessageModel(
        senderId: data['senderId'] as String?,
        receiverId: data['receiverId'] as String?,
        text: data['text'] as String?,
        dateTime: data['dateTime'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'senderId': senderId,
        'receiverId': receiverId,
        'text': text,
        'dateTime': dateTime,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MessageModel].
  factory MessageModel.fromJson(String data) {
    return MessageModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [MessageModel] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [senderId, receiverId, text, dateTime];
}
