import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/homepage/provider/control_source_dictionary.dart';
import 'package:flutter_englearn/features/homepage/widgets/button_choose_source_dictionary_widget.dart';
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

    //Get height of screen
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: LineGradientBackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 10,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 85,
                  child: Column(
                    children: [
                      Text('Chọn nguồn từ điển',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            flex: 1,
                            child: ButtonChooseSourceDictionary(
                              sourceDictionaryName: 'Từ điển từ en_vi_dic',
                              from: ControlSourceDictionary.enViDic,
                            ),
                          ),
                          Flexible(
                              flex: 2,
                              child: ButtonChooseSourceDictionary(
                                sourceDictionaryName: 'Từ điển từ apiNetwork',
                                from: ControlSourceDictionary.apiNetwork,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 55,
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                      hintText: 'Tìm kiếm',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: height - 260,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (var i = 0; i < 5; i++)
                          const ListTile(
                            title: Text('Hello'),
                            subtitle: Text('Xin chào'),
                          ),
                        for (var i = 0; i < 5; i++)
                          const ListTile(
                            title: Text('Bye'),
                            subtitle: Text('Tạm biệt'),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigateBarWidget(index: indexBottomNavbar),
    );
  }
}
