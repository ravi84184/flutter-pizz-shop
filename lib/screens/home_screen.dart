import 'package:flutter/material.dart';
import '../widgets/desktop_layout.dart';
import '../widgets/mobile_layout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 800) {
            return const MobileLayout();
          }
          return const DesktopLayout();
        },
      ),
    );
  }
}
