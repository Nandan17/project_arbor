import 'package:arbor/views/home/admin_view.dart';
import 'package:arbor/views/home/master_view.dart';
import 'package:arbor/views/home/public_view.dart';
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
       primaryColor: Colors.blue,
     ),
     home: const HomePage(),
     routes: {
       '/login/':(context) => const LoginView(),
       '/register/':(context) => const RegisterView(),
       '/verify-email-view/':(context) => const VerifyEmailView(),
       '/public/':(context) => const PublicView(),
       '/admin/':(context) => const AdminView(),
       '/master/':(context) => const MasterView(),
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
                     //devtools.log('email verified');
                     return const PublicView();
                   }else{
                     return const VerifyEmailView();
                   }
                }else{
                    return const LoginView();
                }
               
               default:
                  return const CircularProgressIndicator();
          }
          
        },
    );
  }
}

