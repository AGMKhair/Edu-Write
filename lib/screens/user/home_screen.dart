import 'package:eduwrite/widgets/footer_widget.dart';
import 'package:eduwrite/widgets/header_bar.dart';
import 'package:eduwrite/widgets/main_content.dart';
import 'package:eduwrite/widgets/promo_banner.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: const [PromoBanner(), HeaderBar(), MainContent(), Footer()],
          ),
        ),
      ),
    );
  }
}
