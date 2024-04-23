import 'package:flutter/widgets.dart';

class FutureBuilderErrorWidget extends StatelessWidget {
  const FutureBuilderErrorWidget({
    super.key,
    required this.error,
  });
  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Có lỗi xảy ra: $error',
      ),
    );
  }
}
