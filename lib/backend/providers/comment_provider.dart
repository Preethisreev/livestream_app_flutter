import 'package:amplify_api/amplify_api.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:live_stream_app/backend/repositories/comment_repository.dart';
import 'package:live_stream_app/models/Comment.dart';

class CommentProvider with ChangeNotifier {
  final _commentRepository = CommentRepository();

  bool _isLoading = false;
  List<Comment> _comments = [];
  String? _errorMessage;

  bool get isLoading => _isLoading;

  List<Comment> get comments => _comments;

  String? get errorMessages => _errorMessage;

  void setCurrentSessionId(String sessionId) {}

  void _setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // コメントを送信するメソッド
  Future<Either<String, Comment?>> sendComment(Comment comment) {
    return _commentRepository.sendComment(comment);
  }

  // コメントを取得するメソッド
  //get comments from the repository
  void getComments() async {
    _setIsLoading(true);
    final commentResponse = await _commentRepository.getComments();
    commentResponse.fold(
      (error) {
        _errorMessage = error;
        notifyListeners();
      },
      (comments) {
        _comments = comments;
        notifyListeners();
      },
    );
    _setIsLoading(false);
  }

  Stream<GraphQLResponse<Comment>> getCommentsStream() {
    return _commentRepository.subscribeToComments();
  }

  // コメントを追加するメソッド
  void addComment(Comment comment) {
    _comments.insert(0, comment);
    notifyListeners();
  }

  // コメントをクリアするメソッド
  void clearComments() {
    _comments = [];
    notifyListeners();
  }
}
