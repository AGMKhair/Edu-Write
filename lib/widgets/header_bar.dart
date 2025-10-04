import 'package:eduwrite/screens/user/assignment_screen.dart';
import 'package:eduwrite/screens/user/order_form_screen.dart';
import 'package:flutter/material.dart';

class HeaderBar extends StatelessWidget {
  const HeaderBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white, // you may give a background to avoid overlap artifacts
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          Row(
            children: const [
              Icon(Icons.school, color: Colors.blue),
              SizedBox(width: 8),
              Text(
                "My Edu Write ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                "Papers",
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),

          // Navigation
          Row(
            children: [
              const Icon(Icons.phone, size: 16),
              const SizedBox(width: 4),
              const Text('01707004366'),
              const SizedBox(width: 16),
              const Icon(Icons.email, size: 16),
              const SizedBox(width: 4),
              const Text('agmkhair@gmail.com'),
              const SizedBox(width: 16),

              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const AssignmentScreen()),
                  );
                },
                child: const Text("Assignments"),
              ),

           TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const AssignmentScreen()),
                  );
                },
                child: const Text("Assignments"),
              ),

              TextButton(
                onPressed: () {

                },
                child: const Text("Tools"),
              ),

              TextButton(
                onPressed: () {
                  // Similarly for Policies
                },
                child: const Text("Policies"),
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const OrderFormScreen()),
                  );
                },
                child: const Text("Order Now"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
