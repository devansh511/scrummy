import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scrummy/screens/feed_screen.dart';
import 'package:scrummy/screens/home_screen.dart';
import 'package:scrummy/screens/location_screen.dart';
import '../providers/cart.dart';
import 'package:provider/provider.dart';
import '../providers/food.dart';

class ListItems extends StatefulWidget {
  final int i;
  const ListItems(this.i);

  @override
  _ListItemsState createState() => _ListItemsState();
}

class _ListItemsState extends State<ListItems> {
  ScrollController _scrollController;
  bool isLoading = false;
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

  Future<void> display() async {
    try {
      print("display called");
      isLoading = true;
      await Provider.of<Cart>(context, listen: false).displayCart();
      isLoading = false;
    } catch (error) {
      _showMyDialog("Something went wrong on our servers!");
      print(error);
    }
  }

  Future<void> getAmount() async {
    try {
      await Provider.of<Cart>(context, listen: false).getAmount();
    } catch (error) {
      print(error);
      _showMyDialog("Something went wrong on our servers!");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      print('provider calling');
      display();
      getAmount();
      print('provider called');
      print('${Provider.of<Cart>(context, listen: false).loadedFoods}');
    });
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135.0,
      child: Card(
        margin: EdgeInsets.only(bottom: 19.0, top: 10.0),
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
                      '${Provider.of<Cart>(context, listen: false).loadedFoods[widget.i][2]}'),
                  width: 100.0,
                  filterQuality: FilterQuality.high,
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
                  '${Provider.of<Cart>(context, listen: false).loadedFoods[widget.i][1]}',
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${Provider.of<Cart>(context, listen: false).loadedFoods[widget.i][6]}',
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                          fontSize: 11.0),
                    ),
                    SizedBox(
                      width: 120.0,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await Provider.of<Cart>(context, listen: false)
                            .deleteItems(
                                Provider.of<Cart>(context, listen: false)
                                    .loadedFoods[widget.i][0]);
                        Scaffold.of(context).hideCurrentSnackBar();
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            elevation: 2.0,
                            backgroundColor: Colors.grey[200],
                            content: Text(
                              'Item deleted. Pull to refresh cart',
                              style: TextStyle(
                                color: Colors.orange,
                              ),
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        await Provider.of<Cart>(context, listen: false)
                            .getAmount();
                        display();
                      },
                      child: Icon(
                        Icons.delete_outline,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        RichText(
                          text: TextSpan(
                            text:
                                '₹${Provider.of<Cart>(context, listen: false).loadedFoods[widget.i][3]} | 🕑 ',
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              color: Colors.grey[600],
                              fontWeight: FontWeight.bold,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    '${Provider.of<Cart>(context, listen: false).loadedFoods[widget.i][4]}mins',
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
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            border: Border.all(
                              color: Colors.orange,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            '${Provider.of<Cart>(context, listen: false).loadedFoods[widget.i][5]}% OFF',
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
                    // SizedBox(
                    //   width: 10.0,
                    // ),
                    RawMaterialButton(
                      child: Text(
                        '-',
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 21,
                        ),
                      ),
                      onPressed: () {
                        // setState(() {
                        // if ((Provider.of<Cart>(context, listen: false)
                        //         .quant[widget.i][0]) >
                        //     1) {
                        Provider.of<Cart>(context, listen: false)
                            .decreaseQuantity(
                                Provider.of<Cart>(
                                  context,
                                  listen: false,
                                ).loadedFoods[widget.i][0],
                                widget.i);
                        Provider.of<Cart>(context, listen: false).getAmount();
                        // }
                        // });
                      },
                      elevation: 6.0,
                      constraints: BoxConstraints.tightFor(
                        width: 35.0,
                        height: 35.0,
                      ),
                      shape: CircleBorder(
                        side: BorderSide(color: Colors.orange),
                      ),
                    ),
                    Text(
                      Provider.of<Cart>(context).quant.isEmpty
                          ? "${Provider.of<Cart>(context).loadedFoods[widget.i][7]}" ??
                              "1"
                          : '${Provider.of<Cart>(context).quant[widget.i][0]}',
                      style: TextStyle(
                        color: Colors.orange,
                      ),
                    ),
                    RawMaterialButton(
                      child: Text(
                        '+',
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 21,
                        ),
                      ),
                      onPressed: () {
                        print(Provider.of<Cart>(
                          context,
                          listen: false,
                        ).loadedFoods);
                        print('${widget.i}<<<<<<<<>>>>>>>>');
                        setState(() {
                          Provider.of<Cart>(context, listen: false)
                              .increaseQuantity(
                                  Provider.of<Cart>(
                                    context,
                                    listen: false,
                                  ).loadedFoods[widget.i][0],
                                  widget.i);
                          Provider.of<Cart>(context, listen: false).getAmount();
                          print(
                              '${Provider.of<Cart>(context, listen: false).loadedFoods}');
                        });
                      },
                      elevation: 6.0,
                      constraints: BoxConstraints.tightFor(
                        width: 35.0,
                        height: 35.0,
                      ),
                      shape: CircleBorder(
                        side: BorderSide(color: Colors.orange),
                      ),
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

bool isLoading = false;

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 60.0, 12.0, 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'My Cart',
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w900,
                              fontSize: 17.0,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              try {
                                await Provider.of<Cart>(context, listen: false)
                                    .emptyCart();
                                await Provider.of<Cart>(context, listen: false)
                                    .getAmount();
                                await Provider.of<Cart>(context, listen: false)
                                    .displayCart();
                              } catch (error) {
                                print(error);
                                _showMyDialog(
                                    "Something went wrong on our servers!");
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                border: Border.all(
                                  color: Colors.orange,
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                'Clear cart',
                                style: TextStyle(
                                  fontFamily: 'Raleway',
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              RefreshIndicator(
                onRefresh: () async {
                  try {
                    await Provider.of<Cart>(context, listen: false)
                        .displayCart();
                  } catch (error) {
                    print(error);
                    _showMyDialog("Something went wrong on our servers!");
                  }
                },
                backgroundColor: Colors.white,
                color: Colors.orange,
                child: ListView.builder(
                  padding: EdgeInsets.only(
                    top: 10.0,
                  ),
                  physics: AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: Provider.of<Cart>(context).loadedFoods.length,
                  itemBuilder: (_, i) => ListItems(i),
                ),
              ),
              Text(
                '   Payment Summary',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway',
                ),
              ),
              ListTile(
                title: Text(
                  'Total Items',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Text(
                  '${Provider.of<Cart>(context).loadedFoods.length}',
                  style: TextStyle(
                    color: Colors.grey[900],
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'Total Amount',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Text(
                  '₹${Provider.of<Cart>(context).amount}',
                  style: TextStyle(
                    color: Colors.grey[900],
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'Discounted Amount',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Text(
                  '₹${Provider.of<Cart>(context).disAmount}',
                  style: TextStyle(
                    color: Colors.grey[900],
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FlatButton(
              padding: EdgeInsets.only(left: 30.0, right: 30.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.0),
                side: BorderSide(color: Colors.orange),
              ),
              child: Text(
                'Add more food',
                style: TextStyle(
                  color: Colors.orange,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),
            FlatButton(
              padding: EdgeInsets.only(left: 42.0, right: 42.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.0),
              ),
              color: Colors.orange,
              child: Text(
                'Order Now',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () async {
                if (addr2 == "" || addr2 == null) {
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
                          "Scrummy needs your location to deliver your food",
                          style: TextStyle(
                            fontFamily: "Raleway",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
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
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LocationScreen(),
                                ),
                              );
                            },
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
                } else {
                  try {
                    await Provider.of<Cart>(context, listen: false).checkout();
                    return showDialog<void>(
                      context: context,
                      // barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SvgPicture.asset('assets/illustration.svg'),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Text(
                                  'Order Placed',
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'McLaren',
                                    fontSize: 21.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Text(
                                  'Your food is on the way to $addr2',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Text(
                                  'Please keep ₹${Provider.of<Cart>(context).disAmount} ready with you!',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                FlatButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      8.0,
                                    ),
                                  ),
                                  child: Text(
                                    'Go Home!',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Raleway',
                                    ),
                                  ),
                                  color: Colors.orange,
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomeScreen(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } catch (error) {
                    print(error);
                    _showMyDialog("Something went wrong on our servers!");
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
