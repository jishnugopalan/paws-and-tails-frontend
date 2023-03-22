import 'package:flutter/material.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
class IntroSlider extends StatelessWidget {
  const IntroSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pages=[
      PageViewModel(
        title: Text("Paws & Tails",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
        pageColor: Colors.green,
        body: Text(
          'Pet store to your door',style: TextStyle(fontSize: 20),
        ),

        // mainImage: Container(
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.all(Radius.circular(20)),
        //     border: Border()
        //   ),
        //   child: Image.asset(
        //     'assets/images/EcoSentry-Logo2.png',
        //     alignment: Alignment.center,
        //   ),
        // ),
      ),
      PageViewModel(
        title: Text("Paws & Tails",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
        pageColor: Colors.green,
        body: Text(
          'We take care your pets',style: TextStyle(fontSize: 20),
        ),
      ),
      PageViewModel(
        title: Text("Paws & Tails",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
        pageColor: Colors.green,
        body: Text(
          'Take better care of your pets',style: TextStyle(fontSize: 20),
        ),
      ),

    ];
    return Builder(
      builder: (context) => IntroViewsFlutter(
        pages,
        showNextButton: true,
        showBackButton: true,
        onTapDoneButton: () {
          Navigator.pushNamed(context, '/login');
        },
        pageButtonTextStyles: const TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
    );
  }
}