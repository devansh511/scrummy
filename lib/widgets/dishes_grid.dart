import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:scrummy/models/Http_Exceptions.dart';
import '../providers/food.dart';
import '../providers/cart.dart';
import '../widgets/restaurants.dart';

class GridBuilder extends StatefulWidget {
  final int i;

  const GridBuilder(this.i);
  @override
  _GridBuilderState createState() => _GridBuilderState();
}

class _GridBuilderState extends State<GridBuilder> {
  Color _cartColor = Colors.grey[600];
  bool added = false;
  // bool _isLoading = true;

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
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Continue',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway',
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Provider.of<Cart>(context, listen: false).addToCart(
                    Provider.of<Food>(context, listen: false)
                        .loadedFoods[widget.i][0]);
              },
            ),
            SizedBox(
              width: 10.0,
            ),
            FlatButton(
              child: Text(
                'Cancel',
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

  Future<void> _isAdded(int i) async {
    final check = await Provider.of<Cart>(context, listen: false)
        .isAdded(Provider.of<Food>(context, listen: false).loadedFoods[i][0]);
    if (check == 1) {
      setState(() {
        _cartColor = Colors.orange;
      });
    }
  }

  void _changeColor() {
    setState(() {
      if (_cartColor == Colors.grey[600]) {
        _cartColor = Colors.orange;
      } else {
        _cartColor = Colors.grey[600];
      }
    });
  }

  Future<void> display() async {
    try {
      print('displaying cart');
      await Provider.of<Cart>(context, listen: false).displayCart();
      print('displayed cart');
    } catch (error) {
      print(error);
    }
  }

  Future<void> addToCart() async {
    try {
      await Provider.of<Cart>(context, listen: false).addToCart(
          Provider.of<Food>(context, listen: false).loadedFoods[widget.i][0]);
    } on HttpException catch (error) {
      var errorMsg = "Something went wrong";
      if (error.toString().contains("conflicting restaurants")) {
        errorMsg =
            "Adding food from different restaurant will clear your existing cart!";
      }
      _showMyDialog(errorMsg);
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(left: 7.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        '${Provider.of<Food>(context).loadedFoods[widget.i][2]}'),
                    // width: 128.0,
                    height: 127.0,
                  ),
                ),
              ),
              onTap: () {
                // setState(() {
                //   showModalBottomSheet(
                //       context: context,
                //       builder: (context) {
                //         return Container(
                //           color: Color(0xff737373),
                //           height: 306.0,
                //           child: Container(
                //             decoration: BoxDecoration(
                //               color: Colors.white,
                //               borderRadius: BorderRadius.only(
                //                 topLeft: const Radius.circular(25.0),
                //                 topRight: const Radius.circular(25.0),
                //               ),
                //             ),
                //             child: Column(
                //               children: [
                //                 Stack(
                //                   children: [
                //                     Image(
                //                       image: NetworkImage(
                //                           '${Provider.of<Food>(context).loadedFoods[widget.i][2]}'),
                //                       height: 200.0,
                //                     ),
                //                     Container(
                //                       margin: EdgeInsets.only(top: 160.0),
                //                       child: ListTile(
                //                         title: Text(
                //                           '${Provider.of<Food>(context).loadedFoods[widget.i][1]}',
                //                           style: TextStyle(
                //                             fontFamily: 'McLaren',
                //                             color: Colors.white,
                //                             fontWeight: FontWeight.bold,
                //                           ),
                //                         ),
                //                         subtitle: Text(
                //                           '${Provider.of<Food>(context).loadedFoods[widget.i][9]}',
                //                           style: TextStyle(
                //                             fontFamily: 'McLaren',
                //                             fontWeight: FontWeight.bold,
                //                             color: Colors.white,
                //                           ),
                //                         ),
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //                 Row(
                //                   mainAxisAlignment:
                //                       MainAxisAlignment.spaceEvenly,
                //                   children: [
                //                     Text(
                //                       '★${Provider.of<Food>(context).loadedFoods[widget.i][4]}            | ',
                //                       style: TextStyle(
                //                         fontFamily: 'Raleway',
                //                         color: Colors.grey[600],
                //                         fontWeight: FontWeight.bold,
                //                       ),
                //                     ),
                //                     Text(
                //                       '🕑${Provider.of<Food>(context).loadedFoods[widget.i][8]}mins        |',
                //                       style: TextStyle(
                //                         fontFamily: 'Raleway',
                //                         color: Colors.grey[600],
                //                         fontWeight: FontWeight.bold,
                //                       ),
                //                     ),
                //                     Text(
                //                       '₹${Provider.of<Food>(context).loadedFoods[widget.i][3]}',
                //                       style: TextStyle(
                //                         fontFamily: 'Raleway',
                //                         color: Colors.grey[600],
                //                         fontWeight: FontWeight.bold,
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //                 ClipRRect(
                //                   borderRadius: BorderRadius.circular(30.0),
                //                   child: FlatButton(
                //                     color: Colors.orange,
                //                     child: Icon(
                //                       Icons.shopping_cart,
                //                       size: 20.0,
                //                       color: Colors.white,
                //                     ),
                //                     onPressed: () {},
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         );
                //       });
                // });
              },
            ),
            Text(
              '${Provider.of<Food>(context).loadedFoods[widget.i][1]}',
              style: TextStyle(
                fontFamily: 'Raleway',
                color: Colors.grey[800],
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),
              textAlign: TextAlign.left,
            ),
            Text(
              '${Provider.of<Food>(context).loadedFoods[widget.i][9]} | 🕑${Provider.of<Food>(context).loadedFoods[widget.i][8]}mins',
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
                  '₹${Provider.of<Food>(context).loadedFoods[widget.i][3]} | ★ ',
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${Provider.of<Food>(context).loadedFoods[widget.i][4]}',
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
                GestureDetector(
                  onTap: () {
                    Scaffold.of(context).hideCurrentSnackBar();
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        elevation: 2.0,
                        backgroundColor: Colors.grey[200],
                        content: Text(
                          'Added item to cart!',
                          style: TextStyle(
                            color: Colors.orange,
                          ),
                        ),
                        duration: Duration(seconds: 2),
                        // action: SnackBarAction(
                        //   label: 'UNDO',
                        //   onPressed: () {
                        //     // cart.removeSingleItem(product.id);
                        //     Provider.of<Cart>(context, listen: false)
                        //         .deleteItems(
                        //             Provider.of<Cart>(context, listen: false)
                        //                 .loadedFoods[widget.i][0]);
                        //   },
                        // ),
                      ),
                    );
                    addToCart();
                    Provider.of<Cart>(context, listen: false).getAmount();
                    display();
                  },
                  child: Icon(
                    Icons.shopping_cart,
                    color: _cartColor,
                    size: 21.0,
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

class DishesGrid extends StatefulWidget {
  @override
  _DishesGridState createState() => _DishesGridState();
}

class _DishesGridState extends State<DishesGrid> {
  bool _isLoading = true;

  @override
  void initState() {
    if (check == 2) {
      setState(() {
        _isLoading = false;
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _isLoading = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 40.0),
            child: (_isLoading)
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                    ),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.all(10),
                    itemCount: Provider.of<Food>(context).loadedFoods.length,
                    itemBuilder: (_, i) => GridBuilder(i),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 9 / 11,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
