import 'package:elmatbakh/categorygrid.dart';
import 'package:elmatbakh/favoritescreen.dart';
import 'package:elmatbakh/newdrawer.dart';
import 'package:elmatbakh/settingsscreen.dart';
import 'package:flutter/material.dart';

class TabsControllerScreen extends StatefulWidget {
  @override
  _TabsControllerScreenState createState() => _TabsControllerScreenState();
}

class _TabsControllerScreenState extends State<TabsControllerScreen> {
  final List<Widget> myPages = [
    CategoryGrid(),
    FavoriteScreen(),
    SettingsScreen()
  ];
  var selectedTabIndex = 0;
  void switchPage(int index) {
    setState(() {
      selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ElMatbakh'),
        ),
        drawer: MainDrawer(),
        body: myPages[selectedTabIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.fastfood_rounded), label: 'Categories'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_rounded), label: 'Favorites'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
          ],
          currentIndex: selectedTabIndex,
          onTap: switchPage,
        ));
  }
}


// class TabsControllerScreen extends StatefulWidget {
//   @override
//   _TabsControllerScreenState createState() => _TabsControllerScreenState();
// }

// class _TabsControllerScreenState extends State<TabsControllerScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//         length: 2,
//         child: Scaffold(
//             appBar: AppBar(
//               title: Text('El Matbakh'),
//               bottom: TabBar(tabs: [
//                 Tab(
//                   icon: Icon(Icons.fastfood_rounded),
//                 ),
//                 Tab(
//                   icon: Icon(Icons.favorite_rounded),
//                 )
//               ]),
//             ),
//             body: TabBarView(
//               children: [CategoryGrid(), FavoriteScreen()],
//             )));
//   }
// }
