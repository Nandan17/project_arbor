import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as devtools show log;

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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
      	child: Container(
	        child: Column(
	          children: <Widget>[
	            Container(
	              height: 400,
	              decoration: BoxDecoration(
	                image: DecorationImage(
	                  image: AssetImage('assets/images/background.png'),
	                  fit: BoxFit.fill
	                )
	              ),
	              child: Stack(
	                children: <Widget>[
	                  Positioned(
	                    left: 30,
	                    width: 80,
	                    height: 200,
	                    child: Container(
	                      decoration: BoxDecoration(
	                        image: DecorationImage(
	                          image: AssetImage('assets/images/light-1.png')
	                        )
	                      ),
	                    ),
	                  ),
	                  Positioned(
	                    left: 140,
	                    width: 80,
	                    height: 150,
	                    child: Container(
	                      decoration: BoxDecoration(
	                        image: DecorationImage(
	                          image: AssetImage('assets/images/light-2.png')
	                        )
	                      ),
	                    ),
	                  ),
	                  Positioned(
	                    right: 40,
	                    top: 40,
	                    width: 80,
	                    height: 150,
	                    child: Container(
	                      decoration: BoxDecoration(
	                        image: DecorationImage(
	                          image: AssetImage('assets/images/clock.png')
	                        )
	                      ),
	                    ),
	                  ),
	                  Positioned(
	                    child: Container(
	                      margin: EdgeInsets.only(top: 50),
	                      child: Center(
	                        child: Text("Register", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
	                      ),
	                    ),
	                  )
	                ],
	              ),
	            ),
	            Padding(
	              padding: EdgeInsets.all(30.0),
	              child: Column(
	                children: <Widget>[
	                 Container(
	                    padding: EdgeInsets.all(5),
	                    decoration: BoxDecoration(
	                      color: Colors.white,
	                      borderRadius: BorderRadius.circular(10),
	                      boxShadow: [
	                        BoxShadow(
	                          color: Color.fromRGBO(143, 148, 251, .2),
	                          blurRadius: 20.0,
	                          offset: Offset(0, 10)
	                        )
	                      ]
	                    ),
	                    child: Column(
	                      children: <Widget>[
	                        Container(
	                          padding: EdgeInsets.all(8.0),
	                          decoration: BoxDecoration(
	                            border: Border(bottom: BorderSide(color: Color.fromARGB(220, 220, 220, 220)))
	                          ),
	                          child: TextField(
                              controller: _email,
                              enableSuggestions: false,
                              autocorrect: false,
                              keyboardType: TextInputType.emailAddress,
	                            decoration: InputDecoration(
	                              border: InputBorder.none,
	                              hintText: "Email",
	                              hintStyle: TextStyle(color: Colors.grey[400])
	                            ),
	                          ),
	                        ),
	                        Container(
	                          padding: EdgeInsets.all(8.0),
	                          child: TextField(
                              controller: _password,
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
	                            decoration: InputDecoration(
	                              border: InputBorder.none,
	                              hintText: "Password",
	                              hintStyle: TextStyle(color: Colors.grey[400])
	                            ),
	                          ),
	                        )
	                      ],
	                    ),
	                  ),
                    SizedBox(height: 30,),
                    Container(
                      height: 50,
	                    decoration: BoxDecoration(
	                      borderRadius: BorderRadius.circular(10),
	                      gradient: LinearGradient(
	                        colors: [
	                          Color.fromRGBO(143, 148, 251, 1),
	                          Color.fromRGBO(143, 148, 251, .6),
	                        ]
	                      )
	                    ),
                      child: TextButton(onPressed: () async {
                    
                            final email = _email.text;
                            final password = _password.text;
                    
                            try{
                              await FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: email, 
                              password: password,
                              );
                              FirebaseAuth.instance.currentUser?.sendEmailVerification();
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                '/verify-email-view/', 
                                (route) => false,
                                );
                            } on FirebaseAuthException catch(e) {
                              if(e.code == 'weak-password'){
                                devtools.log('Weak password');
                              } else if(e.code == 'email-already-in-use'){
                                devtools.log('email already exists');
                              } else if(e.code == 'invalid-email'){
                                devtools.log('invalid email');
                              }
                            }
                          }, 
                          
                          child: Center(
                                child: Text("Register", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          ),
                    
                    
                          ),
                      ),


                    TextButton(onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                            '/login/',
                            (route) => false);
                          },
                          child: const Text('Already registered? Login here!'),
                    ),
	                ],
	              ),
	            )
	          ],
	        ),
	      ),
      )
    );
    // return Scaffold(
    //   appBar: AppBar(title: const Text('Register'),
    //   ),
    //   body: Column(
    //     children: [
    //       TextField(
    //         controller: _email,
    //               enableSuggestions: false,
    //               autocorrect: false,
    //               keyboardType: TextInputType.emailAddress,
    //               decoration: const InputDecoration(
    //                 hintText: 'email'
    //               ),
    //             ),
    //       TextField(
    //               controller: _password,
    //               obscureText: true,
    //               enableSuggestions: false,
    //               autocorrect: false,
    //               decoration: const InputDecoration(
    //                 hintText: 'password'
    //               ),
    //             ),

    //       TextButton(onPressed: () async {

    //         final email = _email.text;
    //         final password = _password.text;

    //         try{
    //           await FirebaseAuth.instance.createUserWithEmailAndPassword(
    //           email: email, 
    //           password: password,
    //           );
    //           FirebaseAuth.instance.currentUser?.sendEmailVerification();
    //           Navigator.of(context).pushNamedAndRemoveUntil(
    //             '/verify-email-view/', 
    //             (route) => false,
    //             );
    //         } on FirebaseAuthException catch(e) {
    //           if(e.code == 'weak-password'){
    //             devtools.log('Weak password');
    //           } else if(e.code == 'email-already-in-use'){
    //             devtools.log('email already exists');
    //           } else if(e.code == 'invalid-email'){
    //             devtools.log('invalid email');
    //           }
    //         }
    //       }, 
    //       child: const Text('Register'),
    //       ),
    //       TextButton(onPressed: () {
    //               Navigator.of(context).pushNamedAndRemoveUntil(
    //               '/login/',
    //               (route) => false);
    //             },
    //             child: const Text('Already registered? Login here!'),
    //             )
    //   ]),
    // );
  }
}