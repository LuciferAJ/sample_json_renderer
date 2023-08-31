import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:sample_json_renderer/service/json_parser.dart';
import 'package:sample_json_renderer/utils/constants.dart';

void main() {
  group('Testing Widget Mapper', () {
    final WidgetService widgetService = WidgetService();

    test('Test for banner for image', () {
      final widgetMap = {'type': "banner", 'image': "https://dummy.png"};
      final WidgetType widgetType = widgetService.getWidgetType(widgetMap);
      expect(widgetType == WidgetType.bannerImage, true);
    });

    test('Test for banner for color', () {
      final widgetMap = {'type': "banner", 'color': "23ab32"};
      final WidgetType widgetType = widgetService.getWidgetType(widgetMap);
      expect(widgetType == WidgetType.bannerColor, true);
    });

    test('Test for circular_item', () {
      final widgetMap = {
        'type': "circular_item",
      };
      final WidgetType widgetType = widgetService.getWidgetType(widgetMap);
      expect(widgetType == WidgetType.itemCircular, true);
    });
  });

  group('Testing App Theme Brightness', () {
    final WidgetService widgetService = WidgetService();

    test('Test for getting light theme', () {
      final appTheme = widgetService.convertAppTheme('light');
      expect(appTheme == Brightness.light, true);
    });
  });
}
