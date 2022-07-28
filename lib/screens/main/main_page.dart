import 'package:aloqa_nazorati/screens/appeals/pages/appeal_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../home/pages/references/home_page.dart';
import '../profile/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController _pageController = PageController();

  final _screen = [const HomePage(), const AppealPage(), const ProfilePage()];

  int _selectedIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: _screen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle:
            const TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w400),
        unselectedLabelStyle:
            const TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w400),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/ic_home.svg',
              height: 24,
              width: 24,
            ),
            activeIcon: SvgPicture.asset(
              height: 24,
              width: 24,
              'assets/icons/ic_home_selected.svg',
            ),
            label: 'Asosiy',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              height: 24,
              width: 24,
              'assets/icons/ic_appeal.svg',
            ),
            activeIcon: SvgPicture.asset(
              height: 24,
              width: 24,
              'assets/icons/ic_appeal_selected.svg',
            ),
            label: 'Murojaatlar',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              height: 24,
              width: 24,
              'assets/icons/ic_profile.svg',
            ),
            activeIcon: SvgPicture.asset(
              height: 24,
              width: 24,
              'assets/icons/ic_profile_selected.svg',
            ),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromRGBO(68, 30, 221, 1),
        onTap: _onItemTapped,
      ),
    ));
  }
}
