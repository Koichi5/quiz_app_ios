// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:quiz_app/domain/option/option.dart';
// import 'package:quiz_app/domain/question/question.dart';
// import 'package:quiz_app/domain/quiz/quiz.dart';
// import 'package:quiz_app/domain/repository/question_repository.dart';

// class AddQuestionScreen extends ConsumerWidget {
//   AddQuestionScreen({super.key});

//   final List<String> questionDocRefList = [
//     "eE2CWcTmJTzKuZAPBW3n",
//     "fJhZD4b8ueUAYxoX970Y",
//     "MtZUHUYztaLv0guouLRQ",
//     "p1UcUOWYv6gKsVjXzKdI",
//     "1t0DOU2S0bzCOmon4vVV",
//     "f57eXSPNstgbgdBRIHCd",
//     "hOYo4EUU1DjCpc3it5Dd",
//     "nOtbeZYumdEqEWm8LomR",
//     "2Wmgdki6hezWgEAlAKIt",
//     "mCVhbqW7x4OacFY9mJZt",
//     "sgSpTKYP5FxvnNbTzQgt",
//     "GvIN0INZHTky6I2VrohO",
//     "N5l7lyfi01LiGEesNLw0",
//     "GxS5tletP2j1KInURCKL",
//     "bUzUmxrqBu4m2RpJKUee",
//     "cejFgQH0qrBnCMMepXW9",
//     "9qLSrqsYQ7Wf1InDkJnz",
//     "ByK3BceNniwCjfYguZsx",
//     "oRZE92w7Y04tG71cP0du",
//     "2ygN6DpflAxT8yjLYvGW",
//     "74Bz8KgsRwOApHZGb2mc",
//     "BLwIc3WBGcG9M76h5Nxk",
//     "yYrAeAtU6FIHvJ3ZI5YX",
//     "GHfthI6jWKRyT9UFJg5G",
//     "E54IEp4ozZzYRGxsELGm",
//     "OPAXjstPH9opIjEK5Ukz",
//     "5YR53fZlCODAA8Tdixdy",
//     "7B78LPYdxEKVRUVUpaIu",
//     "WHOwZqbajeK1Cm1Nrj7G",
//     "370iuCWwcoIAdnPI21xA",
//     "kxOVXVLQhfATemeVotxc",
//     "5AZjc3Awh5Y8ZHVXIFdS",
//   ];
//   final List<String> textList = [
//     "10進法における「5」を2進法に直すといくらになるか？",
//     "0から9までの数字によって数を表す方式であり、現在日常に用いられている数の表記法を何というか？",
//     "0から9までの数字とAからFまでのアルファベットを組み合わせて数を表す方式を何というか？",
//     "0と1の数字によって数を表す方式を何というか？",
//     "論理演算の一つで、二つの命題のいずれも真のときに真となり、それ以外のときは偽となるものを何というか？",
//     "現代英語や西ヨーロッパ言語で使われるラテン文字を中心とした文字コードで、最も基礎となっている文字コードを何というか？",
//     "情報理論、コンピューティング、多くのデジタル通信における情報の基本単位を何というか？",
//     "コンピュータの処理において、「複数ビット」を意味する、データ量あるいは情報量の単位を何というか？",
//     "コンピュータの主要な構成要素で、他の装置・回路の制御やデータの演算などを行う装置で、「中央制御装置」の別名を何というか？",
//     "Web ブラウザが、Webサーバに対してHTML形式のファイルを受け取るためのプロトコルを何というか？",
//     "情報通信技術のことで、通信ネットワークによって情報が流通することの重要性を意識して使用される言葉を何というか？",
//     "論理演算の一つで、二つの命題のいずれも偽のときに真となり、それ以外のときは偽となるものを何というか？",
//     "論理演算の一つで、二つの命題のいずれか一方あるいは両方が真のときに真となり、いずれも偽のときに偽となるものを何というか？",
//     "コンピュータを動作させるための基本的な機能を提供するシステム全般のことで、「基本ソフトウェア」の別名を何というか？",
//     "コンピュータネットワークで利用されている多数のプロトコルについて、それぞれの役割に応じて７つに分類し、明確化するためのモデルを何というか？",
//     "コンピュータ上で日本語を含む文字列を表現するために広く用いられている文字コードを何というか？",
//     "符号化文字集合や文字符号化方式などを定めた、文字コードの業界規格を何というか？",
//     "さまざまな目的に応じてコンピュータのOS上で動作するソフトウェアのことを何というか？",
//     "コンピュータと周辺機器の接続部分、人間と自動機械との間の複雑な操作をする手順・規則を何というか？",
//     "コンピュータの構成要素のひとつで、論理演算や四則演算などの演算をおこなう装置を何というか？",
//     "コンピュータの構成要素の一つで、作成したデータを保存しておく装置を何というか？",
//     "コンピュータの基礎的な操作・運用・運転を司るシステムソフトウェアを何というか？",
//     "スピーカーなど、コンピュータからの実行状態の報告や実行結果が表示される装置を何というか？",
//     "論理関数の、入力の全てのパターンとそれに対する結果の値を、表にしたものを何というか？",
//     "プロセッサの一部で、プロセッサの演算装置やレジスタの動作や、記憶装置の読み書き、入出力などを制御する装置を何というか？",
//     "コンピューター分野でハードウェアと対比される用語で、何らかの処理を行うコンピュータ・プログラムや、文書を何というか？",
//     "キーボードやマウスなどの、コンピュータなどの機器本体にデータや情報、指示などを与えるための装置を何というか？",
//     "コンピュータなどのシステムにおいて、機械、装置、設備、部品といった物理的な構成要素を何というか？",
//     "記憶装置の分類で、外部バスに接続され、CPUが入出力命令で操作する物を何というか？",
//     "コンピュータのメインバスなどに直接接続されている記憶装置で、「主記憶装置」の別名を何というか？",
//     "コンピュータで文字を表示する際に、正しく表示されない現象のことを何というか？",
//     "コンピュータ上で文字を利用する目的で各文字に割り当てられるバイト表現のことを何というか？",
//   ];
//   final List<String> firstOptionList = [
//     "111",
//     "16進法",
//     "1進法",
//     "2進法",
//     "NOR回路",
//     "Unicode",
//     "ピクセル",
//     "キロビット",
//     "メモリ",
//     "FTP",
//     "IoT",
//     "OR回路",
//     "OR回路",
//     "OS",
//     "OSI参照モデル",
//     "Unicode",
//     "ASCII",
//     "アプリケーションソフトウェア",
//     "USB",
//     "演算装置",
//     "プロセッサ",
//     "コンパイラ",
//     "ディスプレイ",
//     "論理演算表",
//     "演算装置",
//     "ハードウェア",
//     "出力装置",
//     "ハードウェア",
//     "メモリ",
//     "データベース",
//     "文字化け",
//     "文字コード",
//   ];
//   final List<String> secondOptionList = [
//     "11",
//     "1進法",
//     "2進法",
//     "16進法",
//     "OR回路",
//     "文字コード",
//     "bit",
//     "パケット",
//     "CPU",
//     "SMTP",
//     "AI",
//     "NOT回路",
//     "NOR回路",
//     "ファームウェア",
//     "アプリケーションモデル",
//     "Shift_JISコード",
//     "Unicode",
//     "シミュレーションソフトウェア",
//     "ハブ",
//     "記憶装置",
//     "CPU",
//     "ミドルウェア",
//     "制御装置",
//     "真理値表",
//     "制御装置",
//     "コード",
//     "外部装置",
//     "ミドルウェア",
//     "補助記憶装置",
//     "ROM",
//     "誤変換",
//     "文字集合",
//   ];
//   final List<String> thirdOptionList = [
//     "110",
//     "2進法",
//     "10進法",
//     "1進法",
//     "AND回路",
//     "ASCII",
//     "byte",
//     "レジスタ",
//     "プロセッサ",
//     "ステータスコード",
//     "5G",
//     "AND回路",
//     "AND回路",
//     "アプリケーションソフトウェア",
//     "ネットワークモデル",
//     "ASCII",
//     "統一コード",
//     "システムソフトウェア",
//     "インターフェイス",
//     "処理装置",
//     "制御装置",
//     "基本ソフトウェア",
//     "演算装置",
//     "条件分岐表",
//     "出力装置",
//     "ソフトウェア",
//     "制御装置",
//     "コンピュータ",
//     "主記憶装置",
//     "ストレージ",
//     "字崩れ",
//     "文字列",
//   ];
//   final List<String> fourthOptionList = [
//     "101",
//     "10進法",
//     "16進法",
//     "10進法",
//     "NOT回路",
//     "Shift_JISコード",
//     "画素",
//     "byte",
//     "オペレーティングシステム",
//     "HTTP",
//     "ICT",
//     "NOR回路",
//     "NOT回路",
//     "ハードウェア",
//     "TCP/IPモデル",
//     "UTF-8",
//     "Shift_JISコード",
//     "プロダクティビティソフトウェア",
//     "ケーブル",
//     "制御装置",
//     "記憶装置",
//     "アプリケーションソフトウェア",
//     "出力装置",
//     "回路図",
//     "計算装置",
//     "パッケージ",
//     "入力装置",
//     "ソフトウェア",
//     "チップ",
//     "メインメモリ",
//     "バグ",
//     "Unicode",
//   ];

