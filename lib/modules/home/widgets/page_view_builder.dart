import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sample_json_renderer/utils/media_utils.dart';

abstract class DynamicPageBuilder extends StatefulWidget {
  final List<Widget> itemList;
  final Axis direction;
  const DynamicPageBuilder({
    required this.itemList,
    required this.direction,
    super.key,
  });

  @override
  State<DynamicPageBuilder> createState() => _DynamicPageBuilderState();
}

class _DynamicPageBuilderState extends State<DynamicPageBuilder> {
  final PageController pageController = PageController(viewportFraction: 0.9);
  late Timer _pageScrollTimer;
  int _currentPageIndex = 0;
  @override
  void initState() {
    super.initState();
    if (widget.itemList.length > 1) {
      _pageScrollTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
        if (_currentPageIndex < widget.itemList.length - 1) {
          _currentPageIndex++;
        } else {
          _currentPageIndex = 0;
        }
        pageController.animateToPage(_currentPageIndex,
            duration: const Duration(milliseconds: 300),
            curve: Curves.fastOutSlowIn);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _pageScrollTimer.cancel();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: deviceHeight(context) * 0.57,
      child: PageView.builder(
          padEnds: false,
          onPageChanged: (pageIndex) {
            setState(() {
              _currentPageIndex = pageIndex;
            });
          },
          physics: const BouncingScrollPhysics(),
          controller: pageController,
          scrollDirection: widget.direction,
          itemBuilder: (_, int index) => Padding(
                padding: EdgeInsets.only(
                    left: _currentPageIndex == widget.itemList.length - 1
                        ? 0
                        : 30.0,
                    right: _currentPageIndex == widget.itemList.length - 1
                        ? 30
                        : 0),
                child: widget.itemList[index],
              ),
          itemCount: widget.itemList.length),
    );
  }
}

class HorizontalPageViewBuilder extends DynamicPageBuilder {
  const HorizontalPageViewBuilder({
    super.key,
    required super.itemList,
  }) : super(direction: Axis.horizontal);
}

class PageViewWidget extends StatelessWidget {
  final Widget listWidget;
  final String? title;
  const PageViewWidget(
      {super.key, required this.title, this.listWidget = const SizedBox()});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
          visible: title != null,
          child: Text(title ?? "",
              style:
                  const TextStyle(fontWeight: FontWeight.w800, fontSize: 26)),
        ),
        const SizedBox(
          height: 20,
        ),
        listWidget
      ],
    );
  }
}
