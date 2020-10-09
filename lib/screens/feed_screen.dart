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
import '../providers/cart.dart';
import 'package:carousel_slider/carousel_slider.dart';

// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  bool _getLoc() {
    return Provider.of<Auth>(context, listen: false).isAuth;
  }

  bool _isLoading = false;
  String location() {
    if (addr2 == null) {
      return "Food will be delivered here!";
    } else {
      return addr2;
    }
  }

  Future<void> _fetchR() async {
    try {
      // setState(() {
      //   _isLoading = true;
      // });
      await Provider.of<Food>(context, listen: false).fetchRestaurants();
      // setState(() {
      //   _isLoading = false;
      // });
    } catch (error) {
      print(error);
    }
  }

  Future<void> display() async {
    try {
      print('displaying cart');
      await Provider.of<Cart>(context, listen: false).displayCart();
      print('displayed cart');
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () async {
      // try {
      await Provider.of<Food>(context, listen: false).fetchRestaurants();
      await display();
      // } catch (error) {
      //   print(error);
      // }
    });
    // setState(() {
    //   _getLoc();
    //   location();
    // });

    super.initState();
  }

  void _fetch() async {
    print("<<<<<<<<<<<<<<<<<<<");
    try {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Food>(context, listen: false).fetchFood();
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final dishes = dishesData.items;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      child: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
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
                    display();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ((Provider.of<Cart>(context, listen: false)
                                        .loadedFoods
                                        .length) ==
                                    0)
                                ? EmptyCart()
                                : CartScreen(),
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
                                color: Colors.orange[800],
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
                            'assets/sub.jpg',
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
                      'Cuisines',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w900,
                        fontSize: 17.0,
                      ),
                    ),
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
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0, bottom: 10),
            height: 218.0,
            child: ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: <Widget>[
                CarouselSlider(
                  options: CarouselOptions(
                    height: 217.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 750),
                    viewportFraction: 1,
                  ),
                  items: [
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
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image(
                              image: AssetImage('assets/backgroundVillage.jpg'),
                              fit: BoxFit.fill,
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'Grill Inn',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Raleway',
                                          fontSize: 40.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Burn your cravings away!',
                                        style: TextStyle(
                                          fontFamily: 'Raleway',
                                          color: Colors.orange,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // SizedBox(
                                  //   width: 17.0,
                                  // ),
                                  // Image(
                                  //   image: AssetImage(
                                  //     'assets/carouselBurger.jpg',
                                  //   ),
                                  //   width: 149.0,
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image(
                              image: AssetImage('assets/backgroundFnf.jpg'),
                              fit: BoxFit.fill,
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'The Village',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Raleway',
                                          fontSize: 31.0,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      Text(
                                        'We cook what you love!',
                                        style: TextStyle(
                                          fontFamily: 'Raleway',
                                          color: Colors.yellowAccent,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // SizedBox(
                                  //   width: 17.0,
                                  // ),
                                  // Image(
                                  //   image: AssetImage(
                                  //     'assets/carouselPaneer.jpg',
                                  //   ),
                                  //   height: 95.0,
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image(
                              image: AssetImage('assets/backgroundIce.jpg'),
                              fit: BoxFit.fill,
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Fresh N Fillin\'',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Raleway',
                                          fontSize: 31.0,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      Text(
                                        'Food & Chill',
                                        style: TextStyle(
                                          fontFamily: 'Raleway',
                                          color: Colors.orange,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // SizedBox(
                                  //   width: 17.0,
                                  // // ),
                                  // Image(
                                  //   image: AssetImage(
                                  //     'assets/carouselPaneer.jpg',
                                  //   ),
                                  //   height: 95.0,
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // if (isLoad == true || _isLoading == true)
          //   Center(
          //     child: CircularProgressIndicator(
          //         backgroundColor: Colors.white,
          //         valueColor: AlwaysStoppedAnimation<Color>(Colors.orange)),
          //   )
          // else
          //   DishesGrid(),
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
                  child: GestureDetector(
                    child: Text(
                      'See all',
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      _fetchR();
                    },
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
          Container(
            height: 190.0,
            width: screenWidth,
            child: RestaurantList(),
          ),
        ],
      ),
    );
  }
}
