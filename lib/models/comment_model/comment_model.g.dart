// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      id: json['id'] as int?,
      comment: json['comment'] as String?,
      score: json['score'] as int?,
      parent: json['parent'] as String?,
      user: json['user'] as String?,
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'comment': instance.comment,
      'score': instance.score,
      'parent': instance.parent,
      'user': instance.user,
    };
