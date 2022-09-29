import 'package:flutter/material.dart';

class EmptyCategoryScreen extends StatelessWidget {
  const EmptyCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/box.png'),
            const Text('No Products Belong To This Category',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
            const SizedBox(height: 5,),
            const Text('New Products May Be Added Soon',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
            const SizedBox(height: 5,),
            const Text('Stay Tuned',textAlign: TextAlign.start,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
          ],
        ),
      ),
    );
  }
}
