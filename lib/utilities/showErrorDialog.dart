import 'package:flutter/material.dart';

import '../views/login_view.dart';

Future<void> showErrorDialog(BuildContext context, String text,){
   return showDialog(context: context,builder: (context){
        return AlertDialog(
          title:  const Text('An error occurred '),
          content: Text(text),
          actions: [
            TextButton(onPressed: (){
              Navigator.of(context).pop();
            }
            , child: const Text('OK'))
          ],
        );
   });
}

Future<void> PromptLogin(BuildContext context){
   return showDialog(context: context,builder: (context){
        return AlertDialog(
          title:  const Text('Join our Family Today '),
          content: Text('Reach Out to thousands of customers or obtain unsecured loans'),
          actions: [
            TextButton(onPressed: (){
              Navigator.of(context).pop();
               Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginView()),
            );
            }
            , child: const Text('Login/SignUp'))
          ],
        );
   });
}