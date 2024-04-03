import 'package:flutter/material.dart';

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
          Image(
            image: NetworkImage(avatarUrl),
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
            top: 10,
            right: 15,
            child: InkWell(
              onTap: () {
                // TODO: Implement change avatar
              },
              child: Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Image.asset(
                  'assets/change-picture.png',
                  height: 40,
                  width: 40,
                ),
              ),
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
              child: CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(avatarUrl),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
