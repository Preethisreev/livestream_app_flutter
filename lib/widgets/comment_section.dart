import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:live_stream_app/constants/colors.dart';

class CommentSection extends StatefulWidget {
  final String username;
  final bool isHost;
  const CommentSection({super.key, required this.username, required this.isHost});




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
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(comments[index].userImage),
                ),
                title: Text(comments[index].userName),
                subtitle: Text(comments[index].text),
              );
            },
          ),
        ),
        CommentInput(onCommentSubmitted: (text) {
          setState(() {
            comments.add(Comment(
              userName: widget.username,
              userImage:
              'https://i.pinimg.com/originals/7d/34/d9/7d34d9d53640af5cfd2614c57dfa7f13.png', // Set the actual user image URL
              text: text,
            ));
          });
        }, username: '', isHost: widget.isHost),
      ],
    );
  }
  Future<void> saveComment() async{
    final newComment = Comment(
        userName: widget.username,
        userImage:'https://i.pinimg.com/originals/7d/34/d9/7d34d9d53640af5cfd2614c57dfa7f13.png', // Set the actual user image URL,
        text: commentController.text
    );
    try{
      await Amplify.DataStore.save(newComment);
    } on DataStoreException catch(e){
      safePrint('Something went wrong saaving model:${e.message}');
    }
  }

}

class CommentInput extends StatefulWidget {
  final Function(String) onCommentSubmitted;
  final String username;
  final bool isHost;
  const CommentInput({super.key, required this.onCommentSubmitted, required this.username, required this.isHost});
  @override
  State<CommentInput> createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  final TextEditingController _commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0,bottom: 10.0),
                child:TextField(
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
                widget.onCommentSubmitted(_commentController.text);
                _commentController.clear();
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

class Comment {
  final String userName;
  final String userImage;
  final String text;

  Comment({
    required this.userName,
    required this.userImage,
    required this.text,
  });
}