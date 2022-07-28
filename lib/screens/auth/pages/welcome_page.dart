import 'package:aloqa_nazorati/screens/auth/pages/id_page.dart';
import 'package:aloqa_nazorati/utils/utils.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _welcomeBody(),
      ),
    );
  }

  _welcomeBody() {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/ic_welcome.png"),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 30, 15, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Image.asset("assets/images/ic_gerb.png"),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "O‘zbekiston Respublikasi Axborotlashtirish "
                              "va telekommunikatsiyalar sohasida "
                              "nazorat bo‘yicha davlat inspeksiyasi"
                          .toUpperCase(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Colors.white,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "Aloqa nazorati",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline3?.copyWith(
                            color: Colors.white,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const IdGovPage()));
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        minimumSize: const Size(double.infinity, 55),
                        shadowColor: Colors.green[300],
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      child: Text(
                        "Tizimga kirish",
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: ColorsUtils.myColor,
                                  fontFamily: 'Roboto',
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
