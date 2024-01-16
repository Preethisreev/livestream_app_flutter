import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:live_stream_app/amplifyconfiguration.dart';
import 'package:live_stream_app/backend/providers/comment_provider.dart';
import 'package:live_stream_app/models/ModelProvider.dart';
import 'package:live_stream_app/ui/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

//main function メイン関数
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureAmplify();
  ZegoUIKit().initLog().then((value) {
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CommentProvider()),
      ],
      child: const MyApp(),
    ));
  });
}

//Function to configure amplify, Amplifyを構成する関数
Future<void> configureAmplify() async {
  try {
    // Creating an instance of Amplify API with a model provider
    // モデルプロバイダを使用してAmplify APIのインスタンスを作成
    final api = AmplifyAPI(modelProvider: ModelProvider.instance);
    await Amplify.addPlugins([api]);
    await Amplify.configure(amplifyconfig);
    // Print a success message if configuration is successful
    // 構成が成功した場合は成功メッセージを表示
    safePrint("Amplify configured successfully");
  } catch (e) {
    // Print an error message if configuration fails
    // 構成が失敗した場合はエラーメッセージを表示
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
