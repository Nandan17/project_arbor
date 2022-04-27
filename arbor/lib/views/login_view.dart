import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

class LoginView extends StatefulWidget {
  const LoginView({ Key? key }) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState(){
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose(){
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

 List<String> items = <String>['admin','master','public'];
 String selectedItem = 'admin';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Email'
            ),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: 'password'
            ),
          ),
          DropdownButton<String>(
            //hint: const Text('Select one'),
            value: selectedItem,
            items: items.map((String item) => DropdownMenuItem<String>(
                   value: item,
                   child: Text(item)
                  ),
                  ).toList(),
              onChanged: (item) => setState(() {
                selectedItem = item!;
              }),
          ),
          TextButton(
            onPressed: () async {
             final email = _email.text;
             final password = _password.text;

            try{
              final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: email, 
              password: password,
              );

              devtools.log(userCredential.toString());
              final user = FirebaseAuth.instance.currentUser;
              if(user?.emailVerified ?? false){
                //if users email is varified
                devtools.log(selectedItem.toString());
                if(selectedItem == 'admin'){
                  Navigator.of(context)
                .pushNamedAndRemoveUntil(
                '/admin/',
                (route) => false,);
                }else if(selectedItem == 'master'){
                  Navigator.of(context)
                .pushNamedAndRemoveUntil(
                '/master/',
                (route) => false,);
                }else if(selectedItem == 'public'){
                  Navigator.of(context)
                .pushNamedAndRemoveUntil(
                '/public/',
                (route) => false,);
                }else{
                  devtools.log('Please select one item');
                }
                
              }else{
                //if users email is not varified
                Navigator.of(context)
                .pushNamedAndRemoveUntil(
                '/verify-email-view/',
                (route) => false,
                );
              }

            } on FirebaseAuthException catch(e){
              if(e.code == 'user-not-found'){
                devtools.log('User not found');
              } else if(e.code == 'wrong-password'){
                devtools.log('wrong password');
              } 
            }
          },
           child: const Text('Login')
          ),
           TextButton(onPressed: (){
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/register/',
                    (route) => false);
                }, 
                child: const Text('Not registered yet? Register here!'),
                )
      ]),
    );
  }
}