import 'package:flutter/material.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Settings Header'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: () {
              // TODO: Update the state of the app.
              // ...

              // Then close the drawer.
              // Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              // TODO: Update the state of the app.
              // ...

              // Then close the drawer.
              // Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Item 3'),
            onTap: () {
              // TODO: Update the state of the app.
              // ...
              
              // Then close the drawer.
              // Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}