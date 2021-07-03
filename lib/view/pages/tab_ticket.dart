import 'package:e_trans/view/pages/halte_page.dart';
import 'package:e_trans/view/pages/jurusan_page.dart';
import 'package:flutter/material.dart';

class Ticket extends StatefulWidget {
  @override
  _TicketState createState() => _TicketState();
}

class _TicketState extends State<Ticket> with TickerProviderStateMixin {
  TabController? _tabController;
  final tabs = [
    HaltePage(),
    JurusanPage(),
  ];
  @override
  void initState() {
    _tabController = TabController(length: tabs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Information'),
      ),
      body: Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 60,
                child: TabBar(
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.grey,
                  controller: _tabController,
                  tabs: [
                    Tab(
                      text: "Halte",
                      icon: Icon(Icons.storefront_outlined),
                    ),
                    Tab(
                      text: "Jurusan",
                      icon: Icon(Icons.directions_bus_outlined),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: tabs,
                ),
              ),
            ],
          )),
    );
  }
}
