import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'comment_model.g.dart';

@JsonSerializable()
class Comment extends Equatable {
  final int? id;
  final String? comment;
  final int? score;
  final String? parent;
  final String? user;
  const Comment({
    this.id,
    this.comment,
    this.score,
    this.parent,
    this.user,
  });

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);

  @override
  List<Object?> get props => [
        id,
        comment,
        score,
        parent,
        user,
      ];
}
