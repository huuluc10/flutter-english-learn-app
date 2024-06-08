import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/learn/provider/learn_provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RatingDialog extends ConsumerStatefulWidget {
  final int lessonId;
  const RatingDialog({Key? key, required this.lessonId}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RatingDialogState();
}

class _RatingDialogState extends ConsumerState<RatingDialog> {
  double _rating = 0;
  final TextEditingController _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Đánh giá bài học'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text('Vui lòng đánh giá và nhập nội dung đánh giá của bạn:'),
          RatingBar.builder(
            initialRating: 0,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              setState(() {
                _rating = rating;
              });
            },
          ),
          TextField(
            controller: _reviewController,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'Nhập nội dung đánh giá của bạn',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Hủy bỏ'),
        ),
        ElevatedButton(
          onPressed: () {
            // Lưu đánh giá và nội dung đánh giá
            ref.watch(learnServiceProvider).sendFeedback(
                  widget.lessonId,
                  _rating,
                  _reviewController.text,
                );
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          child: const Text('Gửi'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }
}
