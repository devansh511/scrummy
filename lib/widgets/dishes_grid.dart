import 'package:flutter/material.dart';

class DishesGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.all(10),
        crossAxisSpacing: 8,
        childAspectRatio: 9 / 11,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                15.0,
              ),
              side: BorderSide(
                color: Colors.grey[300],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image(
                    image: AssetImage('assets/burger.png'),
                  ),
                  Text(
                    'McDonald\'s',
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    'Maharaja Mac',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontFamily: 'Raleway',
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '₹189 | ★ ',
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '4.5',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                      SizedBox(
                        width: 40.0,
                      ),
                      Icon(
                        Icons.shopping_cart,
                        color: Colors.grey[600],
                        size: 21.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                15.0,
              ),
              side: BorderSide(
                color: Colors.grey[300],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image(
                    image: AssetImage('assets/burger.png'),
                  ),
                  Text(
                    'McDonald\'s',
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    'Maharaja Mac',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontFamily: 'Raleway',
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '₹189 | ★ ',
                        style: TextStyle(
                          fontFamily: "Raleway",
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '4.5',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                      SizedBox(
                        width: 40.0,
                      ),
                      Icon(
                        Icons.shopping_cart,
                        color: Colors.grey[600],
                        size: 21.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                15.0,
              ),
              side: BorderSide(
                color: Colors.grey[300],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image(
                    image: AssetImage('assets/burger.png'),
                  ),
                  Text(
                    'McDonald\'s',
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    'Maharaja Mac',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontFamily: 'Raleway',
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '₹189 | ★ ',
                        style: TextStyle(
                          fontFamily: "Raleway",
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '4.5',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                      SizedBox(
                        width: 40.0,
                      ),
                      Icon(
                        Icons.shopping_cart,
                        color: Colors.grey[600],
                        size: 21.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                15.0,
              ),
              side: BorderSide(
                color: Colors.grey[300],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image(
                    image: AssetImage('assets/burger.png'),
                  ),
                  Text(
                    'McDonald\'s',
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    'Maharaja Mac',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontFamily: 'Raleway',
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '₹189 | ★ ',
                        style: TextStyle(
                          fontFamily: "Raleway",
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '4.5',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                      SizedBox(
                        width: 40.0,
                      ),
                      Icon(
                        Icons.shopping_cart,
                        color: Colors.grey[600],
                        size: 21.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                15.0,
              ),
              side: BorderSide(
                color: Colors.grey[300],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image(
                    image: AssetImage('assets/burger.png'),
                  ),
                  Text(
                    'McDonald\'s',
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    'Maharaja Mac',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontFamily: 'Raleway',
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '₹189 | ★ ',
                        style: TextStyle(
                          fontFamily: "Raleway",
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '4.5',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                      SizedBox(
                        width: 40.0,
                      ),
                      Icon(
                        Icons.shopping_cart,
                        color: Colors.grey[600],
                        size: 21.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                15.0,
              ),
              side: BorderSide(
                color: Colors.grey[300],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image(
                    image: AssetImage('assets/burger.png'),
                  ),
                  Text(
                    'McDonald\'s',
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    'Maharaja Mac',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontFamily: 'Raleway',
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '₹189 | ★ ',
                        style: TextStyle(
                          fontFamily: "Raleway",
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '4.5',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                      SizedBox(
                        width: 40.0,
                      ),
                      Icon(
                        Icons.shopping_cart,
                        color: Colors.grey[600],
                        size: 21.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
