import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class HomePage extends StatefulWidget {
  String username;
  HomePage(this.username);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context3) => Scaffold(
              appBar: AppBar(
                title: const Text('iCASIC2020'),
                 
                backgroundColor: Colors.black,
              ),
              body: CupertinoTabScaffold(
                tabBar: CupertinoTabBar(
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      title: Text('Sessions'),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.mic),
                      title: Text('Speakers'),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.school),
                      title: Text('Partners'),
                    ),
                  ],
                ),
                tabBuilder: (BuildContext context, int index) {
                  assert(index >= 0 && index <= 2);
                  switch (index) {
                    case 0:
                      
                      break;
                    case 1:
                      
                      break;
                    case 2:
                      
                      break;
                  }
                  return null;
                },
              ),
              
            ),
      ),
    );
  }
}