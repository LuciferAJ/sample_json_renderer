import 'package:flutter/material.dart';
import 'package:sample_json_renderer/modules/home/widgets/banner_widget.dart';
import 'package:sample_json_renderer/modules/home/widgets/items.dart';
import 'package:sample_json_renderer/modules/home/widgets/list_builder.dart';
import 'package:sample_json_renderer/modules/home/widgets/page_view_builder.dart';
import 'package:sample_json_renderer/modules/home/widgets/text_widget.dart';
import 'package:sample_json_renderer/service/data_provider.dart';
import 'package:sample_json_renderer/utils/constants.dart';

class JsonParser {
  static final JsonParser instance = JsonParser._internal();

  factory JsonParser() {
    return instance;
  }

  JsonParser._internal() {
    initializeAppTheme();
    initializeHomePageWidgets();
  }

  final _homepageJson = DataProvider.getHomePageJson;
  static final List<Widget> _widgets = [];
  static Brightness _appTheme = Brightness.light;
  List<Widget> get getParsedWidgets => _widgets;
  Brightness get getAppTheme => _appTheme;
  WidgetService widgetServices = WidgetService();

  void initializeAppTheme() {
    if (_homepageJson.containsKey('app') &&
        _homepageJson['app'] != null &&
        _homepageJson['app'].containsKey('theme') &&
        _homepageJson['app']['theme'] != null) {
      _appTheme = widgetServices.convertAppTheme(_homepageJson['app']['theme']);
      AppThemeProvider.instance.brightnessController.add(_appTheme);
    }
  }

  void initializeHomePageWidgets() {
    if (_homepageJson.containsKey('home_page') &&
        _homepageJson['home_page'] != null &&
        _homepageJson['home_page'].containsKey('widgets') &&
        _homepageJson['home_page']['widgets'] != null) {
      _widgets.addAll((_homepageJson['home_page']['widgets'] as List)
          .map((widget) => widgetServices.widgetMapper(widget)));
    }
  }
}

class WidgetService {
  WidgetType getWidgetType(Map<String, dynamic> widget) {
    if (widget.containsKey('type') || widget['type'] != null) {
      switch (widget['type']) {
        case 'heading':
          return WidgetType.heading;
        case 'sub_heading':
          return WidgetType.subHeading;
        case 'banner':
          if (widget.containsKey("image")) {
            return WidgetType.bannerImage;
          }
          if (widget.containsKey("color")) {
            return WidgetType.bannerColor;
          }
          return WidgetType.none;
        case 'banner_list':
          return WidgetType.bannerList;
        case 'horizontal_list':
          return WidgetType.horizontalItemList;
        case 'circular_item':
          return WidgetType.itemCircular;
        case 'box_item':
          return WidgetType.itemBox;
        case 'spacer':
          return WidgetType.spacer;
        default:
          return WidgetType.none;
      }
    } else {
      return WidgetType.none;
    }
  }

  Widget widgetMapper(Map<String, dynamic> widget) {
    final widgetType = getWidgetType(widget);

    switch (widgetType) {
      case WidgetType.none:
        return const SizedBox();
      case WidgetType.bannerColor:
        return BannerColor.fromJson(widget);
      case WidgetType.bannerImage:
        return BannerImage.fromJson(widget);
      case WidgetType.bannerList:
        return PageViewWidget(
            title: widget['title'],
            listWidget: HorizontalPageViewBuilder(
              itemList: buildList(widget),
            ));
      case WidgetType.itemBox:
        return ItemBox.fromJson(widget);
      case WidgetType.itemCircular:
        return ItemCircular.fromJson(widget);
      case WidgetType.horizontalItemList:
        return ScrollableListWidget(
            title: widget['title'],
            listWidget: HorizontalListBuilder(
              spacing: widget['spacing'],
              itemList: buildList(widget),
            ));
      case WidgetType.heading:
        return CustomTextWidget.headline(widget['title']);
      case WidgetType.subHeading:
        return CustomTextWidget.subHeading(widget['title']);
      case WidgetType.spacer:
        return SizedBox(
          height: widget['height']?.toDouble(),
          width: widget['width']?.toDouble(),
        );
    }
  }

  List<Widget> buildList(Map<String, dynamic> widget) {
    List<Widget> itemList = [];
    if (widget.containsKey('items') && widget['items'] != null) {
      itemList
          .addAll((widget['items'] as List).map((item) => widgetMapper(item)));
    }
    return itemList;
  }

  Brightness convertAppTheme(String appTheme) {
    if (appTheme == 'light') {
      return Brightness.light;
    } else {
      return Brightness.dark;
    }
  }
}
