import 'package:flutter/material.dart';

class OrWidget extends StatelessWidget {
  const OrWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(height: 2,color: Colors.grey,width: 150,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text("or",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.normal))),
        Container(height: 2,color: Colors.grey,width:150,)
      ],
    );
  }
}