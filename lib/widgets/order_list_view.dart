import 'package:flutter/material.dart';

class OrderListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
                        fontSize: 14.0),
                  ),
                  Text(
                    'Burgers',
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                      fontSize: 11.0,
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
                          Container(
                            padding: EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              border: Border.all(
                                color: Colors.orange,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              '20% OFF',
                              style: TextStyle(
                                color: Colors.orange,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.bold,
                                fontSize: 13.0,
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
    );
  }
}
