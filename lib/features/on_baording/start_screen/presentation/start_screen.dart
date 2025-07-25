import 'package:flutter/material.dart';
import 'package:to_do_app/features/on_baording/start_screen/presentation/widget/start_screen_body.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: StartScreenBody(),
    );
  }
}
