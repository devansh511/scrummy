import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrummy/models/Http_Exceptions.dart';
import 'package:scrummy/providers/food.dart';
import 'package:scrummy/widgets/dishes_grid.dart';

class Restaurants extends StatefulWidget {
  final int idx;
  const Restaurants(this.idx);

  @override
  _RestaurantsState createState() => _RestaurantsState();
}

bool isLoad = false;
int check = 0;

class _RestaurantsState extends State<Restaurants> {
  // void _fetchR() async {
  //   try {
  //     await Provider.of<Restaurant>(context, listen: false).fetchRestaurants();
  //   } catch (error) {
  //     print(error);
  //   }
  // }
  Future<void> _showMyDialog(String msg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Foodies Alert',
            style: TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          content: Text(
            msg,
            style: TextStyle(
              fontFamily: "Raleway",
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Okay',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway',
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _fetchRestFood(String restName) async {
    try {
      setState(() {
        isLoad = true;
      });
      check = await Provider.of<Food>(context, listen: false)
          .fetchRestFood(restName);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DishesGrid(),
        ),
      );
    } on HttpException catch (error) {
      String msg = "Unable to process your request";
      if (error.toString().contains("Error message")) {
        msg = "";
      }
      _showMyDialog(msg);
      print(error);
    } catch (error) {
      print(error);
      _showMyDialog("Something went wrong our servers");
    }
    setState(() {
      isLoad = false;
    });
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
                      width: 150.0,
                      height: 160.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image(
                              width: 147.0,
                              image: NetworkImage(
                                '${Provider.of<Food>(context).loadedRestaurants[widget.idx][2]}' ??
                                    'https://5.imimg.com/data5/SP/FB/RP/SELLER-92009985/ready-to-eat-north-indian-food-non-veg-food-500x500.jpg',
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
