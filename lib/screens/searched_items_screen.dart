import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 50.0,
            margin: EdgeInsets.all(20.0),
            child: Theme(
              data: ThemeData(primaryColor: Colors.grey[400]),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  fillColor: Colors.white,
                  focusColor: Colors.grey,
                  hintText: '     Search your craving',
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                  ),
                  suffixIcon: Icon(
                    Icons.search,
                  ),
                ),
                onTap: () {},
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(10.0, 3.0, 10.0, 3.0),
                margin: EdgeInsets.only(left: 172.0, right: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(
                    color: Colors.grey[600],
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.filter_list,
                      color: Colors.grey,
                    ),
                    Text(
                      ' Filter',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                // width: 10.0,
                padding: EdgeInsets.fromLTRB(10.0, 4.0, 10.0, 4.0),
                margin: EdgeInsets.only(right: 30.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(
                    color: Colors.grey[600],
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.sortAmountDown,
                      size: 20.0,
                      color: Colors.grey,
                    ),
                    Text(
                      ' Sort',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ListView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: 6,
            itemBuilder: (context, i) => Container(
              margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
              height: 150.0,
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
                            fontSize: 14.0,
                          ),
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
                              width: 42.0,
                            ),
                            FlatButton(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                side: BorderSide(
                                  width: 1.0,
                                  color: Colors.grey,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.shopping_cart,
                                    color: Colors.grey,
                                    size: 18.0,
                                  ),
                                  Text(
                                    'Add',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: 'Raleway',
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
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
        ],
      ),
    );
  }
}
