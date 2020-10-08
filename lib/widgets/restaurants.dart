import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrummy/providers/food.dart';

class Restaurants extends StatefulWidget {
  final int idx;
  const Restaurants(this.idx);

  @override
  _RestaurantsState createState() => _RestaurantsState();
}

bool isLoad = false;

class _RestaurantsState extends State<Restaurants> {
  // void _fetchR() async {
  //   try {
  //     await Provider.of<Restaurant>(context, listen: false).fetchRestaurants();
  //   } catch (error) {
  //     print(error);
  //   }
  // }
  void _fetchRestFood(String restName) async {
    try {
      setState(() {
        isLoad = true;
      });
      await Provider.of<Food>(context, listen: false).fetchRestFood(restName);
      setState(() {
        isLoad = false;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
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
                      width: 168.0,
                      height: 170.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image(
                              width: 147.0,
                              image: NetworkImage(
                                '${Provider.of<Food>(context).loadedRestaurants[widget.idx][2]}',
                              ),
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: 8.0,
                              top: 8.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${Provider.of<Food>(context).loadedRestaurants[widget.idx][1]}',
                                  style: TextStyle(
                                    fontFamily: 'Raleway',
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  '★ ${Provider.of<Food>(context).loadedRestaurants[widget.idx][3]}',
                                  style: TextStyle(
                                    fontFamily: 'Raleway',
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    _fetchRestFood(Provider.of<Food>(context, listen: false)
                        .loadedRestaurants[widget.idx][1]);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RestaurantList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: Provider.of<Food>(context).loadedRestaurants.length,
      itemBuilder: (_, i) => Restaurants(i),
    );
  }
}
