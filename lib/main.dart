import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:live_stream_app/ui/home_screen.dart';

import 'amplifyconfiguration.dart';
import 'models/ModelProvider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await configureAmplify();
  runApp(const MyApp());
}

final AmplifyDataStore _dataStorePlugin = AmplifyDataStore(modelProvider: ModelProvider.instance);

Future<void> configureAmplify() async {
  try {
    await Amplify.addPlugins([_dataStorePlugin]);
    await Amplify.configure(amplifyconfig);
    print('Amplify configured successfully');
  } catch (err) {
    print('Error configuring Amplify: $err');  }
}


  class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
