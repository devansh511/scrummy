import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scrummy/screens/cart_screen.dart';
import 'package:scrummy/widgets/order_list_view.dart';
import '../widgets/food_list_view.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    final snackbar = SnackBar(
      content: Row(
        children: [
          Text(
            'Total price ',
            style: TextStyle(
              fontFamily: 'Raleway',
              color: Colors.white,
            ),
          ),
          Text(
            ' ₹189',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          FlatButton(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            color: Colors.orange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
              side: BorderSide(
                width: 1.0,
                color: Colors.orange,
              ),
            ),
            child: Text(
              'Pay Now',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Raleway',
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: Colors.orange,
      duration: Duration(days: 365),
    );
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
                          builder: (context) => CartScreen(),
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
            OrderListView(),
            Divider(
              thickness: 2.0,
              indent: 30.0,
              endIndent: 30.0,
            ),
            Text(
              'My Orders',
              style: TextStyle(
                fontFamily: 'Raleway',
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
                fontSize: 17.0,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            FoodListView(),
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
                    fontSize: 12.0,
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
              itemBuilder: (context, i) => Container(
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
