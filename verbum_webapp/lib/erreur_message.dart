import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:verbum_webapp/game/game.provider.dart';

class ErrorMessage extends StatefulWidget {
  const ErrorMessage({Key? key}) : super(key: key);

  @override
  State<ErrorMessage> createState() => _ErrorMessageState();
}

class _ErrorMessageState extends State<ErrorMessage> with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  CurvedAnimation? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _animation = CurvedAnimation(parent: _controller!, curve: Curves.easeIn, reverseCurve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: Provider.of<GameProvider>(context, listen: false).errorStream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          _controller?.forward();
          Timer(const Duration(seconds: 4), () {
            _controller?.reverse();
          });
          return FadeTransition(
            opacity: _animation!,
            child: Padding(padding: const EdgeInsets.all(8), child: Text(snapshot.data ?? "")),
          );
        }
        return const SizedBox(height: 32.0,);
      },
    );
  }
}
