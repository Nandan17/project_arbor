import 'package:arbor/utilities/dialogs/error_dialog.dart';
import 'package:arbor/views/dropdown/expandedListAnimationWidget.dart';
import 'package:arbor/views/dropdown/scrollbar.dart';
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
  // List <String> _list =["admin","master","public"];
  // bool isStrechedDropDown = false;
  // int groupValue = 0;
  // String title = 'Login as';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
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
                await showErrorDialog(
                  context, 
                  'User not found',
                  );
              } else if(e.code == 'wrong-password'){
                await showErrorDialog(
                  context, 
                  'Wrong password',
                  );
              } else {
                await showErrorDialog(
                  context, 
                  'Error: ${e.code}',
                  );
              }
            } catch (e) {
              await showErrorDialog(
                  context, 
                  e.toString(),
              );
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


    // return Scaffold(
    //   backgroundColor: Colors.white,
    //   body: SingleChildScrollView(
    //   	child: Container(
	  //       child: Column(
	  //         children: <Widget>[
	  //           Container(
	  //             height: 400,
	  //             decoration: BoxDecoration(
	  //               image: DecorationImage(
	  //                 image: AssetImage('assets/images/background.png'),
	  //                 fit: BoxFit.fill
	  //               )
	  //             ),
	  //             child: Stack(
	  //               children: <Widget>[
	  //                 Positioned(
	  //                   left: 30,
	  //                   width: 80,
	  //                   height: 200,
	  //                   child: Container(
	  //                     decoration: BoxDecoration(
	  //                       image: DecorationImage(
	  //                         image: AssetImage('assets/images/light-1.png')
	  //                       )
	  //                     ),
	  //                   ),
	  //                 ),
	  //                 Positioned(
	  //                   left: 140,
	  //                   width: 80,
	  //                   height: 150,
	  //                   child: Container(
	  //                     decoration: BoxDecoration(
	  //                       image: DecorationImage(
	  //                         image: AssetImage('assets/images/light-2.png')
	  //                       )
	  //                     ),
	  //                   ),
	  //                 ),
	  //                 Positioned(
	  //                   right: 40,
	  //                   top: 40,
	  //                   width: 80,
	  //                   height: 150,
	  //                   child: Container(
	  //                     decoration: BoxDecoration(
	  //                       image: DecorationImage(
	  //                         image: AssetImage('assets/images/clock.png')
	  //                       )
	  //                     ),
	  //                   ),
	  //                 ),
	  //                 Positioned(
	  //                   child: Container(
	  //                     margin: EdgeInsets.only(top: 50),
	  //                     child: Center(
	  //                       child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
	  //                     ),
	  //                   ),
	  //                 )
	  //               ],
	  //             ),
	  //           ),
	  //           Padding(
	  //             padding: EdgeInsets.all(30.0),
	  //             child: Column(
	  //               children: <Widget>[
	  //                Container(
	  //                   padding: EdgeInsets.all(5),
	  //                   decoration: BoxDecoration(
	  //                     color: Colors.white,
	  //                     borderRadius: BorderRadius.circular(10),
	  //                     boxShadow: [
	  //                       BoxShadow(
	  //                         color: Color.fromRGBO(143, 148, 251, .2),
	  //                         blurRadius: 20.0,
	  //                         offset: Offset(0, 10)
	  //                       )
	  //                     ]
	  //                   ),
	  //                   child: Column(
	  //                     children: <Widget>[
	  //                       Container(
	  //                         padding: EdgeInsets.all(8.0),
	  //                         decoration: BoxDecoration(
	  //                           border: Border(bottom: BorderSide(color: Color.fromARGB(220, 220, 220, 220)))
	  //                         ),
	  //                         child: TextField(
    //                           controller: _email,
    //                           enableSuggestions: false,
    //                           autocorrect: false,
    //                           keyboardType: TextInputType.emailAddress,
	  //                           decoration: InputDecoration(
	  //                             border: InputBorder.none,
	  //                             hintText: "Email",
	  //                             hintStyle: TextStyle(color: Colors.grey[400])
	  //                           ),
	  //                         ),
	  //                       ),
	  //                       Container(
	  //                         padding: EdgeInsets.all(8.0),
	  //                         child: TextField(
    //                           controller: _password,
    //                           obscureText: true,
    //                           enableSuggestions: false,
    //                           autocorrect: false,
	  //                           decoration: InputDecoration(
	  //                             border: InputBorder.none,
	  //                             hintText: "Password",
	  //                             hintStyle: TextStyle(color: Colors.grey[400])
	  //                           ),
	  //                         ),
	  //                       )
	  //                     ],
	  //                   ),
	  //                 ),
    //                 //DropdownButton
    //                 SafeArea(
    //                   child: Column(
    //                     children: [
    //                       Row(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           Expanded(
    //                               child: Container(
    //                             decoration: BoxDecoration(
    //                                 border: Border.all(color: Color.fromARGB(220, 220, 220, 220)),
    //                                 borderRadius: BorderRadius.all(Radius.circular(27))
    //                                 ),
    //                             child: Column(
    //                               children: [
    //                                 Container(
    //                                     // height: 45,
    //                                     width: double.infinity,
    //                                     padding: EdgeInsets.only(right: 10),
    //                                     decoration: BoxDecoration(
    //                                         border: Border.all(color: Color.fromARGB(220, 220, 220, 220),),
    //                                         borderRadius:BorderRadius.all(Radius.circular(25))
    //                                         ),
    //                                     constraints: BoxConstraints(
    //                                       minHeight: 45,
    //                                       minWidth: double.infinity,
    //                                     ),
    //                                     alignment: Alignment.center,
    //                                     child: Row(
    //                                       mainAxisAlignment:
    //                                           MainAxisAlignment.spaceBetween,
    //                                       children: [
    //                                         Expanded(
    //                                           child: Padding(
    //                                             padding: const EdgeInsets.symmetric(
    //                                                 horizontal: 20, vertical: 10,),
    //                                             child: Text(
    //                                             title,
    //                                             ),
    //                                           ),
    //                                         ),
                                           
    //                                         GestureDetector(
    //                                             onTap: () {
    //                                               setState(() {
    //                                                 isStrechedDropDown =
    //                                                     !isStrechedDropDown;
    //                                               });
    //                                             },
    //                                             child: Icon(isStrechedDropDown
    //                                                 ? Icons.arrow_upward
    //                                                 : Icons.arrow_downward))
    //                                       ],
    //                                     )),
    //                                 ExpandedSection(
    //                                   expand: isStrechedDropDown,
    //                                   height: 100,
    //                                   child: MyScrollbar(
    //                                     builder: (context, scrollController2) =>
    //                                         ListView.builder(
    //                                             padding: EdgeInsets.all(0),
    //                                             controller: scrollController2,
    //                                             shrinkWrap: true,
    //                                             itemCount: _list.length,
    //                                             itemBuilder: (context, index) {
    //                                               return RadioListTile(
    //                                                 title: Text(_list.elementAt(index)),
    //                                                   value: index,
    //                                                   groupValue: groupValue,
    //                                                   onChanged: (val) {
    //                                                   setState(() {
    //                                                   groupValue = val as int;
    //                                                   title = _list.elementAt(index);
    //                                                   });
    //                                                   });
    //                                             }),
    //                                   ),
    //                                 )
    //                               ],
    //                             ),
    //                           )),
    //                         ],
    //                       )
    //                     ],
    //                   ),
    //                 ),



    //                 SizedBox(height: 30,),
    //                 Container(
    //                   height: 50,
	  //                   decoration: BoxDecoration(
	  //                     borderRadius: BorderRadius.circular(10),
	  //                     gradient: LinearGradient(
	  //                       colors: [
	  //                         Color.fromRGBO(143, 148, 251, 1),
	  //                         Color.fromRGBO(143, 148, 251, .6),
	  //                       ]
	  //                     )
	  //                   ),
    //                   child: TextButton(
    //                     onPressed: () async {
    //                     final email = _email.text;
    //                     final password = _password.text;

    //                     try{
    //                       final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    //                       email: email, 
    //                       password: password,
    //                       );

    //                       devtools.log(userCredential.toString());
    //                       final user = FirebaseAuth.instance.currentUser;
    //                       if(user?.emailVerified ?? false){
    //                         //if users email is varified
    //                         devtools.log(groupValue.toString());
    //                         if(groupValue == 0){
    //                           Navigator.of(context)
    //                         .pushNamedAndRemoveUntil(
    //                         '/admin/',
    //                         (route) => false,);
    //                         }else if(groupValue == 1){
    //                           Navigator.of(context)
    //                         .pushNamedAndRemoveUntil(
    //                         '/master/',
    //                         (route) => false,);
    //                         }else if(groupValue == 2){
    //                           Navigator.of(context)
    //                         .pushNamedAndRemoveUntil(
    //                         '/public/',
    //                         (route) => false,);
    //                         }else{
    //                           devtools.log('Please select one item');
    //                         }
                            
    //                       }else{
    //                         //if users email is not varified
    //                         Navigator.of(context)
    //                         .pushNamedAndRemoveUntil(
    //                         '/verify-email-view/',
    //                         (route) => false,
    //                         );
    //                       }

    //                     } on FirebaseAuthException catch(e){
    //                       if(e.code == 'user-not-found'){
    //                         devtools.log('User not found');
    //                       } else if(e.code == 'wrong-password'){
    //                         devtools.log('wrong password');
    //                       } 
    //                     }
    //                   },
    //                   child: Center(
    //                             child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
    //                       ),
    //                   ),
    //                 ),
    //                 TextButton(onPressed: (){
    //                 Navigator.of(context).pushNamedAndRemoveUntil(
    //                   '/register/',
    //                   (route) => false);
    //                 }, 
    //               child: const Text('Not registered yet? Register here!'),
    //               )
	  //                 // SizedBox(height: 70,),
	  //                 //FadeAnimation(1.5, Text("Forgot Password?", style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),)),
	  //               ],
	  //             ),
	  //           )
	  //         ],
	  //       ),
	  //     ),
    //   )
    // );



    
  }
}