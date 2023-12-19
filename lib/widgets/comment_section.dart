
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
  const CommentSection({super.key, required this.username, required this.isHost, required this.userIdentity});

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final TextEditingController commentController = TextEditingController();
  List<Comment> comments = [];
  // List to store comments

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: comments.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const CircleAvatar(
                  backgroundImage: NetworkImage('https://i.pinimg.com/originals/7d/34/d9/7d34d9d53640af5cfd2614c57dfa7f13.png'),
                ),
                title: Text(comments[index].username),
                subtitle: Text(comments[index].comment),
              );
            },
          ),
        ),
        CommentInput(onCommentSubmitted: (text) {
    widget.userIdentity.then((userIdentity) {
          setState(() {
            comments.add(Comment(
              username: widget.username,
              userImage:
              'https://i.pinimg.com/originals/7d/34/d9/7d34d9d53640af5cfd2614c57dfa7f13.png', // Set the actual user image URL
              comment: text,
              userIdentity:userIdentity,
            ));
          });
          });
        }, username: widget.username, isHost: widget.isHost, userIdentity: widget.userIdentity,),
      ],
    );
  }

}

class CommentInput extends StatefulWidget {
  final Function(String) onCommentSubmitted;
  final String username;
  final bool isHost;
  final  Future<String> userIdentity;
  const CommentInput({super.key, required this.onCommentSubmitted, required this.username, required this.isHost, required this.userIdentity});
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
                  final comment = Comment(username: widget.username,comment:_commentController.text, userImage: 'https://i.pinimg.com/originals/7d/34/d9/7d34d9d53640af5cfd2614c57dfa7f13.png',userIdentity: userIdentity);
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
                // Optionally, you can display a message or perform some action
                // to inform the user that they need to enter a non-empty comment.
              }
            },
          ),
        ],
      ),
    );
  }
}