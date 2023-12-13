import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:live_stream_app/ui/home_screen.dart';

import 'amplifyconfiguration.dart';
import 'models/ModelProvider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}



  class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }
  Future<void> _configureAmplify() async {
    // Add the following lines to your app initialization to add the DataStore plugin
    final datastorePlugin =
    AmplifyDataStore(modelProvider: ModelProvider.instance);
    await Amplify.addPlugin(datastorePlugin);

    try {
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      safePrint(
          'Tried to reconfigure Amplify; this can occur when your app restarts on Android.');
    }
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Twilio Video Streaming App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen()
    );
  }
}
