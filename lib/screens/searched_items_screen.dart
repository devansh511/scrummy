import 'package:flutter/material.dart';
import 'package:scrummy/screens/home_screen.dart';
import '../screens/search_screen.dart';
import 'package:provider/provider.dart';
import '../providers/search.dart';
import '../providers/cart.dart';
import '../providers/food.dart';

class SearchList extends StatefulWidget {
  final int index;
  const SearchList(this.index);
  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  Future<void> display() async {
    try {
      print('displaying cart');
      await Provider.of<Cart>(context, listen: false).displayCart();
      print('displayed cart');
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
      height: 150.0,
      child: Card(
        margin: EdgeInsets.only(bottom: 25.0, top: 10.0),
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(
            color: Colors.grey[400],
          ),
        ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image(
                  image: NetworkImage(
                      '${Provider.of<Search>(context).searchedFoods[widget.index][2]}'),
                  filterQuality: FilterQuality.high,
                  width: 100.0,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '${Provider.of<Search>(context).searchedFoods[widget.index][1]}',
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
                Text(
                  '${Provider.of<Search>(context).searchedFoods[widget.index][6]}',
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 11.0,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        RichText(
                          text: TextSpan(
                            text:
                                '₹${Provider.of<Search>(context).searchedFoods[widget.index][3]} | ★ ',
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              color: Colors.grey[600],
                              fontWeight: FontWeight.bold,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    '${Provider.of<Search>(context).searchedFoods[widget.index][4]}',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            border: Border.all(
                              color: Colors.orange,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            '${Provider.of<Search>(context).searchedFoods[widget.index][9]}% OFF',
                            style: TextStyle(
                              color: Colors.orange,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 42.0,
                    ),
                    FlatButton(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        side: BorderSide(
                          width: 1.0,
                          color: Colors.orange,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart,
                            color: Colors.orange,
                            size: 18.0,
                          ),
                          Text(
                            'Add',
                            style: TextStyle(
                              color: Colors.orange,
                              fontFamily: 'Raleway',
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Provider.of<Cart>(context, listen: false).addToCart(
                            Provider.of<Search>(context, listen: false)
                                .searchedFoods[widget.index][0]);
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
                        display();
                      },
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SearchItems extends StatefulWidget {
  @override
  _SearchItemsState createState() => _SearchItemsState();
}

class _SearchItemsState extends State<SearchItems> {
  bool _isLoading = false;
  int check = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
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
                    onChanged: (value) async {
                      if (value == null || value == "") {
                        Provider.of<Search>(context).allClear();
                      }
                      setState(() {
                        _isLoading = true;
                      });
                      check = await Provider.of<Search>(context, listen: false)
                          .searchFood(value);
                      setState(() {
                        _isLoading = false;
                      });
                    },
                    onSubmitted: (value) async {
                      if (value == null || value == "") {
                        Provider.of<Search>(context).allClear();
                      }
                      setState(() {
                        _isLoading = true;
                      });
                      check = await Provider.of<Search>(context, listen: false)
                          .searchFood(value);
                      setState(() {
                        _isLoading = false;
                      });
                      if (check != 1) {
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
                              content:
                                  Text('Sorry! We don\'t serve this food yet!'),
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
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => SearchItems()));
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => HomeScreen()));
                      print(value);
                    },
                  ),
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Container(
              //       padding: EdgeInsets.fromLTRB(10.0, 3.0, 10.0, 3.0),
              //       margin: EdgeInsets.only(left: 172.0, right: 5.0),
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(25.0),
              //         border: Border.all(
              //           color: Colors.grey[600],
              //           width: 1,
              //         ),
              //       ),
              //       child: Row(
              //         children: [
              //           Icon(
              //             Icons.filter_list,
              //             color: Colors.grey,
              //           ),
              //           Text(
              //             ' Filter',
              //             style: TextStyle(
              //               color: Colors.grey[600],
              //               fontFamily: 'Raleway',
              //               fontWeight: FontWeight.bold,
              //               fontSize: 13.0,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //     Container(
              //       // width: 10.0,
              //       padding: EdgeInsets.fromLTRB(10.0, 4.0, 10.0, 4.0),
              //       margin: EdgeInsets.only(right: 30.0),
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(25.0),
              //         border: Border.all(
              //           color: Colors.grey[600],
              //           width: 1,
              //         ),
              //       ),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           FaIcon(
              //             FontAwesomeIcons.sortAmountDown,
              //             size: 20.0,
              //             color: Colors.grey,
              //           ),
              //           Text(
              //             ' Sort',
              //             style: TextStyle(
              //               color: Colors.grey[600],
              //               fontFamily: 'Raleway',
              //               fontWeight: FontWeight.bold,
              //               fontSize: 13.0,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
              if (_isLoading)
                Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                  ),
                )
              else
                ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: Provider.of<Search>(context).searchedFoods.length,
                  itemBuilder: (context, i) => SearchList(i),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
