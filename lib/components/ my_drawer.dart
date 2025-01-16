import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:labactivity8/pages/handyman_list_page.dart';
import 'package:labactivity8/auth/login_or_register.dart';
import 'package:labactivity8/pages/settings_page.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String uemail = "";
  String uname = "";
  String uchar = "";

  // Fetch current user details
  getCurrentUser() async {
    final userData = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    uemail = userData["uemail"];
    uname = userData["uname"];
    uchar = uname.substring(0, 1);
    setState(() {});
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: ListView(
        children: [
          // Drawer header with user information
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
            ),
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiary,
              ),
              currentAccountPictureSize: const Size.square(45),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                child: Text(
                  uchar,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              accountName: Text(
                uname,
                style: TextStyle(fontSize: 18),
              ),
              accountEmail: Text(uemail),
            ),
          ),

          // Home page list tile
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("HOME"),
            onTap: () {
              // Close drawer and navigate to home page
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HandymanListPage(),
                ),
              );
            },
          ),

          // Settings page list tile
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("SETTINGS"),
            onTap: () {
              // Close drawer and navigate to settings page
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
          ),

          // Logout list tile
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("LOGOUT"),
            onTap: () {
              // Close drawer and navigate to login/register page
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginOrRegister(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
