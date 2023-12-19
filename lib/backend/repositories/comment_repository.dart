import 'package:live_stream_app/models/Comment.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dartz/dartz.dart';

class CommentRepository{
  Future<Either<String,Comment?>> sendComment(Comment comment) async{
    try{
      final request = ModelMutations.create(comment);
      final response = await Amplify.API.mutate(request: request).response;
      return right(response.data);
    } on ApiException catch(e){
      return left(e.message);
    }
  }
}