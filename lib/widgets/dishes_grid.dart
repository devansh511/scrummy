import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../providers/food.dart';

class DishesGrid extends StatefulWidget {
  @override
  _DishesGridState createState() => _DishesGridState();
}

class _DishesGridState extends State<DishesGrid> {
  Widget _modalBottomSheet = Container(
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
                image: AssetImage('assets/bottomBorder.png'),
                width: 600.0,
              ),
              Container(
                margin: EdgeInsets.only(top: 160.0),
                child: ListTile(
                  title: Text(
                    'McDonald\'s Burger',
                    style: TextStyle(
                      fontFamily: 'McLaren',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Maharaja MAC',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '★4.4            | ',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '32minutes        |',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '₹189',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.zero,
                child: FlatButton(
                  padding: EdgeInsets.fromLTRB(110.0, 10.0, 52.0, 10.0),
                  shape: Border(
                    top: BorderSide(color: Colors.grey),
                    right: BorderSide(color: Colors.grey),
                    bottom: BorderSide(color: Colors.grey),
                  ),
                  child: FaIcon(
                    FontAwesomeIcons.shoppingBag,
                    size: 18.0,
                    color: Colors.grey,
                  ),
                  onPressed: () {},
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.zero,
                child: FlatButton(
                  padding: EdgeInsets.fromLTRB(80.0, 10.0, 80.0, 10.0),
                  shape: Border(
                    top: BorderSide(color: Colors.orange),
                    right: BorderSide(color: Colors.orange),
                    bottom: BorderSide(color: Colors.orange),
                  ),
                  color: Colors.orange,
                  child: Icon(
                    Icons.shopping_cart,
                    size: 20.0,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final dishesData = Provider.of<Food>(context, listen: false).loadedFoods;
    print("Hello");
    print(dishesData);
    return GridView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.all(10),
      itemCount: dishesData.length,
      itemBuilder: (context, i) => GestureDetector(
        child: Card(
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
                  '${dishesData[i][1]}',
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
        onTap: () {
          // _fetch();
          setState(() {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return _modalBottomSheet;
              },
            );
          });
        },
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 9 / 11,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
