import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sample_json_renderer/utils/media_utils.dart';

abstract class DynamicListBuilder extends StatelessWidget {
  final List<Widget> itemList;
  final Axis direction;
  final num? spacing;
  const DynamicListBuilder({
    required this.itemList,
    required this.direction,
    this.spacing,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: deviceHeight(context) * 0.15,
      child: Padding(
        padding: const EdgeInsets.only(left: 30.0),
        child: ListView.separated(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: direction,
            itemBuilder: (_, int index) => itemList[index],
            separatorBuilder: (_, int index) => SizedBox.square(
                  dimension: (spacing ?? 20).toDouble(),
                ),
            itemCount: itemList.length),
      ),
    );
  }
}

class HorizontalListBuilder extends DynamicListBuilder {
  const HorizontalListBuilder(
      {super.key, required super.itemList, super.spacing})
      : super(direction: Axis.horizontal);
}

class ScrollableListWidget extends StatelessWidget {
  final Widget listWidget;
  final String? title;
  final num? spacing;
  const ScrollableListWidget(
      {super.key,
      required this.title,
      this.spacing,
      this.listWidget = const SizedBox()});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
          visible: title != null,
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Text(title ?? "",
                style:
                    const TextStyle(fontWeight: FontWeight.w800, fontSize: 26)),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        listWidget
      ],
    );
  }
}
