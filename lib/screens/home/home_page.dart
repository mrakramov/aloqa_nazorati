import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> list = ["nazorati", "nazorati"];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          title: const Text("Xalq nazorati",
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  fontSize: 28)),
          backgroundColor: const Color.fromRGBO(68, 30, 221, 1),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                "Murojat yo'nalishini tanlang",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: list.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5.0,
                      crossAxisSpacing: 5.0,
                      childAspectRatio: 1.2),
                  itemBuilder: (context, index) {
                    return _itemCard(list[index], context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _itemCard(String list, BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                height: 40,
                width: 40,
                'assets/icons/ic_profile.svg',
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Muammoingizga tegishli bo’limni tanlang",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
