import 'package:live_stream_app/models/Comment.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dartz/dartz.dart';

class CommentRepository {
  // コメントを送信するメソッド
  //send comment method
  Future<Either<String, Comment?>> sendComment(Comment comment) async {
    try {
      // AmplifyのAPIを使用してコメントを作成
      //creating a comment with amplify API
      final request = ModelMutations.create(comment);
      final response = await Amplify.API.mutate(request: request).response;
      return right(response.data);
    } on ApiException catch (e) {
      return left(e.message);
    }
  }

  // コメントを取得するメソッド
  Future<Either<String, List<Comment>>> getComments({String? sessionId}) async {
    try {
      // AmplifyのAPIを使用してコメントをクエリ
      //Query the comments
      final request = ModelQueries.list(Comment.classType, limit: 20);
      final response = await Amplify.API.query(request: request).response;
      var comments = response.data?.items.whereType<Comment>().toList();
      // セッションIDに基づいてコメントをフィルタリング
      // Filter comments based on session ID
      if (sessionId != null) {
        comments = comments
            ?.where((comment) => comment.sessionId == sessionId)
            .toList();
      }
      // コメントをフィルタリングおよびソート
      //filter and sort comments based on createdAt
      if (comments != null) {
        comments = comments.where((comment) {
          return comment.createdAt != null &&
              DateTime.parse(comment.createdAt!.format())
                  .isAfter(DateTime.now());
        }).toList();
        comments.sort((a, b) {
          return b.createdAt!.compareTo(a.createdAt!);
        });
      }
      return right(comments ?? []);
    } on ApiException catch (e) {
      return left(e.message);
    }
  }

  Stream<GraphQLResponse<Comment>> subscribeToComments() {
    // コメントの新規作成を購読するためのサブスクリプションリクエスト
    //subscription request to request newly created comments
    final subscriptionRequest = ModelSubscriptions.onCreate(Comment.classType);
    // AmplifyのAPIを使用してサブスクリプションを確立
    //subscribe the comments using amplify API
    final operation = Amplify.API.subscribe(
      subscriptionRequest,
      onEstablished: () => safePrint("Subscription established"),
    );
    return operation;
  }
}
