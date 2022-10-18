import 'package:flutter/material.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 144, 163, 185),
      appBar: AppBar(centerTitle: true,
        title: const Text('WELCOME TO CAR_LOAN SERVICES!!',
          style: TextStyle(
            color: Colors.white
          ),
        ),
        backgroundColor:Color.fromARGB(255, 27, 41, 66),
      ),

      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
             Image.asset(
            'images/that.jpg',
              height: 100,
              width: 100,
              alignment: Alignment.topLeft,
              )
               
            ],
         ),

      bottomNavigationBar: NavigationBar(
        destinations: const[
            NavigationDestination(icon: Icon(Icons.home), label: ''),
            NavigationDestination(icon: Icon(Icons.people), label: '')
        ],
        onDestinationSelected:(int index){
          setState(() {
            currentPage = index;
          });
        } ,
        selectedIndex: currentPage,
      ),
        );
    }
  }



  