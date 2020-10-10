import 'package:flutter/material.dart';
import './edit_profile_screen.dart';
import '../auth/auth_screen.dart';
import 'package:provider/provider.dart';
import '../auth/auth.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoading = false;
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Auth>(context, listen: false).getProfile();
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  void _logOut() {
    Provider.of<Auth>(context, listen: false).logout();
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(seconds: 3),
        transitionsBuilder: (BuildContext context, Animation<double> splash,
            Animation<double> auth, Widget child) {
          splash = CurvedAnimation(parent: splash, curve: Curves.elasticIn);

          return ScaleTransition(
            alignment: Alignment.bottomCenter,
            scale: splash,
            child: child,
          );
        },
        pageBuilder: (BuildContext context, Animation<double> splash,
            Animation<double> auth) {
          return AuthScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return (_isLoading)
        ? Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
            ),
          )
        : SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    border: Border.all(
                      width: 1,
                      color: Colors.grey[400],
                    ),
                  ),
                  child: ListTile(
                    // leading: CircleAvatar(
                    //   // minRadius: 5.0,
                    //   maxRadius: 30.0,
                    //   backgroundColor: Colors.orange,
                    // ),
                    title: Text(
                      '${Provider.of<Auth>(context, listen: false).profName}',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                        fontSize: 20.0,
                      ),
                    ),
                    subtitle: Text(
                      '${Provider.of<Auth>(context, listen: false).profEmail}',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 13.0,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // trailing: GestureDetector(
                    //   child: Icon(Icons.edit),
                    //   onTap: () {
                    //     setState(() {
                    //        Navigator.push(
                    //          context,
                    //          MaterialPageRoute(
                    //            builder: (context) => EditProfile(),
                    //        ),
                    //      );
                    //    });
                    //  },
                    // ),
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.only(right: 190.0),
                //   child: Text(
                //     'Account settings',
                //     style: TextStyle(
                //         fontFamily: 'Raleway',
                //         color: Colors.grey[600],
                //         fontWeight: FontWeight.bold,
                //         fontSize: 14.0),
                //     textAlign: TextAlign.left,
                //   ),
                // ),
                // Container(
                //   margin: EdgeInsets.all(10.0),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(15.0),
                //     border: Border.all(
                //       width: 1,
                //       color: Colors.grey[400],
                //     ),
                //   ),
                //   child: GestureDetector(
                //     child: ListTile(
                //       title: Text(
                //         'Address',
                //         style: TextStyle(
                //           fontFamily: 'Raleway',
                //           color: Colors.grey[600],
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //       subtitle: Text(
                //         'Arya Nagar, Kashipur',
                //         style: TextStyle(
                //           fontFamily: 'Raleway',
                //           color: Colors.grey[400],
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //       trailing: Icon(
                //         Icons.chevron_right,
                //         size: 30.0,
                //       ),
                //     ),
                //     onTap: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => EditProfile(),
                //         ),
                //       );
                //     },
                //   ),
                // ),
                // Container(
                //   margin: EdgeInsets.all(10.0),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(15.0),
                //     border: Border.all(
                //       width: 1,
                //       color: Colors.grey[400],
                //     ),
                //   ),
                //   child: ListTile(
                //     title: Text(
                //       'Payment',
                //       style: TextStyle(
                //         fontFamily: 'Raleway',
                //         color: Colors.grey[600],
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //     subtitle: Text(
                //       'Google Pay, Credit Ca...',
                //       style: TextStyle(
                //         fontFamily: 'Raleway',
                //         color: Colors.grey[400],
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //     trailing: Icon(
                //       Icons.chevron_right,
                //       size: 30.0,
                //     ),
                //   ),
                // ),
                // Container(
                //   margin: EdgeInsets.only(right: 220.0, top: 20.0),
                //   child: Text(
                //     'App settings',
                //     style: TextStyle(
                //         fontFamily: 'Raleway',
                //         color: Colors.grey[600],
                //         fontWeight: FontWeight.bold,
                //         fontSize: 14.0),
                //     textAlign: TextAlign.left,
                //   ),
                // ),
                // Container(
                //   margin: EdgeInsets.all(10.0),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(15.0),
                //     border: Border.all(
                //       width: 1,
                //       color: Colors.grey[400],
                //     ),
                //   ),
                //   child: ListTile(
                //     title: Text(
                //       'Push Notifications',
                //       style: TextStyle(
                //         fontFamily: 'Raleway',
                //         color: Colors.grey[600],
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //     subtitle: Text(
                //       'Get notified about food and offers',
                //       style: TextStyle(
                //         fontFamily: 'Raleway',
                //         color: Colors.grey[400],
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //     trailing: Icon(
                //       Icons.chevron_right,
                //       size: 30.0,
                //     ),
                //   ),
                // ),
                // Container(
                //   margin: EdgeInsets.only(right: 250.0, top: 20.0),
                //   child: Text(
                //     'Other',
                //     style: TextStyle(
                //         fontFamily: 'Raleway',
                //         color: Colors.grey[600],
                //         fontWeight: FontWeight.bold,
                //         fontSize: 14.0),
                //     textAlign: TextAlign.left,
                //   ),
                // ),
                // Container(
                //   margin: EdgeInsets.all(10.0),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(15.0),
                //     border: Border.all(
                //       width: 1,
                //       color: Colors.grey[400],
                //     ),
                //   ),
                //   child: ListTile(
                //     title: Text(
                //       'Help & Support',
                //       style: TextStyle(
                //         fontFamily: 'Raleway',
                //         color: Colors.grey[600],
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //     subtitle: Text(
                //       'Reach us for any doubts & queries',
                //       style: TextStyle(
                //         fontFamily: 'Raleway',
                //         color: Colors.grey[400],
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //     trailing: Icon(
                //       Icons.chevron_right,
                //       size: 30.0,
                //     ),
                //   ),
                // ),
                GestureDetector(
                  onTap: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => AuthScreen()));
                  },
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                        width: 1,
                        color: Colors.grey[400],
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        'Logout',
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Icon(
                        Icons.chevron_right,
                        size: 30.0,
                      ),
                      onTap: () {
                        _logOut();
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
