import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40.0,
        backgroundColor: Colors.white,
        shadowColor: Colors.grey,
        elevation: 2.0,
        title: Text(
          'Edit Profile',
          style: TextStyle(
            fontFamily: 'Raleway',
            color: Colors.grey[900],
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
          ),
        ),
      ),
      resizeToAvoidBottomPadding: false,
      body: Container(
        margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, i) => TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(15.0),
                    labelText:
                        i == 0 ? 'Name' : i == 1 ? 'Phone Number' : 'E-mail',
                    labelStyle: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Raleway',
                      fontSize: 10.0,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(19.0, 10.0, 19.0, 14.0),
                  margin: EdgeInsets.only(left: 140.0, bottom: 320.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    border: Border.all(
                      color: Colors.grey[600],
                      width: 1,
                    ),
                  ),
                  child: GestureDetector(
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0,
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
                Container(
                  // width: 10.0,
                  padding: EdgeInsets.fromLTRB(19.0, 10.0, 19.0, 14.0),
                  margin: EdgeInsets.only(right: 20.0, bottom: 320.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    border: Border.all(
                      color: Colors.grey[600],
                      width: 1,
                    ),
                  ),
                  child: GestureDetector(
                    child: Text(
                      ' Save',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0,
                      ),
                    ),
                    onTap: () {},
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
