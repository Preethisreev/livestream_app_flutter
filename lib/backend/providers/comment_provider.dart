import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:live_stream_app/backend/repositories/comment_repository.dart';
import 'package:live_stream_app/models/Comment.dart';

class CommentProvider with ChangeNotifier{
  final _commentRepository = CommentRepository( );
    Future<Either<String, Comment?>> sendComment(Comment comment){
      return _commentRepository.sendComment(comment);
}

}