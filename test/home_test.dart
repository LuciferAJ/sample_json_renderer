import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sample_json_renderer/modules/home/views/home_page_view.dart';
import 'package:sample_json_renderer/modules/startup/views/splash_view.dart';
import 'package:sample_json_renderer/service/data_provider.dart';
import 'package:sample_json_renderer/utils/constants.dart';

Widget getHomePageView() => MaterialApp(
      title: 'Flutter Demo',
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

void main() {
  group('Splash Screen Widgets test', () {
    testWidgets('Tests', (widgetTester) async {
      await widgetTester.pumpWidget(getHomePageView());
      expect(
          find.image(const AssetImage(Constants.splashScreenImage)), findsOneWidget);
      await widgetTester.pumpAndSettle();
      expect(find.image(const AssetImage(Constants.splashScreenImage)), findsNothing);
    });
  });
  group('HomePage Scroll test', () {
    testWidgets('Tests', (widgetTester) async {
      await widgetTester.pumpWidget(getHomePageView());
      await widgetTester.pumpAndSettle(const Duration(seconds: 2));
      expect(find.text("Tasty Recipes"), findsOneWidget);
      await widgetTester.fling(
          find.byKey(const Key("home_page_key")), const Offset(0, -300), 2000);
      await widgetTester.pumpAndSettle();
      expect(find.text('Tasty Recipes'), findsNothing);
    });
  });
}
