import 'package:flutter/material.dart';

class Landing extends StatelessWidget {
const Landing({ super.key });

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Super Admin'),
      ),
      body: const Center(
        child: Text('Super Admin'),
      ),
    );
  }
}