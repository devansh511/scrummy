import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../screens/feed_screen.dart';
import '../screens/empty_cart_screen.dart';
import './searched_items_screen.dart';
import './cart_screen.dart';
import './profile_screen.dart';
import './search_screen.dart';
import './checkout_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex;
  @override
  void initState() {
    // TODO: implement
    super.initState();

    _currentIndex = 0;
  }

  List<Widget> _currentScreen = [
    FeedScreen(),
    SearchItems(),
    CheckoutScreen(),
    ProfileScreen()
  ];

  _changePage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 5.0,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Container(
          margin: EdgeInsets.only(left: 120.0),
        ),
      ),
      body: _currentScreen[_currentIndex],
      // _currentIndex == 0
      //     ? null
      //     : _currentIndex == 1
      //         ? null
      //         : _currentIndex == 2 ? null : _currentIndex == 3 ? null : null,

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Icon(Icons.add),
      //   backgroundColor: Colors.orange,
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BubbleBottomBar(
        opacity: 0.2,
        elevation: 8.0,
        backgroundColor: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.0),
        ),
        currentIndex: _currentIndex,
        // hasInk: true,
        inkColor: Colors.grey[700],
        // hasNotch: true,
        // fabLocation: BubbleBottomBarFabLocation.end,
        onTap: _changePage,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
            backgroundColor: Colors.grey,
            icon: FaIcon(
              FontAwesomeIcons.home,
              color: Colors.grey,
              size: 20.0,
            ),
            activeIcon: FaIcon(
              FontAwesomeIcons.home,
              color: Colors.orange,
              size: 20.0,
            ),
            title: Text(
              'Home',
              style: TextStyle(
                color: Colors.orange,
                fontFamily: 'Raleway',
              ),
            ),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.grey,
            icon: FaIcon(
              FontAwesomeIcons.search,
              color: Colors.grey,
              size: 20.0,
            ),
            activeIcon: FaIcon(
              FontAwesomeIcons.search,
              color: Colors.orange,
              size: 20.0,
            ),
            title: Text(
              'Search',
              style: TextStyle(
                color: Colors.orange,
                fontFamily: 'Raleway',
              ),
            ),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.grey,
            icon: FaIcon(
              FontAwesomeIcons.shoppingCart,
              color: Colors.grey,
              size: 20.0,
            ),
            activeIcon: Icon(
              FontAwesomeIcons.shoppingCart,
              color: Colors.orange,
              size: 20.0,
            ),
            title: Text(
              'Orders',
              style: TextStyle(
                color: Colors.orange,
                fontFamily: 'Raleway',
              ),
            ),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.grey,
            icon: FaIcon(
              FontAwesomeIcons.user,
              color: Colors.grey,
              size: 20.0,
            ),
            activeIcon: FaIcon(
              FontAwesomeIcons.user,
              color: Colors.orange,
              size: 20.0,
            ),
            title: Text(
              'Profile',
              style: TextStyle(
                color: Colors.orange,
                fontFamily: 'Raleway',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
