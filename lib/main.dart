import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:live_stream_app/amplifyconfiguration.dart';
import 'package:live_stream_app/backend/providers/comment_provider.dart';
import 'package:live_stream_app/models/ModelProvider.dart';
import 'package:live_stream_app/ui/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await configureAmplify();
  ZegoUIKit().initLog().then((value) {
    runApp(
        MultiProvider(providers: [
          ChangeNotifierProvider(create: (context) => CommentProvider()),
        ],
          child: const MyApp(),
        )

    );
    });
}



Future<void> configureAmplify() async{
  try{
    final api = AmplifyAPI(modelProvider: ModelProvider.instance);
    await Amplify.addPlugins([api]);
    await Amplify.configure(amplifyconfig);
    safePrint("Amplify configured successfully");
  }catch(e){
    safePrint("Error configuring Amplify: $e");
  }
}

  class MyApp extends StatefulWidget {
  
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Twilio Video Streaming App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
