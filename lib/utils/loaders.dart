import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color:const Color(0xff61764B),
      child: Center(

        child:Container(
          padding: const EdgeInsets.only(bottom:20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/loder.png',
                width:150,
                height: 150,
              ),
              const SizedBox(height: 15,),
              const SpinKitSquareCircle(
                  color:Colors.white,
                  size:50.0
              )
            ],
          ),
        )
      ),
    );
  }
}
