
import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:live_stream_app/backend/providers/comment_provider.dart';
import 'package:live_stream_app/constants/colors.dart';
import 'package:live_stream_app/models/Comment.dart';
import 'package:provider/provider.dart';

class CommentSection extends StatefulWidget {
  final String username;
  final bool isHost;
  final Future<String> userIdentity;
  final String sessionId;
  const CommentSection({super.key, required this.username, required this.isHost, required this.userIdentity, required this.sessionId});

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final TextEditingController commentController = TextEditingController();
  List<Comment> comments = [];
  // List to store comments
  late StreamSubscription _commentSubscription;
  @override
  void initState() {
    getComments();
    super.initState();
  }

  void getComments(){
    final commentProvider = context.read<CommentProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      commentProvider.getComments();
      _commentSubscription = commentProvider.getCommentsStream().listen(
              (response) {
                print("Received comment response: $response");
            if(response.data != null){
              commentProvider.addComment(response.data!);
            } else if (response.hasErrors){
              print("Error in getting comments: ${response.errors}");
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Error in getting comments"),
                  duration:Duration(seconds: 2),
                ),
              );
            }
          });
    });
  }
  @override
  void dispose() {
    _commentSubscription.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Consumer<CommentProvider>(
              builder: (_, commProvider, __) {
                if (commProvider.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (commProvider.errorMessages != null){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Error"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
                return  ListView.builder(
                  reverse:false,
                  itemCount: commProvider.comments.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const CircleAvatar(
                        backgroundImage: NetworkImage('https://cdn2.iconfinder.com/data/icons/business-and-finance-related-hand-gestures/256/face_female_blank_user_avatar_mannequin-512.png'),
                      ),
                      title: Text(commProvider.comments[index].username),
                      subtitle: Text(commProvider.comments[index].comment),
                    );
                  },
                );
              }
          ),
        ),
        CommentInput(onCommentSubmitted: (text) {
          widget.userIdentity.then((userIdentity) {
            setState(() {
              comments.add(Comment(
                username: widget.username,
                userImage:
                'https://cdn2.iconfinder.com/data/icons/business-and-finance-related-hand-gestures/256/face_female_blank_user_avatar_mannequin-512.png', // Set the actual user image URL
                comment: text,
                userIdentity:userIdentity, sessionId: widget.sessionId,
              ));
            });
          });
        }, username: widget.username, isHost: widget.isHost, userIdentity: widget.userIdentity, sessionId:widget.sessionId,),
      ],
    );
  }

}

class CommentInput extends StatefulWidget {
  final Function(String) onCommentSubmitted;
  final String username;
  final bool isHost;
  final  Future<String> userIdentity;
  final String sessionId;
  const CommentInput({super.key, required this.onCommentSubmitted, required this.username, required this.isHost, required this.userIdentity, required this.sessionId});
  @override
  State<CommentInput> createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  late final TextEditingController _commentController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    _commentController;
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0,bottom: 10.0),
                child:TextFormField(
                  textInputAction: TextInputAction.send,
                  controller: _commentController,
                  cursorColor: Colors.blue,
                  cursorHeight: 30,
                  textAlign: TextAlign.justify,
                  decoration: const InputDecoration(
                    hintText: 'Comment',
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 9.0,
                        horizontal: 16.0), // Adjust padding as needed
                    isDense: true,
                    hintStyle: TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: buttonBlue,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black87),
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    ),
                  ),
                ),
              )),
          IconButton(
            icon: const Icon(Icons.send, color: buttonBlue),
            onPressed: () {
              if (_commentController.text.trim().isNotEmpty) {
                widget.userIdentity.then((userIdentity) async {
                  final comment = Comment(username: widget.username,comment:_commentController.text, userImage: 'https://cdn2.iconfinder.com/data/icons/business-and-finance-related-hand-gestures/256/face_female_blank_user_avatar_mannequin-512.png',userIdentity: userIdentity, sessionId: widget.sessionId);
                  final response = await context.read<CommentProvider>().sendComment(comment);
                  response.fold(
                        (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Error: $error"),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }, (resComment) {
                    safePrint('success');
                  },
                  );
                  widget.onCommentSubmitted(_commentController.text);
                  _commentController.clear();
                });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Error: Comment cannot be empty"),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}