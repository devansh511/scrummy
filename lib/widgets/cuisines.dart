import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrummy/models/Http_Exceptions.dart';
import 'package:scrummy/widgets/dishes_grid.dart';
import '../providers/food.dart';

class Cuisines extends StatefulWidget {
  @override
  _CuisinesState createState() => _CuisinesState();
}

bool isLoadin = false;

class _CuisinesState extends State<Cuisines> {
  Future<void> _showMyDialog(String msg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Foodies Alert',
            style: TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          content: Text(
            msg,
            style: TextStyle(
              fontFamily: "Raleway",
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Okay',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway',
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _fetchCuisine(String cuisine) async {
    print("<<<<<<<<<<<<<<<<<<<");
    try {
      setState(() {
        isLoadin = true;
      });
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DishesGrid(),
        ),
      );
      await Provider.of<Food>(context, listen: false).fetchCuisines(cuisine);
    } catch (error) {
      print(error);
      _showMyDialog("Something went wrong on our servers!");
    }
    setState(() {
      isLoadin = false;
    });
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
                    _fetchCuisine("italian");
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
                    _fetchCuisine("chinese");
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
                    _fetchCuisine("south%20indian");
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
                    _fetchCuisine("non-veg");
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
                    _fetchCuisine("sweets");
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
