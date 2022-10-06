import 'package:flutter/material.dart';

Future<bool> DeleteAdvert(BuildContext context,){
 return showDialog<bool>(
    context: context, 
    builder: (context){
       return AlertDialog(title: const Text('Remove Advert'),
       content: const Text('Are you sure you want to delete this Advert'),
       actions: [TextButton(
        onPressed: (){
          Navigator.of(context).pop(true);
        },
        child:const Text('ok'),),
        TextButton(onPressed: (){
           Navigator.of(context).pop(false);
        }, 
        child: const Text('Cancel'))
        ],
       );   
    },
    ).then((value) => value ?? false);
}

class PROMPTLOGIN extends StatefulWidget {
  const PROMPTLOGIN({super.key});

  @override
  State<PROMPTLOGIN> createState() => _PROMPTLOGINState();
}

class _PROMPTLOGINState extends State<PROMPTLOGIN> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}




