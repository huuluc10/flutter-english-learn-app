import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/chat/widgets/receiver_message_widget.dart';
import 'package:flutter_englearn/features/chat/widgets/sending_message_widget.dart';
import 'package:flutter_englearn/features/user_info/page/user_info_screen.dart';
import 'package:flutter_englearn/utils/widgets/line_gradient_background_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatRoom extends ConsumerWidget {
  const ChatRoom({super.key});

  static const String routeName = '/chat-room-screen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Username'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline_rounded),
            onPressed: () {
              Navigator.pushNamed(context, UserInfoScreen.routeName,
                  arguments: {'isFriend': true, 'isMe': false});
            },
          ),
        ],
      ),
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      body: LineGradientBackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 8,
            right: 8,
            top: 50,
            bottom: 20,
          ),
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height - 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: const Color.fromARGB(127, 255, 255, 255),
            ),
            child: const Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ReceiverMessageWidget(
                          message:
                              'Some message here. Long message. Write more and more. Some message here. Long message. Write more and more.'),
                      ReceiverMessageWidget(
                          message:
                              'Some message here. Long message. Write more and more. Some message here. Long message. Write more and more.'),
                      SendingMessageWidget(
                        message:
                            'Some message here. Long message. Write more and more. Some message here. Long message. Write more and more.',
                      ),
                      SendingMessageWidget(
                        message: 'Hello!',
                      ),
                      ReceiverMessageWidget(
                          message:
                              'Some message here. Long message. Write more and more. Some message here. Long message. Write more and more.'),
                      ReceiverMessageWidget(
                          message:
                              'Some message here. Long message. Write more and more. Some message here. Long message. Write more and more.'),
                      SendingMessageWidget(
                        message:
                            'Some message here. Long message. Write more and more. Some message here. Long message. Write more and more.',
                      ),
                      SendingMessageWidget(
                        message: 'Hello!',
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 10,
                bottom: 10,
              ),
              child: TextFormField(
                onChanged: (value) {},
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () async {},
                          icon: const Icon(
                            Icons.send,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(64),
                  ),
                  hintText: "Aa",
                  contentPadding: const EdgeInsets.all(5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
