import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'seat_setting.dart';
import 'seat_manage.dart';
import 'seat_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SeatState(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const SeatManage(),
    const SeatSetting(),
    const Statistic(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.125, // 1/8
            color: Colors.red,
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: const Text(
                    '자리요 for 사장님',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                buildNavItem(0, '좌석 관리'),
                buildNavItem(1, '좌석 설정'),
                buildNavItem(2, '통계'),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNavItem(int index, String title) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        color: _selectedIndex == index ? Colors.white : Colors.red,
        padding: const EdgeInsets.all(16.0),
        child: Text(
          title,
          style: TextStyle(
            color: _selectedIndex == index ? Colors.red : Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}

class Statistic extends StatelessWidget {
  const Statistic({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Statistic'),
    );
  }
}
