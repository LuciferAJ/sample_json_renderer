import 'package:flutter/material.dart';
import 'package:sample_json_renderer/modules/home/widgets/custom_network_image.dart';
import 'package:sample_json_renderer/utils/extensions.dart';
import 'package:sample_json_renderer/utils/media_utils.dart';

abstract class BannerBase extends StatelessWidget {
  final String? title;
  final String? subHeading;
  final String? caption;
  final bool showNavIcon;
  final Widget bannerTypeWidget;
  final num borderRadius;
  final num contentPadding;
  const BannerBase(
      {super.key,
      required this.title,
      required this.bannerTypeWidget,
      required this.subHeading,
      required this.caption,
      this.borderRadius = 30.0,
      this.contentPadding = 20.0,
      this.showNavIcon = true});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: deviceHeight(context) * 0.55,
        child: Card(
          elevation: 20,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius.toDouble())),
          child: Stack(
            children: [
              bannerTypeWidget,
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Colors.black,
                          Colors.black87,
                          Colors.black54,
                          Colors.black26,
                          Colors.transparent
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                      borderRadius:
                          BorderRadius.circular(borderRadius.toDouble())),
                  child: Padding(
                    padding: EdgeInsets.all(contentPadding.toDouble()),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Text(subHeading ?? "",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: Colors.white)),
                            const SizedBox(
                              width: 10,
                            ),
                            Visibility(
                              visible: showNavIcon,
                              child: const Icon(
                                Icons.arrow_forward_rounded,
                                size: 20,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(title ?? "",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 32,
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(caption ?? "",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontSize: 22)),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BannerImage extends BannerBase {
  final String imageURL;
  final num bannerRadius;
  BannerImage(
      {super.key,
      required this.imageURL,
      required super.subHeading,
      required super.title,
      required super.caption,
      super.showNavIcon = true,
      super.contentPadding = 30.0,
      this.bannerRadius = 30.0})
      : super(
            borderRadius: bannerRadius,
            bannerTypeWidget: CustomNetworkImage(
              imageURL: imageURL,
              imageBuilder: (_, imageProvider) => Container(
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(bannerRadius.toDouble()),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.fill)),
              ),
            ));

  factory BannerImage.fromJson(Map<String, dynamic> json) => BannerImage(
        imageURL: json["image"],
        title: json["title"],
        subHeading: json["sub_heading"],
        caption: json["caption"],
        showNavIcon: json['show_icon'] ?? true,
        bannerRadius: json['banner_radius'] ?? 30.0,
        contentPadding: json['banner_content_padding'] ?? 20.0,
      );
}

class BannerColor extends BannerBase {
  final String colorCode;
  final num bannerRadius;

  BannerColor(
      {super.key,
      required this.colorCode,
      required super.title,
      required super.subHeading,
      required super.caption,
      super.showNavIcon,
      super.contentPadding = 20.0,
      this.bannerRadius = 30.0})
      : super(
            borderRadius: bannerRadius,
            bannerTypeWidget: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(bannerRadius.toDouble()),
                  color: Color(colorCode.parseToColorCode())),
            ));

  factory BannerColor.fromJson(Map<String, dynamic> json) => BannerColor(
        colorCode: json["color"],
        title: json["title"],
        subHeading: json["sub_heading"],
        caption: json["caption"],
        showNavIcon: json['show_icon'] ?? true,
        bannerRadius: json['banner_radius'] ?? 30.0,
        contentPadding: json['banner_content_padding'] ?? 20.0,
      );
}
