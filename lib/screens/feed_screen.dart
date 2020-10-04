import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scrummy/screens/cart_screen.dart';
import 'package:scrummy/screens/empty_cart_screen.dart';
import 'package:scrummy/screens/location_screen.dart';
import 'package:provider/provider.dart';
import '../widgets/dishes_grid.dart';
import '../widgets/cuisines.dart';
import '../widgets/restaurants.dart';
import '../auth/auth.dart';
import '../providers/food.dart';

// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  bool _getLoc() {
    return Provider.of<Auth>(context, listen: false).isAuth;
  }

  String location() {
    if (addr2 == null) {
      return "Food will be delivered here!";
    } else {
      return addr2;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _getLoc();
      location();
    });

    super.initState();
  }

  void _fetch() async {
    print("<<<<<<<<<<<<<<<<<<<");
    try {
      await Provider.of<Food>(context, listen: false).fetchFood();
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final dishes = dishesData.items;
    return ListView(
      children: [
        Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.edit_location),
              title: GestureDetector(
                child: Text(
                  '${location()}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontFamily: 'Raleway',
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LocationScreen(),
                    ),
                  );
                },
              ),
              trailing: GestureDetector(
                child: Icon(Icons.shopping_cart),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmptyCart(),
                    ),
                  );
                },
              ),
            ),
            Container(
              width: 380.0,
              height: 168.0,
              child: Card(
                elevation: 3.0,
                margin: EdgeInsets.all(10.0),
                shadowColor: Colors.grey,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            'Subway',
                            style: TextStyle(
                              color: Colors.orange[700],
                              fontFamily: 'McLaren',
                              fontSize: 35.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            'Get your favorite sub',
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 17.0,
                      ),
                      Image(
                        image: AssetImage(
                          'assets/non-veg.png',
                        ),
                        width: 170.0,
                        height: 150.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10.0),
              child: Row(
                children: <Widget>[
                  Text(
                    'Category',
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w900,
                      fontSize: 17.0,
                    ),
                  ),
                  // Container(
                  //   margin: EdgeInsets.only(left: 190.0, right: 8.0),
                  //   child: Text(
                  //     'See all',
                  //     style: TextStyle(
                  //         fontFamily: 'Raleway',
                  //         color: Colors.grey,
                  //         fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  // Container(
                  //   child: FaIcon(
                  //     FontAwesomeIcons.arrowRight,
                  //     size: 15.0,
                  //     color: Colors.grey,
                  //   ),
                  // )
                ],
              ),
            ),
            Cuisines(),
            Container(
              margin: EdgeInsets.only(left: 10.0, top: 15.0),
              child: Row(
                children: <Widget>[
                  Text(
                    'For you',
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w900,
                      fontSize: 17.0,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 220.0, right: 8.0),
                    child: GestureDetector(
                        child: Text(
                          'See all',
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          _fetch();
                        }),
                  ),
                  Container(
                    child: FaIcon(
                      FontAwesomeIcons.arrowRight,
                      size: 15.0,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        DishesGrid(),
        Container(
          margin: EdgeInsets.only(left: 10.0, top: 15.0),
          child: Row(
            children: <Widget>[
              Text(
                'Restaurants',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w900,
                  fontSize: 17.0,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 180.0, right: 8.0),
                child: Text(
                  'See all',
                  style: TextStyle(
                      fontFamily: 'Raleway',
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                child: FaIcon(
                  FontAwesomeIcons.arrowRight,
                  size: 15.0,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
        Restaurants(),
      ],
    );
  }
}

// GridView.builder(
//   itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
//     value: dishes[i],
//     child: DishItems(),
//   ),
//   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//     crossAxisCount: 2,
//     childAspectRatio: 3 / 2,
//     crossAxisSpacing: 10,
//     mainAxisSpacing: 10,
//   ),
// ),
