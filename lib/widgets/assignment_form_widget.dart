import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:intl/intl.dart';

class AssignmentForm extends StatefulWidget {
  const AssignmentForm({super.key});

  @override
  State<AssignmentForm> createState() => _AssignmentFormState();
}

class _AssignmentFormState extends State<AssignmentForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();

  DateTime? _selectedDate;
  List<PlatformFile> _selectedFiles = [];
  String? _selectedSubject;
  String _selectedCode = "+880"; // default BD

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

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(8),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Get It Done! Today",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 16),

              // Name
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              const SizedBox(height: 8),

              // Email
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email *"),
              ),
              const SizedBox(height: 8),

              // Phone with Country Code Picker
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
                    child: TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(labelText: "Phone No.*"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Subject Dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "Subject"),
                value: _selectedSubject,
                items: subjects
                    .map(
                      (sub) => DropdownMenuItem(value: sub, child: Text(sub)),
                )
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedSubject = val;
                  });
                },
              ),
              const SizedBox(height: 8),

              // Details
              TextField(
                controller: detailsController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: "Assignment Details",
                ),
              ),
              const SizedBox(height: 16),

              // File Upload Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: _pickFiles,
                    icon: const Icon(Icons.upload_file),
                    label: const Text("Choose Files"),
                  ),
                  // IconButton(
                  //   onPressed: _pickFiles,
                  //   icon: const Icon(Icons.add_circle, color: Colors.blue),
                  // ),
                ],
              ),
              const SizedBox(height: 8),

              // Show selected files
              _selectedFiles.isNotEmpty
                  ? Wrap(
                spacing: 8,
                children: _selectedFiles.map((file) {
                  return Chip(
                    label: Text(file.name, overflow: TextOverflow.ellipsis),
                    deleteIcon: const Icon(Icons.close),
                    onDeleted: () {
                      setState(() {
                        _selectedFiles.remove(file);
                      });
                    },
                  );
                }).toList(),
              )
                  : const Text("No files selected",
                  style: TextStyle(color: Colors.grey)),

              const SizedBox(height: 16),

              // Delivery Date Picker
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _pickDate(context),
                    icon: const Icon(Icons.date_range),
                    label: const Text("Choose Delivery Date"),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 1.2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).colorScheme.surfaceVariant,
                      ),
                      child: Text(
                        _selectedDate != null
                            ? DateFormat("dd MMM yyyy").format(_selectedDate!)
                            : "No date selected",
                        style: TextStyle(
                          fontSize: 16,
                          color: _selectedDate != null
                              ? Theme.of(context).colorScheme.onSurface
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Submit
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    final phoneNumber =
                        "$_selectedCode ${phoneController.text}";
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Submitted Phone: $phoneNumber")),
                    );
                  },
                  child: const Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
