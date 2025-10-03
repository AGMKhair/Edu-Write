import 'package:eduwrite/widgets/footer_widget.dart';
import 'package:eduwrite/widgets/order_form_widget.dart';
import 'package:eduwrite/widgets/header_bar.dart';
import 'package:eduwrite/widgets/promo_banner.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AssignmentScreen extends StatelessWidget {
  const AssignmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Consider adding an AppBar for safe area and navigation back
      // appBar: AppBar(title: const Text("Assignment")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const PromoBanner(),
              const HeaderBar(),
              const SizedBox(height: 16),

              // Main content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // If width is narrow (mobile), stack vertically instead of row
                    bool isNarrow = constraints.maxWidth < 600;
                    if (isNarrow) {
                      // vertical layout
                      return Column(
                        children: [
                          _leftContent(),
                          const SizedBox(height: 16),
                          const OrderForm(), // may need constraints inside OrderForm
                        ],
                      );
                    } else {
                      // row layout
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: _leftContent(),
                          ),
                          const SizedBox(width: 16),
                          // Constrain the width of OrderForm to avoid layout error
                          Expanded(
                            flex: 3,
                            child: const OrderForm(),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),

              const SizedBox(height: 32),
              const Footer(),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.extended(
            onPressed: () {},
            label: const Text("WhatsApp\n(Chat Now)"),
            icon: const Icon(FontAwesomeIcons.whatsapp),
            backgroundColor: Colors.green,
          ),
          const SizedBox(height: 8),
          FloatingActionButton.extended(
            onPressed: () {},
            label: const Text("Sales Chat\n(Get Instant Quote)"),
            icon: const Icon(Icons.chat),
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _leftContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Research and Project Management - Computing Technical Project - Computer Science Assignment Help",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            ElevatedButton(onPressed: null, child: Text("Download Solution")),
            SizedBox(width: 8),
            OutlinedButton(onPressed: null, child: Text("Order New Solution")),
          ],
        ),
        SizedBox(height: 16),
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border.fromBorderSide(BorderSide(color: Colors.orange)),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Assignment Task :", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
        ),
      ],
    );
  }
}
