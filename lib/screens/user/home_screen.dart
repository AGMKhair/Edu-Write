import 'package:eduwrite/widgets/assignment_form_widget.dart';
import 'package:eduwrite/widgets/footer_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  // final TextEditingController nameController = TextEditingController();
  // final TextEditingController emailController = TextEditingController();
  // final TextEditingController phoneController = TextEditingController();
  // final TextEditingController subjectController = TextEditingController();
  // final TextEditingController detailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top promo banner
            Container(
              width: double.infinity,
              color: Colors.blue[900],
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Enjoy Upto 30% off on all Your Assignments",
                    style: TextStyle(color: Colors.white),
                  ),
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
            // AppBar mimic
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo
                  Row(
                    children: [
                      Icon(Icons.book, color: Colors.blue),
                      SizedBox(width: 8),
                      Text(
                        "Edu Write",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  // Menu
                  Row(
                    children: [
                      TextButton(onPressed: () {}, child: Text("Assignments")),
                      TextButton(onPressed: () {}, child: Text("Tools")),
                      TextButton(onPressed: () {}, child: Text("Policies")),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("Order Now"),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),
            // Main content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left content
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "KF7028 - Research and Project Management - Computing Technical Project - Computer Science Assignment Help",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              child: Text("Download Solution"),
                            ),
                            SizedBox(width: 8),
                            OutlinedButton(
                              onPressed: () {},
                              child: Text("Order New Solution"),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.orange),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Assignment Task :",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Learning Outcomes tested in this assessment (from the Module Descriptor): (KF7028)\n\n"
                                "Knowledge & Understanding:\n"
                                "1. Deploy comprehensive knowledge and understanding of appropriate techniques and tools to plan, research and manage a computing technical project\n\n"
                                "Intellectual / Professional skills & abilities:\n"
                                "2. Systematically identify and analyse a complex computing problem...",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  AssignmentForm(),
                  // Right form
                  /*    Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Text("Get It Done! Today", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          SizedBox(height: 16),
                          TextField(controller: nameController, decoration: InputDecoration(labelText: "Name")),
                          SizedBox(height: 8),
                          TextField(controller: emailController, decoration: InputDecoration(labelText: "Email *")),
                          SizedBox(height: 8),
                          TextField(controller: phoneController, decoration: InputDecoration(labelText: "Phone No.*")),
                          SizedBox(height: 8),
                          TextField(controller: subjectController, decoration: InputDecoration(labelText: "Subject")),
                          SizedBox(height: 8),
                          TextField(controller: detailsController, decoration: InputDecoration(labelText: "Assignment Details"), maxLines: 5),
                          SizedBox(height: 16),
                          ElevatedButton(onPressed: () {}, child: Text("Submit")),
                        ],
                      ),
                    ),
                  ),*/
                ],
              ),
            ),
            SizedBox(height: 32),
            // Footer
            Footer(),
          ],
        ),
      ),
      // Floating chat buttons
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.extended(
            onPressed: () {},
            label: Text("WhatsApp\n(Chat Now)"),
            icon: Icon(FontAwesomeIcons.whatsapp),
            backgroundColor: Colors.green,
          ),
          SizedBox(height: 8),
          FloatingActionButton.extended(
            onPressed: () {},
            label: Text("Sales Chat\n(Get Instant Quote)"),
            icon: Icon(Icons.chat),
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
