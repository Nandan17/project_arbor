import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({ Key? key }) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify the email'),),
      body: Column(
        children: [
          const Text('We\'ve sent to you an email varification. Please oprn it to verify your account'),
          const Text('If you haven\'t received a varification email yet, press the button below'),
          TextButton(
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;
              await user?.sendEmailVerification();
              },
              child:const Text('Send email varification'),
           ),
            TextButton(
             onPressed: () async{
               await FirebaseAuth.instance.signOut();
               Navigator.of(context).pushNamedAndRemoveUntil(
                 '/register/',
                 (route) => false,
                 );
             },
             child: const Text("Restart"),
             )
        ],
      ),
    );
  }
}
