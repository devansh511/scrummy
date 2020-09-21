import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scrummy/screens/location_screen.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.edit_location),
          title: Text(
            'Location Here, ',
            style: TextStyle(
              color: Colors.grey[600],
              fontFamily: 'Raleway',
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LocationScreen(),
              ),
            );
          },
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
                          color: Colors.orange,
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
                    image: NetworkImage(
                      'https://hips.hearstapps.com/del.h-cdn.co/assets/16/32/1600x800/landscape-1470840313-delish-subway-brazil-sandwich.png?resize=1200:*',
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
              Container(
                margin: EdgeInsets.only(left: 190.0, right: 8.0),
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
        Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  // margin: EdgeInsets.only(left: 10.0, top: 15.0),
                  width: 116.0,
                  height: 100.0,
                  child: Column(
                    children: <Widget>[
                      Card(
                        elevation: 2.0,
                        color: Colors.white,
                        shadowColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Image(
                          image: NetworkImage(
                            'https://hips.hearstapps.com/del.h-cdn.co/assets/16/32/1600x800/landscape-1470840313-delish-subway-brazil-sandwich.png?resize=1200:*',
                          ),
                          width: 110.0,
                        ),
                      ),
                      Text('Burgers'),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.0, top: 15.0),
                  width: 116.0,
                  height: 72.0,
                  child: Column(
                    children: <Widget>[
                      Card(
                        elevation: 3.0,
                        color: Colors.white,
                        shadowColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Text(
                          'This is card',
                        ),
                      ),
                      Text('Burgers'),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.0, top: 15.0),
                  width: 116.0,
                  height: 72.0,
                  child: Column(
                    children: <Widget>[
                      Card(
                        elevation: 3.0,
                        color: Colors.white,
                        shadowColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Text(
                          'This is card',
                        ),
                      ),
                      Text('Burgers'),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.0, top: 15.0),
                  width: 116.0,
                  height: 72.0,
                  child: Column(
                    children: <Widget>[
                      Card(
                        elevation: 3.0,
                        color: Colors.white,
                        shadowColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Text(
                          'This is card',
                        ),
                      ),
                      Text('Burgers'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
