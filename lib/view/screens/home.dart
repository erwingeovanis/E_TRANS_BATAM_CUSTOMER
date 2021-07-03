import '../pages/tab_home_screen.dart';
import '../pages/tab_profil.dart';
import '../pages/tab_ticket.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  // Penunjuk array waktu diklik
  int _currentIndex = 0;
  TabController? _tabController;
  List<Widget> tabs = [
    // Tab Home
    HomeScreen(),
    // Tab Ticket
    Ticket(),
    // Tab Profil
    Profil(),
  ];
  @override
  void initState() {
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController!.addListener(() {
      setState(() {
        _currentIndex = _tabController!.index;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(controller: _tabController, children: tabs),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        iconSize: 35,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.bus_alert),
              label: 'Bus',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profil',
              backgroundColor: Colors.yellow),
        ],
        onTap: (index) {
          _tabController!.animateTo(index);
        },
      ),
    );
  }
}
