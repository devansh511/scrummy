import 'package:flutter/material.dart';

class FoodListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (context, i) => Container(
        height: 130.0,
        child: Card(
          margin: EdgeInsets.only(bottom: 25.0),
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
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Image(
                  image: AssetImage('assets/Untitled.png'),
                  filterQuality: FilterQuality.high,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Maharaja MAC',
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Total price ',
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                          fontSize: 11.0),
                      children: <TextSpan>[
                        TextSpan(
                          text: '₹ 189',
                          style: TextStyle(
                            color: Colors.grey[900],
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Will be delivered in ',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '32min',
                          style: TextStyle(
                            color: Colors.grey[900],
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
