import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoplite/utils/shimmer/common_shimmer_effect.dart';

class ShowNetworkImage extends StatelessWidget {
  final double size;
  final String url;
  const ShowNetworkImage({super.key, required this.size, required this.url});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: size,
      width: size,
      imageUrl: url,
      fit: BoxFit.cover,
      placeholder:
          (context, url) => CommonShimmerEffect(
            child: Container(height: size, width: size, color: Colors.white),
          ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
