import 'package:flutter/material.dart';

class QuoteForm extends StatelessWidget {
  const QuoteForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Get A Quote In 15 Min.*",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 12),
            const TextField(decoration: InputDecoration(labelText: 'Name')),
            const TextField(
              decoration: InputDecoration(labelText: 'Email *'),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                SizedBox(
                  width: 80,
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: "+61"),
                    items: ['+61', '+91', '+1']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (_) {},
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(labelText: 'Phone No.*'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Subject'),
              items: ['Math', 'Science', 'History']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (_) {},
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(labelText: 'Deadline'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Time'),
                    items: ['02:00 PM', '04:00 PM']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (_) {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: () {}, child: const Text("Choose File")),
            const SizedBox(height: 12),
            const TextField(
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Kindly mention your assignment details',
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: const [
                Expanded(child: TextField(decoration: InputDecoration(labelText: 'Captcha'))),
                SizedBox(width: 8),
                ElevatedButton(onPressed: null, child: Text("Verify Captcha"))
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: const [
                Icon(Icons.check, color: Colors.green, size: 16),
                SizedBox(width: 4),
                Flexible(
                  child: Text(
                    "I accept the T&C and all policies of the website and agree to receive offers and updates.",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[700],
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                ),
                child: const Text("Get A Free Quote"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
