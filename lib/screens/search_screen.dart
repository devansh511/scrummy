import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
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
        Container(
          margin: EdgeInsets.only(right: 220.0),
          child: Text(
            'Previous searches',
            style: TextStyle(
              fontFamily: 'Raleway',
              color: Colors.grey[700],
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20.0, top: 15.0),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.watch_later,
                    size: 16,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Burgers',
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Icon(
                    Icons.watch_later,
                    size: 16,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Gulab Jamun',
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Icon(
                    Icons.watch_later,
                    size: 16,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Pizzas',
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
