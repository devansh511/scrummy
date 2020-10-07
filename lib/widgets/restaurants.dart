import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrummy/providers/food.dart';

class Restaurants extends StatefulWidget {
  final int idx;
  const Restaurants(this.idx);

  @override
  _RestaurantsState createState() => _RestaurantsState();
}

class _RestaurantsState extends State<Restaurants> {
  void _fetch() async {
    try {
      await Provider.of<Restaurant>(context, listen: false).fetchRestaurants();
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () {
      _fetch();
    });
    super.initState();
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
                Card(
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
                            width: 100.0,
                            image: NetworkImage(
                              '${Provider.of<Restaurant>(context).loadedRestaurants[widget.idx][2]}',
                            ),
                            filterQuality: FilterQuality.high,
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
                                '${Provider.of<Restaurant>(context).loadedRestaurants[widget.idx][1]}',
                                style: TextStyle(
                                  fontFamily: 'Raleway',
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                '★ ${Provider.of<Restaurant>(context).loadedRestaurants[widget.idx][3]}',
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
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: Provider.of<Restaurant>(context).loadedRestaurants.length,
      itemBuilder: (context, i) => Restaurants(i),
    );
  }
}
