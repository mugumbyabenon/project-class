import 'package:flutter/material.dart';

import 'index_page.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // ignore: dead_code
    return Scaffold(
      backgroundColor: Colors.black38,
      appBar: AppBar(centerTitle: true,
        title: const Text('Welcome to TEOZ CAR collection!!'),
        backgroundColor: Colors.blue
      ),

      body: Column(
        children: [
         
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(20),
            child: const Text('TEOZ CAR collection',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 30
              ),           
            ),           
          ),

          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),           
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'First name' 
              ),                     
              )
            ),

          Container(
             padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Surname',
                ),
              ),
          ),

          
          Container(
             padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                ),
              ),
          ),

          Container(
             padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Confirm Password',
                ),
              ),
          ),

          Container(
             padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
          ),

          Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            margin: const EdgeInsets.all(20),
            child: ElevatedButton(
                child: const Text('Signup'),
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
                  const Text('Already have an account?'),          
                  TextButton(
                    onPressed: (){},
                    child: const Text('Login'),
                    
                  )
            ],
          )
            ]
      )
    );
  }
}