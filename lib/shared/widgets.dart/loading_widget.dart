import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
class LoadingWidget extends StatelessWidget {
const LoadingWidget({ super.key });

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: LoadingAnimationWidget.flickr(leftDotColor: const Color(0x00ffffff), rightDotColor: const Color(0x00917d62), size: 200),
      ),
    );
  }
}