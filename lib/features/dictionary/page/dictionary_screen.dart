import 'package:flutter/material.dart';
import 'package:flutter_englearn/utils/service/control_index_navigate_bar.dart';
import 'package:flutter_englearn/utils/widgets/bottom_navigate_bar_widget.dart';
import 'package:flutter_englearn/utils/widgets/line_gradient_background_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DictionaryScreen extends ConsumerWidget {
  const DictionaryScreen({super.key});
  static const String routeName = '/dictionary-screen';

// if (!EnViDic().hasInit) {
//       await EnViDic().init();
//     }
//     final vocabulary = EnViDic().lookUp('hello');
//     final suggests = EnViDic().suggest('he');
//     print(vocabulary?.details.first.means.first.mean);
//     print(suggests);
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     test();
//   }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get index of bottom navigation bar
    final indexBottomNavbar = ref.watch(indexBottomNavbarProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Từ điển',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: LineGradientBackgroundWidget(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //
            children: <Widget>[
              const Text('Chọn nguồn từ điển',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Từ điển từ en_vi_dic'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Từ điển từ API Network'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigateBarWidget(index: indexBottomNavbar),
    );
  }
}
