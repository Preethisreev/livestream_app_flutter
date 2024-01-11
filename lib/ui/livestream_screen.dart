
import 'package:flutter/material.dart';
import 'package:live_stream_app/widgets/comment_section.dart';
import 'package:live_stream_app/widgets/videoChatScreenTestUI.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../backend/providers/comment_provider.dart';


class LiveStreamScreen extends StatefulWidget {
  final String username;
  final bool isHost;
  final Future<String> userIdentity;
  final String livename;

  const LiveStreamScreen({
    Key? key,
    required this.username,
    required this.isHost,
    required this.userIdentity,
    required this.livename,
  }) : super(key: key);

  @override
  State<LiveStreamScreen> createState() => _LiveStreamScreenState();
}

class _LiveStreamScreenState extends State<LiveStreamScreen> {
  late Future<String> userIdentity;
  late String livename;
  late String sessionId;

  void startNewSession() {
    final commentProvider = context.read<CommentProvider>();

    // Set a new session ID (you can use a UUID or any unique identifier)
    final newSessionId = Uuid().v4();
    commentProvider.setCurrentSessionId(newSessionId);
    print('new session id is $newSessionId');
    // Clear existing comments for the new session
    commentProvider.clearComments();
    setState(() {
      sessionId = newSessionId;
    });
  }


  @override
  void initState() {
    super.initState();
    userIdentity = widget.userIdentity;
    livename = widget.livename;
    startNewSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10, top: 30),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 15, bottom: 2),
                  child: CircleAvatar(
                    radius: 21,
                    backgroundImage: NetworkImage(
                        'https://www.gravatar.com/avatar/2c7d99fe281ecd3bcd65ab915bac6dd5?s=250'),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Elon Reeve Musk',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15,
                            fontWeight: FontWeight.w400)),
                    Text('Special Live',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        )),
                  ],
                ),
              ],
            ),
          ),
          AspectRatio(
            aspectRatio: 1.199,
            child: SizedBox(
              width: double.infinity,
              child: FutureBuilder<String>(
                future: userIdentity,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return VideoChatWidget(
                      userIdentity: snapshot.data!,
                      livename: livename,
                      isHost: widget.isHost,
                    );
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: CommentSection(username: widget.username, isHost: widget.isHost, userIdentity: widget.userIdentity, sessionId: sessionId,),
          ),
        ],
      ),
    );
  }
}