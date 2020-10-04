import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/food.dart';

class Cuisines extends StatefulWidget {
  @override
  _CuisinesState createState() => _CuisinesState();
}

class _CuisinesState extends State<Cuisines> {
  String cuisine = "North";

  void _fetchChinese() async {
    print("<<<<<<<<<<<<<<<<<<<");
    try {
      await Provider.of<Food>(context, listen: false).fetchChinese();
    } catch (error) {
      print(error);
    }
  }

  void _fetchNon() async {
    print("<<<<<<<<<<<<<<<<<<<");
    try {
      await Provider.of<Food>(context, listen: false).fetchNonVeg();
    } catch (error) {
      print(error);
    }
  }

  void _fetchSouth() async {
    print("<<<<<<<<<<<<<<<<<<<");
    try {
      await Provider.of<Food>(context, listen: false).fetchSouth();
    } catch (error) {
      print(error);
    }
  }

  void _fetchSweets() async {
    print("<<<<<<<<<<<<<<<<<<<");
    try {
      await Provider.of<Food>(context, listen: false).fetchSweets();
    } catch (error) {
      print(error);
    }
  }

  void _fetchItalian() async {
    print("<<<<<<<<<<<<<<<<<<<");
    try {
      await Provider.of<Food>(context, listen: false).fetchItalian();
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    // Future.delayed(Duration.zero, () {
    //   _fetch();
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Column(
              children: <Widget>[
                GestureDetector(
                  child: Card(
                    elevation: 2.0,
                    color: Colors.white,
                    shadowColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      height: 80.0,
                      child: Image(
                        image: AssetImage(
                          'assets/burger.png',
                        ),
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                  onTap: () {
                    _fetchItalian();
                  },
                ),
                Text(
                  'Italian',
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                  child: Card(
                    elevation: 2.0,
                    color: Colors.white,
                    shadowColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      height: 80.0,
                      child: Image(
                        image: AssetImage(
                          'assets/chinese.png',
                        ),
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                  onTap: () {
                    _fetchChinese();
                  },
                ),
                Text(
                  'Chinese',
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                  child: Card(
                    elevation: 2.0,
                    color: Colors.white,
                    shadowColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      height: 80.0,
                      child: Image(
                        image: AssetImage(
                          'assets/southIndian.png',
                        ),
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                  onTap: () {
                    _fetchSouth();
                  },
                ),
                Text(
                  'South Indian',
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                  child: Card(
                    elevation: 2.0,
                    color: Colors.white,
                    shadowColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      height: 80.0,
                      child: Image(
                        image: AssetImage(
                          'assets/non-veg.png',
                        ),
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                  onTap: () {
                    _fetchNon();
                  },
                ),
                Text(
                  'Non-Veg',
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                  child: Card(
                    elevation: 2.0,
                    color: Colors.white,
                    shadowColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      height: 80.0,
                      child: Image(
                        image: AssetImage(
                          'assets/sweets.png',
                        ),
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                  onTap: () {
                    _fetchSweets();
                  },
                ),
                Text(
                  'Sweets',
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
