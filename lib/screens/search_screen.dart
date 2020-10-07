import 'package:flutter/material.dart';
import 'package:scrummy/screens/searched_items_screen.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import '../providers/search.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with ChangeNotifier {
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
                hintText: 'Search your craving',
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                ),
                suffixIcon: Icon(
                  Icons.search,
                ),
              ),
              onChanged: (value) {
                Provider.of<Search>(context, listen: false).searchFood(value);
              },
              onSubmitted: (value) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchItems()));
                print(value);
              },
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
