
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:live_stream_app/constants/colors.dart';
import 'package:live_stream_app/ui/create_screen.dart';
import 'package:live_stream_app/ui/join_screen.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 55),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(480, 95),
                  backgroundColor: buttonGreen,
                  foregroundColor: Colors.teal,
                  padding: const EdgeInsets.all(15),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>JoinScreen()),
                );
              },
              child: const  Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 0, right: 15),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage('https://www.gravatar.com/avatar/2c7d99fe281ecd3bcd65ab915bac6dd5?s=250'),
                    ),
                  ),
                 Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text('Elon Reeve Musk',
                           style: TextStyle(
                        color: Colors.white,
                             fontSize: 22,
                             fontWeight: FontWeight.w400
                      )),
                      Text('Special Live',style: TextStyle(
                        color: buttonTextSub,
                        fontSize: 21,
                        fontWeight: FontWeight.w400
                      ))
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 30),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonBlue,
              foregroundColor: Colors.indigo,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(19),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateScreen()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(15.0),
              child: SizedBox(
                width: 240,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(CupertinoIcons.paperplane_fill,color: Colors.white,size:28),
                    SizedBox(width: 8),
                    Text('Create Video Streaming',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.normal
                    ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
