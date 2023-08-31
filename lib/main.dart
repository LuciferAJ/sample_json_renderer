import 'package:flutter/material.dart';
import 'package:sample_json_renderer/modules/home/views/home_page_view.dart';
import 'package:sample_json_renderer/modules/startup/views/splash_view.dart';
import 'package:sample_json_renderer/service/data_provider.dart';

void main() async {
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
  Widget build(BuildContext context) {
    return StreamBuilder<Brightness>(
        stream: AppThemeProvider().stream,
        builder: (context, snapshot) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              brightness: snapshot.data,
              primarySwatch: Colors.deepPurple,
            ),
            home: FutureBuilder(
                future: Future.wait([
                  DataProvider.instance.initializeHomePageJson(),
                ]),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const SplashView();
                  } else {
                    return const HomePageView();
                  }
                }),
          );
        });
  }
}
