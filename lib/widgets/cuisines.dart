import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/food.dart';

class Cuisines extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _fetch() async {
      print("<<<<<<<<<<<<<<<<<<<");
      try {
        await Provider.of<Food>(context, listen: false).fetchFood();
      } catch (error) {
        print(error);
      }
    }

    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Column(
              children: <Widget>[
                Card(
                  elevation: 2.0,
                  color: Colors.white,
                  shadowColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    height: 80.0,
                    child: Image(
                      image: AssetImage(
                        'assets/burger.png',
                      ),
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
                Text(
                  'Burgers',
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                  child: Card(
                    elevation: 2.0,
                    color: Colors.white,
                    shadowColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      height: 80.0,
                      child: Image(
                        image: AssetImage(
                          'assets/chinese.png',
                        ),
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                  onTap: _fetch,
                ),
                Text(
                  'Chinese',
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Card(
                  elevation: 2.0,
                  color: Colors.white,
                  shadowColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    height: 80.0,
                    child: Image(
                      image: AssetImage(
                        'assets/southIndian.png',
                      ),
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
                Text(
                  'South Indian',
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Card(
                  elevation: 2.0,
                  color: Colors.white,
                  shadowColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    height: 80.0,
                    child: Image(
                      image: AssetImage(
                        'assets/non-veg.png',
                      ),
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
                Text(
                  'Non-Veg',
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Card(
                  elevation: 2.0,
                  color: Colors.white,
                  shadowColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    height: 80.0,
                    child: Image(
                      image: AssetImage(
                        'assets/sweets.png',
                      ),
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
                Text(
                  'Sweets',
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
