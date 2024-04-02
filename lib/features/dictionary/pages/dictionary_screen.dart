import 'package:en_vi_dic/en_vi_dic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_englearn/features/dictionary/providers/control_source_dictionary.dart';
import 'package:flutter_englearn/features/dictionary/providers/dictionary_provider.dart';
import 'package:flutter_englearn/features/dictionary/widgets/api_dictionary_widget.dart';
import 'package:flutter_englearn/features/homepage/widgets/button_choose_source_dictionary_widget.dart';
import 'package:flutter_englearn/features/dictionary/widgets/en_vi_dic_widget.dart';
import 'package:flutter_englearn/model/response/dictionary_api_word_response.dart';
import 'package:flutter_englearn/utils/service/control_index_navigate_bar.dart';
import 'package:flutter_englearn/utils/widgets/bottom_navigate_bar_widget.dart';
import 'package:flutter_englearn/utils/widgets/line_gradient_background_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DictionaryScreen extends ConsumerStatefulWidget {
  const DictionaryScreen({super.key});
  static const String routeName = '/dictionary-screen';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DictionaryScreenState();
}

class _DictionaryScreenState extends ConsumerState<DictionaryScreen> {
  dynamic sourceDictionary;
  Vocabulary? vocabulary;
  List<DictionaryAPIWordResponse>? vocabularyAPI;
  bool? isSearch;
  bool isUseEnViDic = true;

  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isSearch = false;
  }

  void search(String value) async {
    var word = await ref
        .watch(dictionaryServiceProvider)
        .getWordEnViDic(textEditingController.text.trim());
    setState(() {});
    var words =
        await ref.watch(dictionaryServiceProvider).getWordFromAPI(value);

    setState(() {
      vocabularyAPI = words;
      vocabulary = word;
      isSearch = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get index of bottom navigation bar
    final indexBottomNavbar = ref.watch(indexBottomNavbarProvider);

    //Get height and width of screen
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
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
                              sourceDictionaryName: 'Từ điển Anh - Việt',
                              from: ControlSourceDictionary.enViDic,
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: ButtonChooseSourceDictionary(
                              sourceDictionaryName: 'Từ điển từ Anh - Anh',
                              from: ControlSourceDictionary.apiNetwork,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: TextField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          //Clear text field
                          textEditingController.clear();
                          setState(() {
                            isSearch = false;
                          });
                        },
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                      hintText: 'Tìm kiếm',
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          search(textEditingController.text.trim());
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      prefixIconConstraints: const BoxConstraints(
                        minWidth: 40,
                        minHeight: 40,
                      ),
                    ),
                    onSubmitted: (value) async {
                      search(textEditingController.text.trim());
                    },
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  height: height - 255,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Consumer(builder: (context, ref, child) {
                    //Get source dictionary
                    sourceDictionary = ref.watch(controlSourceDictionary);
                    if (sourceDictionary == ControlSourceDictionary.enViDic) {
                      return SingleChildScrollView(
                        child: EnViDicWidget(
                          vocabulary: vocabulary,
                          isSearch: isSearch!,
                        ),
                      );
                    } else {
                      return APIDictionaryWidget(
                        vocabulary: vocabularyAPI,
                        isSearch: isSearch!,
                        height: height - 255,
                      );
                    }
                  }),
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
