import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scrummy/screens/cart_screen.dart';
import 'package:scrummy/widgets/order_list_view.dart';
import '../widgets/food_list_view.dart';
import 'package:provider/provider.dart';
import '../screens/empty_cart_screen.dart';
import '../providers/cart.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '../providers/food.dart';
import '../providers/cart.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  double rating = 1.0;

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
    Future.delayed(Duration.zero, () async {
      await Provider.of<Cart>(context, listen: false).myOrders();
    });
    super.initState();
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
                    child: Container(
                      margin: EdgeInsets.only(left: 120.0, right: 8.0),
                      child: Text(
                        'See all',
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    onTap: () {
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
            ListView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: (context, i) => GestureDetector(
                onTap: () {
                  setState(
                    () {
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
                                      Image(
                                        image: NetworkImage(''),
                                        height: 200.0,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 70.0),
                                        child: ListTile(
                                          title: Text(
                                            '',
                                            style: TextStyle(
                                              fontFamily: 'McLaren',
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          subtitle: Text(
                                            '',
                                            style: TextStyle(
                                              fontFamily: 'McLaren',
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SmoothStarRating(
                                    allowHalfRating: false,
                                    onRated: (double rating) {
                                      Provider.of<Cart>(context, listen: false)
                                          .rateFood("16", rating);
                                    },
                                    starCount: 5,
                                    size: 50.0,
                                    rating: rating,
                                    color: Colors.orange,
                                    borderColor: Colors.grey[400],
                                    spacing: 15.0,
                                  ),
                                  FlatButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    color: Colors.orange,
                                    child: Icon(
                                      Icons.shopping_cart,
                                      size: 20.0,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      Provider.of<Cart>(context, listen: false)
                                          .addToCart(Provider.of<Food>(context,
                                                  listen: false)
                                              .loadedFoods[1][0]);
                                      Provider.of<Cart>(context, listen: false)
                                          .getAmount();
                                      display();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
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
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Image(
                            image: AssetImage('assets/Untitled.png'),
                            filterQuality: FilterQuality.high,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Maharaja MAC',
                              style: TextStyle(
                                  fontFamily: 'Raleway',
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0),
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Total price ',
                                style: TextStyle(
                                    fontFamily: 'Raleway',
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11.0),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '₹ 189',
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
                                  width: 60.0,
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
                                  onTap: () {},
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
            // SnackBar(
            //   backgroundColor: Colors.orange,
            //   content: Row(
            //     children: [
            //       RichText(
            //         text: TextSpan(
            //           text: '₹189 | ★ ',
            //           style: TextStyle(
            //             fontFamily: 'Raleway',
            //             color: Colors.grey[600],
            //             fontWeight: FontWeight.bold,
            //           ),
            //           children: <TextSpan>[
            //             TextSpan(
            //               text: '4.5',
            //               style: TextStyle(
            //                 color: Colors.grey[700],
            //                 fontFamily: 'Raleway',
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: 12.0,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
