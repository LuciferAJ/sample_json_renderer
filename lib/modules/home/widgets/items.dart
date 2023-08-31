import 'package:flutter/material.dart';
import 'package:sample_json_renderer/modules/home/widgets/custom_network_image.dart';
import 'package:sample_json_renderer/utils/media_utils.dart';

abstract class ItemBase extends StatelessWidget {
  final String imageUrl;
  final String caption;
  final ShapeBorder shape;

  const ItemBase(
      {super.key,
      required this.imageUrl,
      required this.caption,
      required this.shape});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: deviceHeight(context) * 0.1,
      child: Column(
        children: [
          SizedBox.square(
            dimension: deviceHeight(context) * 0.1,
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: Center(
                child: Card(
                  shape: shape,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: CustomNetworkImage(
                        imageURL: imageUrl,
                        imageBuilder: (_, imageProvider) => Container(
                              height: deviceHeight(context) * 0.1,
                              width: deviceHeight(context) * 0.1,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                ),
                              ),
                            ),
                        errorWidget: (_, __, ___) => SizedBox.square(
                            dimension: deviceHeight(context) * 0.1,
                            child: const Icon(Icons.error))),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              caption,
              maxLines: 2,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}

class ItemCircular extends ItemBase {
  const ItemCircular(
      {super.key, required super.imageUrl, required super.caption})
      : super(shape: const CircleBorder());

  factory ItemCircular.fromJson(Map<String, dynamic> json) => ItemCircular(
        caption: json["text"] ?? "",
        imageUrl: json["image"] ?? "",
      );
}

class ItemBox extends ItemBase {
  ItemBox({super.key, required super.imageUrl, required super.caption})
      : super(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)));
  factory ItemBox.fromJson(Map<String, dynamic> json) => ItemBox(
        caption: json["text"] ?? "",
        imageUrl: json["image"] ?? "",
      );
}
