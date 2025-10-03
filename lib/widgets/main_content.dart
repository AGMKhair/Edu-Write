import 'package:eduwrite/widgets/bullet_list.dart';
import 'package:eduwrite/widgets/order_form_widget.dart';
import 'package:flutter/material.dart';

class MainContent extends StatelessWidget {
  const MainContent({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Section
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Learn the essentials while securing",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          height: 1.3,
                        ),
                      ),
                      const Text(
                        "HD Grades!",
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Get customised guidance with your Research papers!",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const BulletListWithIcons(items: [
                        "PhD Tutors",
                        "One-on-One Learning",
                        "Ensure Zero Plagiarism",
                        "On Time Feedback and Delivery",
                        "Turnitin Report For Free",
                        "Assured Confidentiality",
                        "Privacy Guaranteed",
                        "24/7 Grievance Support"
                      ]),
                      const SizedBox(height: 28),
                      ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[700],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 4,
                        ),
                        icon: const Icon(Icons.discount),
                        label: const Text(
                          "Get 50% Off On All New Orders!",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 32),
              // Right Section
              Expanded(
                flex: 3,
                child: OrderForm(title: "Get A Quote In 15 Min.*"),
              ),

            ],
          ),
        );
      },
    );
  }
}
