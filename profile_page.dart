import 'package:flutter/material.dart';
import 'background_image.dart';
import 'index_page.dart';



// ignore: must_be_immutable
class ProfilePage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ProfilePage({super.key});


  @override
  Widget build(BuildContext context) {
    return Stack(
     children: [
      const BackgroundImage(),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(centerTitle: true,
        title: const Text('WELCOME TO CAR_LOAN SERVICES!!',
          style: TextStyle(
            color: Colors.white
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 27, 41, 66)
      ),

      body: Column(
        children: [
          Container( 
            // ignore: sort_child_properties_last
            child: const Icon(
              Icons.car_rental_outlined,
              color: Color.fromARGB(255, 192, 113, 23),
              size: 100,
          )
          ),

          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(20),
            child: const Text('CAR_LOAN SERVICES',
            style: TextStyle(
              color: Color.fromARGB(255, 168, 187, 95),
              fontSize: 30
              ),           
            ),           
          ),

          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(15),
            child: const Text('Sign in', 
              style: TextStyle(fontSize: 25,
              color: Colors.white         
              )
            ),
          ),

          Container(
             padding: const EdgeInsets.all(10),
              child: TextField(         
                controller: emailController,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange)
                  ),
                  labelText: 'Email Address',
                  labelStyle: TextStyle(color: Colors.white),
                  
                  
                ),
              ),
          ),

          
          Container(
             padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(                 
                    borderSide: BorderSide(color: Colors.orange)
                  ),
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white)
                ),
              ),
          ),

          Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            margin: const EdgeInsets.all(20),
            child: ElevatedButton(
                child: const Text('Login'),
                onPressed: (){                 
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context){
                      return const IndexPage();
                    },),
                  );
                },)            
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account?",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white
                ),
              ),
              TextButton(
                onPressed: (){}, 
                child: const Text('Log In',
                  style: TextStyle(
                    fontSize: 18
                  ),
                )
                )              
            ]
          ,)
        ],
      ),
    )
     ]
    );
  }
}       