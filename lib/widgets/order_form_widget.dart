import 'dart:convert';
import 'dart:js' as js;

import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

class OrderForm extends StatefulWidget {
  final String? title;

  const OrderForm({super.key, this.title = "Get It Done! Today"});

  @override
  State<OrderForm> createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();

  DateTime? _selectedDate;
  List<PlatformFile> _selectedFiles = [];
  String? _selectedSubject;
  String _selectedCode = "+880";

  final _formKey = GlobalKey<FormState>(); // 👈 Add this to your State class
  bool _isSubmitting = false; // For showing loading

  final List<String> subjects = [
    "Math",
    "Science",
    "History",
    "Programming",
    "English",
  ];

  Future<void> _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      withData: true, // ensure bytes are available
    );

    if (result != null) {
      setState(() {
        _selectedFiles.addAll(result.files);
      });
    }
  }

  Future<void> _pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  String getMimeType(String filename) {
    final ext = filename.split('.').last.toLowerCase();
    switch (ext) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'pdf':
        return 'application/pdf';
      case 'doc':
        return 'application/msword';
      case 'docx':
        return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
      case 'txt':
        return 'text/plain';
      default:
        return 'application/octet-stream'; // fallback
    }
  }

  void _submitForm() async {
    setState(() => _isSubmitting = true);

    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();
    final details = detailsController.text.trim();
    final subject = _selectedSubject ?? "";
    final deliveryDate = _selectedDate?.toIso8601String() ?? "";

    final formJson = jsonEncode({
      'name': name,
      'email': email,
      'phone': '$_selectedCode$phone',
      'subject': subject,
      'details': details,
      'delivery_date': deliveryDate,
    });

    final attachments = <Map<String, dynamic>>[];
    for (var file in _selectedFiles) {
      final bytes = file.bytes;
      if (bytes != null) {
        final base64Str = base64Encode(bytes);
        attachments.add({
          'name': file.name,
          'contentBase64': base64Str,
          'mimeType': getMimeType(file.name),
        });
      }
    }

    js.context.callMethod('sendOrderEmail', [
      formJson,
      jsonEncode(attachments),
    ]);

    setState(() => _isSubmitting = false);
    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 64),
                const SizedBox(height: 16),
                const Text("Your order has been sent successfully!"),
                const SizedBox(height: 24),
                ElevatedButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name *"),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter your name'
                    : null,
              ),

              const SizedBox(height: 8),

              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email *"),
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Please enter your email';
                  final emailRegex = RegExp(
                    r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",
                  );
                  if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
                  return null;
                },
              ),

              const SizedBox(height: 8),

              // Phone
              Row(
                children: [
                  CountryCodePicker(
                    initialSelection: 'BD',
                    favorite: const ['+880', 'BD', '+91'],
                    onChanged: (code) {
                      setState(() {
                        _selectedCode = code.dialCode ?? "+880";
                      });
                    },
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: "Phone No. *",
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter your phone number'
                          : null,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "Subject *"),
                value: _selectedSubject,
                items: subjects
                    .map(
                      (sub) => DropdownMenuItem(value: sub, child: Text(sub)),
                    )
                    .toList(),
                onChanged: (val) => setState(() => _selectedSubject = val),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please select a subject'
                    : null,
              ),

              const SizedBox(height: 8),

              TextFormField(
                controller: detailsController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: "Assignment Details *",
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please provide assignment details'
                    : null,
              ),

              const SizedBox(height: 16),

              // Submit button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _submitForm();
                    }
                  },
                  child: _isSubmitting
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
