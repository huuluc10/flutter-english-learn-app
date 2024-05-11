import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_englearn/common/helper/helper.dart';

class ReceiverMessageWidget extends StatelessWidget {
  ReceiverMessageWidget({
    super.key,
    required this.message,
    this.avatarUrl,
  });

  final String message;
  String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    avatarUrl = transformLocalURLMediaToURL(avatarUrl!);
    return Padding(
      padding: const EdgeInsets.only(
        top: 5,
        bottom: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
           CircleAvatar(
            radius: 20,
            backgroundImage: CachedNetworkImageProvider(avatarUrl!),
          ),
          const SizedBox(width: 5),
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.sizeOf(context).width * 0.6,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                message,
                textAlign: TextAlign.justify,
              ),
            ),
          )
        ],
      ),
    );
  }
}
