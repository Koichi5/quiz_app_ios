import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:lottie/lottie.dart';
// import 'package:quiz_app/presentation/auth_routes.dart';
import 'package:quiz_app/presentation/routers.dart';
// import 'package:quiz_app/presentation/auth_routes.dart';
// import 'package:quiz_app/presentation/screens/signup_screen.dart';

class IntroSliderScreen extends StatelessWidget {
  const IntroSliderScreen({Key? key}) : super(key: key);

  static String get routeName => 'intro-slider';
  static String get routeLocation => '/$routeName';

  final TextStyle _titleStyle =
      const TextStyle(color: Colors.cyan, fontSize: 20);
  final TextStyle _descriptionStyle =
      const TextStyle(color: Colors.cyan, fontSize: 18);
  final Color _bgColor = Colors.white;

  List<ContentConfig> get slides => [
        ContentConfig(
          title: "ようこそ Tech Journey へ！",
          styleTitle: _titleStyle,
          pathImage: "assets/images/sample_logo.png",
          widthImage: 230,
          heightImage: 230,
          backgroundColor: _bgColor,
        ),
        ContentConfig(
          title: "高校情報レベルの単語を出題",
          centerWidget: _buildLottieAsset("intro_slider1.json"),
          styleTitle: _titleStyle,
          description: "Tech Journey でこれからの時代の\n常識を身につけよう！",
          styleDescription: _descriptionStyle,
          backgroundColor: _bgColor,
        ),
        ContentConfig(
          title: "自分の問題を作成しよう！",
          centerWidget: _buildLottieAsset("intro_slider2.json"),
          styleTitle: _titleStyle,
          description: "問題を作成して効率的に\n学習しよう！",
          styleDescription: _descriptionStyle,
          backgroundColor: _bgColor,
        ),
        ContentConfig(
          title: "苦手な問題を登録しよう！",
          centerWidget: _buildLottieAsset("intro_slider3.json"),
          styleTitle: _titleStyle,
          description: "問題を登録して繰り返し復習しよう！",
          styleDescription: _descriptionStyle,
          backgroundColor: _bgColor,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      listContentConfig: slides,
      renderSkipBtn: const Text("スキップ"),
      renderNextBtn: const Text("次へ"),
      renderDoneBtn: _renderDoneBtn(context),
    );
  }

  Widget _renderDoneBtn(BuildContext context) {
    return TextButton(
      onPressed: () {
        const SignupRoute().go(context);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const SignupScreen(),
        //   ),
        // );
      },
      child: const Text("終了"),
    );
  }

  Widget _buildLottieAsset(String fileName) {
    return Lottie.asset(
      "assets/json_files/$fileName",
      width: 250,
      height: 250,
    );
  }
}
