import 'package:arbor/utilities/dialogs/logout_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

class PublicView extends StatefulWidget {
  const PublicView({ Key? key }) : super(key: key);

  @override
  State<PublicView> createState() => _PublicViewState();
}

class _PublicViewState extends State<PublicView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Public view'),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async{
              switch (value) {
                
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDialog(context);
                  //logout from firebase
                  if(shouldLogout){
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/login/',
                       (_) => false,
                       );
                  }
                  devtools.log(shouldLogout.toString());
                  break;
              }
              devtools.log(value.toString());
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem<MenuAction>(
                value: MenuAction.logout,
                child: Text('Log out'),
                ),
            ];
          },
        )
        ],
    ));
  }
}

enum MenuAction { logout }