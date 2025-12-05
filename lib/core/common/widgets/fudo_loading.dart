import 'package:flutter/material.dart';

class FudoLoading extends StatelessWidget {
  const FudoLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator.adaptive();
  }
}
