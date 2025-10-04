import 'package:eduwrite/constants/constants.dart';
import 'package:eduwrite/screens/auth/auth_state.dart';
import 'package:eduwrite/screens/auth/login_screen.dart';
import 'package:eduwrite/screens/user/assignment_screen.dart';
import 'package:eduwrite/screens/user/home_screen.dart';
import 'package:eduwrite/screens/user/order_form_screen.dart';
import 'package:flutter/material.dart';

class HeaderBar extends StatelessWidget {
  bool enableLogin;

  HeaderBar({super.key, this.enableLogin = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      // you may give a background to avoid overlap artifacts
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          InkWell(
            onTap: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (ctx) => HomeScreen())),
            child: Row(
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
          ),

          // Navigation
          Row(
            children: [
              const Icon(Icons.phone, size: 16),
              const SizedBox(width: 4),
              const Text('+880 1917-625661'),
              const SizedBox(width: 16),
              const Icon(Icons.email, size: 16),
              const SizedBox(width: 4),
              const Text('myeduwrite@gmail.com'),
              const SizedBox(width: 16),

              if (enableLogin)
                TextButton(
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (ctx) => LoginScreen()));
                  },
                  child: Text(
                    AuthState.isLoggedIn.value
                        ? AppString.logOut
                        : AppString.login,
                  ),
                ),

              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const AssignmentScreen(),
                    ),
                  );
                },
                child: const Text(AppString.assignments),
              ),

              TextButton(onPressed: () {}, child: const Text("Tools")),

              TextButton(
                onPressed: () {
                  // Similarly for Policies
                },
                child: const Text("Policies"),
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const OrderFormScreen(),
                    ),
                  );
                },
                child: const Text(AppString.orderNow),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
