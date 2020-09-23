import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 12.0),
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
                  Container(
                    margin: EdgeInsets.only(left: 120.0, right: 8.0),
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
                  ),
                ],
              ),
            ),
            ListView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: (context, i) => Container(
                height: 130.0,
                child: Card(
                  margin: EdgeInsets.only(bottom: 25.0, top: 10.0),
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
                        padding: const EdgeInsets.all(8.0),
                        child: Image(
                          image: AssetImage('assets/Untitled.png'),
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
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
                                fontSize: 18.0),
                          ),
                          Text(
                            'Burgers',
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              color: Colors.grey[600],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: '₹189 | ★ ',
                                      style: TextStyle(
                                        fontFamily: 'Raleway',
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: '4.5',
                                          style: TextStyle(
                                            color: Colors.grey[700],
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(25.0),
                                    child: Text(
                                      '20% OFF',
                                      style: TextStyle(
                                        color: Colors.orange,
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 50.0,
                              ),
                              FlatButton(
                                padding: EdgeInsets.symmetric(horizontal: 15.0),
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  side: BorderSide(
                                    width: 1.0,
                                    color: Colors.orange,
                                  ),
                                ),
                                child: Text(
                                  'Order Now',
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontFamily: 'Raleway',
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () {},
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Divider(
              thickness: 2.0,
              indent: 40.0,
              endIndent: 40.0,
            ),
            Text(
              'My Orders',
              style: TextStyle(
                fontFamily: 'Raleway',
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            ListView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, i) => Container(
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
                                fontSize: 18.0),
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Total prize ',
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                color: Colors.grey[600],
                                fontWeight: FontWeight.bold,
                              ),
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
                          RichText(
                            text: TextSpan(
                              text: 'Will be delivered in ',
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                color: Colors.grey[600],
                                fontWeight: FontWeight.bold,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '32min',
                                  style: TextStyle(
                                    color: Colors.grey[900],
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
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
