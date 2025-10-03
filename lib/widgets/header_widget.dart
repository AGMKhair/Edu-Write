import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Promo Banner
        Container(
          width: double.infinity,
          color: Colors.blue[900],
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Flexible(
                child: Text(
                  "Enjoy Upto 30% off on all Your Assignments",
                  style: TextStyle(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 10),
              Text(
                "ORDER NOW",
                style: TextStyle(
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        // Custom AppBar-like Header
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo Section
              Row(
                children: const [
                  Icon(Icons.book, color: Colors.blue),
                  SizedBox(width: 8),
                  Text(
                    "My Edu Write",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              // Navigation Menu
              Row(
                children: [
                  TextButton(onPressed: () {}, child: const Text("Assignments")),
                  TextButton(onPressed: () {}, child: const Text("Tools")),
                  TextButton(onPressed: () {}, child: const Text("Policies")),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Order Now"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