//   final List<bool> firstOptionIsCorrectList = [
//     false,
//     false,
//     false,
//     true,
//     false,
//     false,
//     false,
//     false,
//     false,
//     false,
//     false,
//     false,
//     true,
//     true,
//     true,
//     false,
//     false,
//     true,
//     false,
//     true,
//     false,
//     false,
//     false,
//     false,
//     false,
//     false,
//     false,
//     true,
//     false,
//     false,
//     true,
//     true,
//   ];
//   final List<bool> secondOptionIsCorrectList = [
//     false,
//     false,
//     false,
//     false,
//     false,
//     false,
//     true,
//     false,
//     true,
//     false,
//     false,
//     true,
//     false,
//     false,
//     false,
//     true,
//     true,
//     false,
//     false,
//     false,
//     false,
//     false,
//     false,
//     true,
//     true,
//     false,
//     false,
//     false,
//     true,
//     false,
//     false,
//     false,
//   ];
//   final List<bool> thirdOptionIsCorrectList = [
//     false,
//     false,
//     false,
//     false,
//     true,
//     true,
//     false,
//     false,
//     false,
//     false,
//     false,
//     false,
//     false,
//     false,
//     false,
//     false,
//     false,
//     false,
//     true,
//     false,
//     false,
//     true,
//     false,
//     false,
//     false,
//     true,
//     false,
//     false,
//     false,
//     false,
//     false,
//     false,
//   ];
//   final List<bool> fourthOptionIsCorrectList = [
//     true,
//     true,
//     true,
//     false,
//     false,
//     false,
//     false,
//     true,
//     false,
//     true,
//     true,
//     false,
//     false,
//     false,
//     false,
//     false,
//     false,
//     false,
//     false,
//     false,
//     true,
//     false,
//     true,
//     false,
//     false,
//     false,
//     true,
//     false,
//     false,
//     true,
//     false,
//     false,
//   ];

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       body: Center(
//           child: ElevatedButton(
//         onPressed: () {
//           for (int i = 0; i < questionDocRefList.length; i++) {
//             ref.watch(questionRepositoryProvider).addQuestion(
//                   quiz: Quiz(
//                     categoryDocRef: "dTxZsCoHVLMnAybMIMGP",
//                     quizDocRef: "gJbMvUPFs6umJX7CuGFs",
//                     questionDocRef: questionDocRefList[i],
//                     categoryId: 4,
//                     title: "コンピュータの仕組み",
//                     description: "コンピュータの仕組み",
//                     questionsShuffled: false,
//                   ),
//                   question: Question(
//                     text: textList[i],
//                     questionDocRef: questionDocRefList[i],
//                     categoryDocRef: "dTxZsCoHVLMnAybMIMGP",
//                     quizDocRef: "gJbMvUPFs6umJX7CuGFs",
//                     duration: 15,
//                     optionsShuffled: false,
//                     options: [
//                       Option(
//                           text: firstOptionList[i],
//                           isCorrect: firstOptionIsCorrectList[i],
//                           isSelected: false),
//                       Option(
//                           text: secondOptionList[i],
//                           isCorrect: secondOptionIsCorrectList[i],
//                           isSelected: false),
//                       Option(
//                           text: thirdOptionList[i],
//                           isCorrect: thirdOptionIsCorrectList[i],
//                           isSelected: false),
//                       Option(
//                           text: fourthOptionList[i],
//                           isCorrect: fourthOptionIsCorrectList[i],
//                           isSelected: false)
//                     ],
//                   ),
//                 );
//           }
//         },
//         child: const Text("クエスチョン追加"),
//       )),
//     );
//   }
// }
