import 'package:flutter/material.dart';
import 'package:sample_json_renderer/service/json_parser.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: ListView(
          key: const Key("home_page_key"),
          shrinkWrap: true,
          children: JsonParser.instance.getParsedWidgets,
        ),
      ),
    );
  }
}
