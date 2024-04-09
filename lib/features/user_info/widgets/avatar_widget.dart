import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    super.key,
    required this.height,
    required this.width,
    required this.avatarUrl,
  });

  final double height;
  final double width;
  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.365,
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          CachedNetworkImage(
            imageUrl: avatarUrl,
            cacheKey: DateTime.now().millisecondsSinceEpoch.toString(),
            height: height * 0.3,
            width: width,
            filterQuality: FilterQuality.high,
            fit: BoxFit.cover,
          ),
          Opacity(
            opacity: 0.55,
            child: Container(
              color: Colors.black,
              height: height * 0.3,
            ),
          ),
          Positioned(
            top: height * 0.15,
            left: width * 0.05,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(80.0),
              ),
              child: Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80.0),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        avatarUrl,
                        cacheKey:
                            DateTime.now().millisecondsSinceEpoch.toString(),
                      ),
                      fit: BoxFit.cover,
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
