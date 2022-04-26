import 'package:arbor/views/login_view.dart';
import 'package:arbor/views/register_view.dart';
import 'package:arbor/views/verify_email_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
   MaterialApp(
     title: 'Arbor',
     theme: ThemeData(
       primaryColor: Colors.green,
     ),
     home: const HomePage(),
     routes: {
       '/login/':(context) => LoginView(),
       '/register/':(context) => RegisterView(),
       '/verify-email-view/':(context) => VerifyEmailView(),
     },
   )
  );
}

class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
     builder: (context, snapshot) {
           switch (snapshot.connectionState){
             case ConnectionState.done:
                final user = FirebaseAuth.instance.currentUser;
                if(user != null){
                  
                  if(user.emailVerified){
                     //devtools.log('email varified');
                     //return const LoginView();
                     print('Email is verified');
                   }else{
                     return const VerifyEmailView();
                   }
                }else{
                    return const LoginView();
                }
               
               return const Text('Done');  
               default:
                  return const CircularProgressIndicator();
          }
          
        },
    );
  }
}

