// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FullScreenLoader extends StatelessWidget {

  final String texto;
const FullScreenLoader({
    super.key,
    this.texto = "Cargando..."
  });

  @override
  Widget build(BuildContext context) {

    final texStyle = Theme.of(context).textTheme;

    return Stack(
      children: [
        SizedBox.expand(
          child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      "assets/lotties/animation_load.json",
                      width: 200,
                      height: 200
                    ),
                    Text(
                      texto,
                      style: texStyle.titleMedium,
                    )
                  ],
                )
              )
            ),
        ),
      ]
    );
  }
}
