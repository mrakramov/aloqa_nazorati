import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class UsagePage extends StatefulWidget {
  const UsagePage({Key? key}) : super(key: key);

  @override
  State<UsagePage> createState() => _UsagePageState();
}

class _UsagePageState extends State<UsagePage> {
  final PageController _pageController = PageController();
  int currentPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text(
          "Foydalanish qo'llanmasi",
          style: TextStyle(
              fontFamily: 'Roboto', fontWeight: FontWeight.w500, fontSize: 22),
        ),
        backgroundColor: ColorsUtils.myColor,
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            onPageChanged: (int index) {
              setState(() {
                currentPosition = index;
              });
            },
            controller: _pageController,
            children: [
              makePage(
                  image: "assets/images/ic_intro_1.png",
                  title: Strings.stepOneTitle,
                  content: Strings.stepOneContent),
              makePage(
                  image: "assets/images/ic_intro_2.png",
                  title: Strings.stepTwoTitle,
                  content: Strings.stepTwoContent),
              makePage(
                  image: "assets/images/ic_intro_3.png",
                  title: Strings.stepThreeTitle,
                  content: Strings.stepThreeContent),
              makePage(
                  image: "assets/images/ic_intro_4.png",
                  title: Strings.stepFourTitle,
                  content: Strings.stepFourContent),
            ],
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildIndicators(),
            ),
          ),
        ],
      ),
    );
  }

  Widget makePage({image, title, content}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Image(
            image: AssetImage(image),
            height: 250,
            width: 250,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5?.copyWith(
                  color: ColorsUtils.myColor,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            content,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey[600],
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
          ),
        ),
      ],
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      margin: const EdgeInsets.all(2),
      duration: const Duration(milliseconds: 200),
      height: 6,
      width: isActive ? 30 : 6,
      decoration: BoxDecoration(
        color: ColorsUtils.myColor,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  List<Widget> _buildIndicators() {
    List<Widget> list = [];
    for (int i = 0; i < 4; i++) {
      if (currentPosition == i) {
        list.add(_indicator(true));
      } else {
        list.add(_indicator(false));
      }
    }
    return list;
  }
}
