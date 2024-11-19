import 'package:flutter/material.dart';
import 'package:sdf/tab_pages/AboutUs.dart';
import 'package:sdf/tab_pages/HomePage.dart';
import 'package:sdf/tab_pages/Notifications.dart';
import 'package:sdf/tab_pages/QuestionPage.dart';
import 'package:sdf/validation/validation_api.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String userName = AuthService.finalUserName ?? "Guest";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF673AB7),
        title: const Text(
          '∂ιѕ¢υѕѕιση ƒσřυɱ',
          style: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Text(
            "[$userName]  ",
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
        bottom: TabBar(
          isScrollable: false,
          padding: EdgeInsets.zero,
          indicatorColor: Colors.white70,
          indicatorWeight: 2,
          controller: _tabController,
          tabs: const [
            Tab(
              child: Padding(
                padding: EdgeInsets.only(right: 10, top: 10, bottom: 10),
                child: Icon(Icons.home, color: Colors.white70, size: 32),
              ),
            ),
            Tab(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(Icons.question_answer, color: Colors.white70, size: 32),
              ),
            ),
            Tab(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(Icons.notifications_active_sharp, color: Colors.white70, size: 32),
              ),
            ),
            Tab(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(Icons.more_vert, color: Colors.white70, size: 32),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          HomePage(),
          QuestionPage(),
          Notifications(),
          AboutUs(),
        ],
      ),
    );
  }
}
