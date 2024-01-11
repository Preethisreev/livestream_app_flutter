// ignore_for_file: use_build_context_synchronously
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:live_stream_app/backend/utils/permission.dart';
import 'package:live_stream_app/constants/colors.dart';
import 'package:live_stream_app/ui/home_screen.dart';
import 'package:live_stream_app/ui/livestream_screen.dart';
import 'package:uuid/uuid.dart';
import 'package:zego_express_engine/zego_express_engine.dart';

import '../constants/zego_env.dart';

class CreateScreen extends StatefulWidget {

  CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  late String roomName;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _livenameController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestPermission();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 320,
                child: TextField(
                  controller: _nameController,
                  cursorColor: Colors.blue,
                  cursorHeight: 30,
                  textAlign: TextAlign.justify,
                  decoration:
                  const InputDecoration(
                    hintText: 'Your name',
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 9.0, horizontal: 16.0),
                    // Adjust padding as needed
                    isDense: true,
                    hintStyle: TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.w500,
                        fontSize: 18
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: buttonBlue,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black87
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30,),
              SizedBox(
                width: 320,
                child: TextField(
                  controller: _livenameController,
                  cursorColor: Colors.blue,
                  cursorHeight: 30,
                  textAlign: TextAlign.justify,
                  decoration:
                  const InputDecoration(
                    hintText: 'Live name',
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 9.0, horizontal: 16.0),
                    // Adjust padding as needed
                    isDense: true,
                    hintStyle: TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.w500,
                        fontSize: 18
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: buttonBlue,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black87
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 35),
              Column(
                children: [
                  // watch live blue button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(320, 50),
                      backgroundColor: buttonBlue,
                      foregroundColor: Colors.indigo,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LiveStreamScreen(
                            username:_nameController.text ,
                            isHost: true,
                            userIdentity: getUserIdentity(),
                            livename: _nameController.text,
                          ),
                        ),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(CupertinoIcons.paperplane_fill, color: Colors
                              .white, size: 25),
                          SizedBox(width: 8),
                          Text(' Create Live',
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
                  const SizedBox(height: 30),
                  // back white button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(320, 50),
                      backgroundColor: buttonWhite,
                      foregroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()
                        ),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(CupertinoIcons.paperplane_fill, color: Colors
                              .black, size: 25),
                          SizedBox(width: 8),
                          Text(' Back',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.normal
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> getUserIdentity() async {
    try {
      // Generate a unique user identity using UUID
      String userIdentity = const Uuid().v4();
      print(userIdentity);
      return userIdentity;
    } catch (e) {
      print("Error generating user identity: $e");
      throw Exception("Error generating user identity");
    }
  }
}
