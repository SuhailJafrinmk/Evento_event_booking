import 'package:cached_network_image/cached_network_image.dart';
import 'package:evento_event_booking/resources/constants/image_paths.dart';
import 'package:evento_event_booking/utils/cache_manager.dart';
import 'package:evento_event_booking/utils/progress_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String ? imageUrl;
  final double ? height;
  final double ? width;
  const CustomCachedNetworkImage({super.key, required this.imageUrl,this.height,this.width});
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      cacheManager: CustomCacheManager().cacheManager,
      imageUrl: imageUrl ?? placeholderImage,
      placeholder: (context, url) => const Center(child: CustomProgressIndicator()),
      errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
      fadeInDuration: const Duration(milliseconds: 100),
      fit: BoxFit.cover,
      height: height ?? double.infinity,
      width: width ?? double.infinity,
      );
  }
}

//  CachedNetworkImage(
//                       cacheManager: CustomCacheManager().cacheManager,
//                       imageUrl: image.event_img_1 ?? placeholderImage,
//                       placeholder: (context, url) => Center(child: CustomProgressIndicator()),
//                       errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
//                       fadeInDuration: Duration(milliseconds: 100),
//                       fit: BoxFit.cover,
//                       width: double.infinity,
//                       height: double.infinity,
//                     ),