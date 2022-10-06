import 'package:car_loan_project/constants/routes.dart';
import 'package:car_loan_project/services/auth/auth_service.dart';
import 'package:car_loan_project/views/billing.dart';
import 'package:car_loan_project/views/login_view.dart';
import 'package:car_loan_project/views/mainpage.dart';
import 'package:car_loan_project/views/notes_view.dart';
import 'package:car_loan_project/views/null.dart';
import 'package:car_loan_project/views/register_view.dart';
import 'package:car_loan_project/views/search.dart';
import 'package:car_loan_project/views/upload.dart';
import 'package:car_loan_project/views/userprofile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.orange,
      ),
      home:  HomePage(),
      routes: {
        loginRoutes: (context) => const LoginView(),
        registerRoutes: (context) => const RegisterView(),
        notesRoutes: (context) => const NotesView(),
         verifyRoutes: (context) =>  Upload(),
         homeRoutes:(context) => const HomePage(),
          NavBarRoutes: (context) =>  NavBar(),
            search: (context) =>  SearchProduct(),
         
      
      } ,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
   
    return FutureBuilder(
        future: AuthService.firebase().intialize(),
        builder:   (context, snapshot) {
          switch (snapshot.connectionState) {
            
            case ConnectionState.done:
            final user =  AuthService.firebase().currentUser;
          
            if (user != null){
               if (user.isEmailVerified == false){
                return const LoginView();
               }
             else {
               return const NotesView();
            }} else {
               return const NotesView();
            }
            
        default: 
        return Container(
         //   constraints: const BoxConstraints.expand(),
         height: MediaQuery.of(context).size.height,
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('imagess/home~2.jpg'), 
            fit: BoxFit.cover)),
          child: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ Image(image: AssetImage('imagess/home~2.jpg'),fit: BoxFit.cover,)
              ],
            ),
          ),
        );
          }
          
        },
      );
  }
  }

 
 class UserInformation extends StatefulWidget {
  @override
    UserInformationState createState() => UserInformationState();
}

class UserInformationState extends State<UserInformation> {
  final Stream<QuerySnapshot<Object?>?> usersStream = FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot?>(
      stream: usersStream,
      builder: (BuildContext? context, AsyncSnapshot<QuerySnapshot<Object?>?> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String?, dynamic> data = document.data()! as Map<String?, dynamic>;
            return ListTile(
              title: Text(data['first_name']),
              subtitle: Text(data['first_name']),
            );
          }).toList(),
        );
      },
    );
  }
}


