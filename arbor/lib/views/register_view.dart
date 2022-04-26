import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class RegisterView extends StatefulWidget {
  const RegisterView({ Key? key }) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState(){
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose(){ //dispose the Textediting controller
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'email'
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

          TextButton(onPressed: () async {

            final email = _email.text;
            final password = _password.text;

            try{
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: email, 
              password: password,
              );
              FirebaseAuth.instance.currentUser?.sendEmailVerification();
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/verify-email-route', 
                (route) => false,
                );
            } on FirebaseAuthException catch(e) {
              if(e.code == 'weak-password'){
                print('Weak password');
              } else if(e.code == 'email-already-in-use'){
                print('email already exists');
              } else if(e.code == 'invalid-email'){
                print('invalid email');
              }
            }
          }, 
          child: const Text('Register'),
          ),
          TextButton(onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                  '/login/',
                  (route) => false);
                },
                child: const Text('Already registered? Login here!'),
                )
      ]),
    );
  }
}