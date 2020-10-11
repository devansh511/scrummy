import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scrummy/screens/cart_screen.dart';
import 'package:scrummy/screens/feed_screen.dart';
import 'package:scrummy/widgets/order_list_view.dart';
import '../widgets/food_list_view.dart';
import 'package:provider/provider.dart';
import '../screens/empty_cart_screen.dart';
import '../providers/cart.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '../providers/food.dart';
import '../providers/cart.dart';
import '../models/Http_Exceptions.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  double rating = 1.0;
  bool isL = true;
  int check = 0;
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
                'Add some food',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway',
                ),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FeedScreen(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
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

  Future<void> getMyOrders() async {
    try {
      setState(() {
        print('$check>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
        isL = true;
        print(isL);
      });
      check = await Provider.of<Cart>(context, listen: false).myOrders();
    } on HttpException catch (error) {
      String msg = "Unable to process your request";
      if (error.toString().contains("data not found")) {
        msg = "No previous orders found!";
      }
      _showMyDialog(msg);
    } catch (error) {
      print(error);
      _showMyDialog("Something went wrong on our servers");
    }
    setState(() {
      print('$check>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
      isL = false;
      print(isL);
    });
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getMyOrders();
    });
    super.initState();
  }

  @override
  void dispose() {
    check = 0;
    isL = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Food in your cart',
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w900,
                      fontSize: 17.0,
                    ),
                  ),
                  GestureDetector(
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
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        border: Border.all(
                          color: Colors.orange,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        'See Cart',
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            // OrderListView(),
            // Divider(
            //   thickness: 2.0,
            //   indent: 30.0,
            //   endIndent: 30.0,
            // ),
            // Text(
            //   'My Orders',
            //   style: TextStyle(
            //     fontFamily: 'Raleway',
            //     color: Colors.grey[600],
            //     fontWeight: FontWeight.bold,
            //     fontSize: 17.0,
            //   ),
            // ),
            // SizedBox(
            //   height: 20.0,
            // ),
            // FoodListView(),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 4.0),
                    child: Divider(
                      thickness: 2.0,
                    ),
                  ),
                ),
                Text(
                  'Previous Orders',
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 19.0,
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 4.0),
                    child: Divider(
                      thickness: 2.0,
                    ),
                  ),
                ),
              ],
            ),
            isL
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                    ),
                  )
                : Provider.of<Cart>(context).orderedFoods.isEmpty
                    ? Container(
                        margin: EdgeInsets.only(top: 20.0, left: 20.0),
                        child: Text(
                          'No previous orders',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 18.0,
                            fontFamily: "Raleway",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                            Provider.of<Cart>(context).orderedFoods.length,
                        itemBuilder: (context, i) => GestureDetector(
                          onTap: () {
                            // setState(
                            //   () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  color: Color(0xff737373),
                                  height: 306.0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: const Radius.circular(25.0),
                                        topRight: const Radius.circular(25.0),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Stack(
                                          children: [
                                            // Image(
                                            //   image: NetworkImage(
                                            //       '${Provider.of<Cart>(context).orderedFoods[i][2]}'),
                                            //   height: 200.0,
                                            // ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(top: 70.0),
                                              child: ListTile(
                                                title: Text(
                                                  '${Provider.of<Cart>(context).orderedFoods[i][1]}',
                                                  style: TextStyle(
                                                    fontFamily: 'Raleway',
                                                    color: Colors.grey[600],
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 22.0,
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  '₹${Provider.of<Cart>(context).orderedFoods[i][3]}',
                                                  style: TextStyle(
                                                    fontFamily: 'Raleway',
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey[500],
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SmoothStarRating(
                                          allowHalfRating: false,
                                          onRated: (double rating) {
                                            Provider.of<Cart>(context,
                                                    listen: false)
                                                .rateFood("16", rating);
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
                                'Thank you for rating our food!',
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
                                          },
                                          starCount: 5,
                                          size: 50.0,
                                          rating: rating,
                                          color: Colors.orange,
                                          borderColor: Colors.grey[400],
                                          spacing: 15.0,
                                        ),
                                        // FlatButton(
                                        //   shape: RoundedRectangleBorder(
                                        //     borderRadius:
                                        //         BorderRadius.circular(25.0),
                                        //   ),
                                        //   color: Colors.orange,
                                        //   child: Icon(
                                        //     Icons.shopping_cart,
                                        //     size: 20.0,
                                        //     color: Colors.white,
                                        //   ),
                                        //   onPressed: () {
                                        //     Provider.of<Cart>(context,
                                        //             listen: false)
                                        //         .addToCart(Provider.of<Food>(
                                        //                 context,
                                        //                 listen: false)
                                        //             .loadedFoods[1][0]);
                                        //     Provider.of<Cart>(context,
                                        //             listen: false)
                                        //         .getAmount();
                                        //     display();
                                        //   },
                                        // ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                            //   },
                            // );
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 10.0),
                            height: 130.0,
                            child: Card(
                              margin: EdgeInsets.only(bottom: 25.0),
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                side: BorderSide(
                                  color: Colors.grey[400],
                                ),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15.0),
                                      child: Image(
                                        image: NetworkImage(
                                            '${Provider.of<Cart>(context).orderedFoods[i][2]}'),
                                        filterQuality: FilterQuality.high,
                                        height: 80.0,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        '${Provider.of<Cart>(context).orderedFoods[i][1]}',
                                        style: TextStyle(
                                            fontFamily: 'Raleway',
                                            color: Colors.grey[600],
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: 'Price ',
                                          style: TextStyle(
                                              fontFamily: 'Raleway',
                                              color: Colors.grey[600],
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11.0),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text:
                                                  '₹ ${Provider.of<Cart>(context).orderedFoods[i][3]}',
                                              style: TextStyle(
                                                color: Colors.grey[900],
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Delivered',
                                            style: TextStyle(
                                              fontFamily: 'Raleway',
                                              color: Colors.grey[600],
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 40.0,
                                          ),
                                          InkWell(
                                            child: Text(
                                              'Order Again',
                                              style: TextStyle(
                                                fontFamily: 'Raleway',
                                                color: Colors.orange,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                            onTap: () {
                                              Provider.of<Cart>(context,
                                                      listen: false)
                                                  .addToCart(Provider.of<Cart>(
                                                          context,
                                                          listen: false)
                                                      .orderedFoods[i][0]);
                                              display();
                                              Scaffold.of(context)
                                                  .hideCurrentSnackBar();
                                              Scaffold.of(context).showSnackBar(
                                                SnackBar(
                                                  elevation: 2.0,
                                                  backgroundColor:
                                                      Colors.grey[200],
                                                  content: Text(
                                                    'Added item to cart!',
                                                    style: TextStyle(
                                                      color: Colors.orange,
                                                    ),
                                                  ),
                                                  duration:
                                                      Duration(seconds: 2),
                                                ),
                                              );
                                              // Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //     builder: (context) =>
                                              //         CartScreen(),
                                              //   ),
                                              // );
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
