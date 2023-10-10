import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app/domain/dictionary_item/dictionary_item.dart';
import 'package:quiz_app/presentation/controller/dictionary_item_controller.dart';
import 'package:quiz_app/presentation/widgets/dictionary_card.dart';

class DictionaryScreen extends HookConsumerWidget {
  const DictionaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dictionaryItemState = ref.watch(dictionaryItemControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "単語集",
        ),
      ),
      body: dictionaryItemState.when(
        data: (dictionaryItemList) => dictionaryItemList.isEmpty
            ? const Center(child: Text("辞書に単語が追加されていません"))
            : _buildDictionaryList(context, dictionaryItemList),
        error: (error, _) => Container(
          color: Colors.white,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "エラーが発生しています",
                textAlign: TextAlign.center,
              ),
              Lottie.asset("assets/json_files/error.json",
                  width: MediaQuery.of(context).size.width * 0.7,
                  fit: BoxFit.fitWidth),
            ],
          ),
        ),
        loading: () => Center(
          child: Lottie.asset("assets/json_files/loading.json",
              width: 200, height: 200),
        ),
      ),
    );
  }

  Widget _buildDictionaryList(
      BuildContext context, List<DictionaryItem> dictionaryItemList) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dictionaryItemList.length,
            itemBuilder: (context, index) =>
                DictionaryCard(dictionaryItem: dictionaryItemList[index]),
          ),
          _buildCitationText("引用元"),
          _buildCitationText(
              "総務省『国民のためのサイバーセキュリティサイト』\n（https://www.soumu.go.jp/main_sosiki/cybersecurity/kokumin/glossary/glossary_01.html）を一部加工して作成"),
          _buildCitationText("Wikipedia (https://ja.wikipedia.org/wiki/)"),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildCitationText(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}
