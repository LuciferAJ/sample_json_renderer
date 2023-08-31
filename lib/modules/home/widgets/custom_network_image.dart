import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageURL;
  final Widget Function(BuildContext, ImageProvider<Object>) imageBuilder;
  final Widget Function(BuildContext, String, dynamic)? errorWidget;
  const CustomNetworkImage(
      {required this.imageURL,
      required this.imageBuilder,
      this.errorWidget,
      super.key});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageURL,
      fit: BoxFit.fill,
      imageBuilder: imageBuilder,
      placeholder: (context, url) => const CircularProgressIndicator(
        color: Colors.white,
      ),
      errorWidget: errorWidget ??
          (context, url, error) => const Center(child: const Icon(Icons.error)),
    );
  }
}
