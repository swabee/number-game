import 'package:flutter/material.dart';
import 'package:light_bottom_navigation_bar/light_bottom_navigation_bar.dart';
import 'package:number_game/constant/app_constants.dart';
import 'package:number_game/features/game_daily_task/presentation/pages/daily_task_page.dart';
import 'package:number_game/features/game_home/presentation/pages/game_home_page.dart';
import 'package:number_game/features/game_rewards/presentation/pages/game_reward_map_page.dart';

class GameBasePage extends StatefulWidget {
  const GameBasePage({super.key});

  @override
  State<GameBasePage> createState() => _GameBasePageState();
}

class _GameBasePageState extends State<GameBasePage> {
  int selected = 0; 
  late PageController _pageController;

  final List<Widget> pages = const [
    GameHomePage(),
    DailyTaskPage(),
   GameJourneyPage(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selected);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => selected = index);
        },
        children: pages,
      ),
      bottomNavigationBar: LightBottomNavigationBar(
        backgroundColor: primaryColor,
        currentIndex: selected, 
        items: const [
          LightBottomNavigationBarItem(
            unSelectedIcon: Icons.home,
            selectedIcon: Icons.home_outlined,
            splashColor: Colors.blueAccent,
            borderBottomColor: Colors.blueAccent,
            backgroundShadowColor: Colors.blueAccent,
            selectedIconColor: Colors.blueAccent,
            unSelectedIconColor: Colors.grey,
          ),
          LightBottomNavigationBarItem(
            unSelectedIcon: Icons.calendar_month,
            selectedIcon: Icons.calendar_month,
            splashColor: Color.fromARGB(255, 236, 175, 21),
            borderBottomColor: Color.fromARGB(255, 236, 175, 21),
            backgroundShadowColor: Color.fromARGB(255, 236, 175, 21),
            selectedIconColor: Color.fromARGB(255, 236, 175, 21),
            unSelectedIconColor: Colors.grey,
          ),
          LightBottomNavigationBarItem(
            unSelectedIcon: Icons.circle,
            selectedIcon: Icons.circle,
            splashColor: Colors.purple,
            borderBottomColor: Colors.purple,
            backgroundShadowColor: Colors.purple,
            selectedIconColor: Colors.purple,
            unSelectedIconColor: Colors.grey,
          ),
        ],
        onSelected: (index) {
          setState(() => selected = index);
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
      ),
    );
  }
}
