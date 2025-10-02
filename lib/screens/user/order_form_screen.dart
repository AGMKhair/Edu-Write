import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import '../../services/auth_service.dart';
import '../../services/firestore_service.dart';
import '../../services/storage_service.dart';
import '../../models/order_model.dart';
import 'package:uuid/uuid.dart';

class OrderFormScreen extends StatefulWidget {
  @override
  State<OrderFormScreen> createState() => _OrderFormScreenState();
}

class _OrderFormScreenState extends State<OrderFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String subject = '';
  String type = 'Assignment';
  String details = '';
  int previewPages = 5;
  PlatformFile? pickedFile;
  bool loading = false;

  Future<void> pickFile() async {
    final res = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx', 'zip'],
    );
    if (res != null) {
      setState(() => pickedFile = res.files.first);
    }
  }

  Future<void> submitOrder() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    setState(() => loading = true);

    try {
      final auth = Provider.of<AuthService>(context, listen: false);
      final fs = Provider.of<FirestoreService>(context, listen: false);
      final storage = Provider.of<StorageService>(context, listen: false);

      final uid = auth.currentUser?.uid ?? "guest_${Uuid().v4()}";

      /// Firestore এ order doc তৈরি
      final docRef =
      FirebaseFirestore.instance.collection('orders').doc(); // auto ID
      final orderId = docRef.id;

      final order = OrderModel(
        id: orderId,
        userId: uid,
        subject: subject,
        type: type,
        details: details,
        previewPagesAllowed: previewPages,
        status: 'pending',
        amount: 0.0,
      );

      await docRef.set(order.toMap());

      // file upload থাকলে
      if (pickedFile != null) {
        final filename = '${Uuid().v4()}_${pickedFile!.name}';
        final bytes = pickedFile!.bytes;
        if (bytes != null) {
          final url = await storage.uploadOrderFile(orderId, filename, bytes);
          await docRef.update({'fileUrl': url});
        }
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Order submitted successfully')));

      // Success page redirect
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => OrderSuccessScreen(orderId: orderId),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Place Order')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Subject Name'),
                onSaved: (v) => subject = v ?? '',
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              DropdownButtonFormField(
                value: type,
                items: ['Assignment', 'Project', 'Research Paper']
                    .map((e) =>
                    DropdownMenuItem(child: Text(e), value: e.toString()))
                    .toList(),
                onChanged: (v) => setState(() => type = v as String),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Details / Key points'),
                minLines: 3,
                maxLines: 6,
                onSaved: (v) => details = v ?? '',
              ),
              SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: pickFile,
                icon: Icon(Icons.upload_file),
                label: Text(
                  pickedFile == null
                      ? 'Upload reference file'
                      : pickedFile!.name,
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: loading ? null : submitOrder,
                child: loading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text('Submit Order'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderSuccessScreen extends StatelessWidget {
  final String orderId;
  const OrderSuccessScreen({required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Order Success")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 80),
            SizedBox(height: 16),
            Text("Your order has been placed!", style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text("Order ID: $orderId"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: Text("Back to Home"),
            )
          ],
        ),
      ),
    );
  }
}
