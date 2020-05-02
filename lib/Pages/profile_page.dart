import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Models/user.dart';
import 'package:shop_app/reusables/components.dart';
import 'package:shop_app/reusables/constants.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text('Settings'),
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('Users')
            .document(user.phone)
            .snapshots(),
        builder: (context, snap) {
          if (snap.hasData) {
            User user = User.fromfirebase(snap.data);
            return _buildUserForm(user);
          } else
            return Text('Loading');
        },
      ),
    );
  }

  Widget _buildUserForm(User user) {
    return Column(
      // TODO UI

      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Stack(fit: StackFit.loose, children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  radius: 70,
                )
              ],
            ),
            Padding(
                padding: EdgeInsets.only(top: 90.0, left: 100.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.orangeAccent,
                      radius: 25.0,
                      child: new Icon(
                        CupertinoIcons.photo_camera,
                        color: Colors.white,
                      ),
                    )
                  ],
                )),
          ]),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.3,
          child: TextField(
            decoration: kInputDecoration.copyWith(
              prefixIcon: Icon(CupertinoIcons.person),
              hintText: user.name,
            ),
          ),
        ),
        SizedBox(height: 5),
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.3,
          child: TextField(
            decoration: kInputDecoration.copyWith(
              prefixIcon: Icon(CupertinoIcons.phone),
              hintText: user.phone,
            ),
          ),
        ),
        SizedBox(height: 5),
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.3,
          child: TextField(
            decoration: kInputDecoration.copyWith(
              prefixIcon: Icon(CupertinoIcons.phone_solid),
              hintText: user.alternatePhoneNumber,
            ),
          ),
        ),
        SizedBox(height: 5),
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.3,
          child: TextField(
            decoration: kInputDecoration.copyWith(
              prefixIcon: Icon(CupertinoIcons.location),
              hintText: user.address,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          elevation: 10,
          child: Buttons(
            buttonColor: Colors.orangeAccent,
            text: "Update Profile",
            icon: Icons.done,
          ),
        )
      ],
    );
  }
}
