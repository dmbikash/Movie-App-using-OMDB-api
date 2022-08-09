import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.network('https://images.unsplash.com/photo-1628155930542-3c7a64e2c833?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80'),
          Text('No Movie found', style: TextStyle(fontSize: 30),),

        ],

      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade800,width: 4,),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(5),
        child: GNav(

          onTabChange: (index){

            if(index==2){
              // Navigator.pushNamed(context,'/');
              // Navigator.pushNamedAndRemoveUntil(context, "/", (r) => false);
              print("search page ");
            }
            if(index==1){
              Navigator.pushNamed(context, "imagePage");
            }
            if(index==0){
              Navigator.pop(context);
            }


          },
          //activeColor: Colors.teal[500],
          color: Colors.grey,
          padding: EdgeInsets.symmetric(horizontal: 125, vertical: 10),
          tabs: [

            GButton(icon: Icons.search,text: 'search again')
          ],
        ),
      ),
    );
  }
}
