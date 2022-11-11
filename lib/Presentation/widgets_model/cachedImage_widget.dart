import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class cachedImageModelWidget extends StatelessWidget {
  final String image;
  const cachedImageModelWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      fadeOutDuration: Duration.zero,
      fadeInDuration: Duration.zero,
      placeholderFadeInDuration: Duration.zero,
      placeholder: (context, url) => Center(
          child: Center(
        child: Lottie.asset(
          'assets/lottie/loading-green.json',
          width: 70,
        ),
      )),
      errorWidget: (context, url, error) => Icon(
        Icons.image_not_supported_outlined,
        color: Colors.grey.shade600,
        size: 30,
      ),
      fit: BoxFit.cover,
    );
  }
}
