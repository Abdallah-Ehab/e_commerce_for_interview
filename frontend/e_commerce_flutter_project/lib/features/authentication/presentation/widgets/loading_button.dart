import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {

  const LoadingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black
        ),
        onPressed: null,
        child: Center(
          child: CircularProgressIndicator(color: Colors.white,),
        )
      ),
    );
  }
}