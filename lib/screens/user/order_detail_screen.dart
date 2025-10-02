import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/firestore_service.dart';
import '../../models/order_model.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailScreen extends StatefulWidget {
  final String orderId;
  OrderDetailScreen({required this.orderId});
  @override State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}
class _OrderDetailScreenState extends State<OrderDetailScreen> {
  OrderModel? order;
  bool loading = true;

  @override
  void initState() { super.initState(); _load(); }

  Future<void> _load() async {
    final fs = Provider.of<FirestoreService>(context, listen:false);
    final o = await fs.getOrderById(widget.orderId);
    setState(()=> order = o);
    setState(()=> loading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return Scaffold(appBar: AppBar(), body: Center(child: CircularProgressIndicator()));
    if (order == null) return Scaffold(appBar: AppBar(), body: Center(child: Text('Not found')));

    final canDownload = order!.status == 'paid' || order!.status == 'completed';
    final fileUrl = order!.files != null ? order!.files!['reference'] : null;

    return Scaffold(
      appBar: AppBar(title: Text('Order Detail')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Subject: ${order!.subject}', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height:8),
            Text('Type: ${order!.type}'),
            SizedBox(height:8),
            Text('Status: ${order!.status}'),
            SizedBox(height:16),
            Text('Details:'),
            Text(order!.details),
            SizedBox(height:16),
            Text('Reference File:'),
            fileUrl == null ? Text('No file uploaded') :
            Column(children:[
              Text(fileUrl),
              SizedBox(height:8),
              ElevatedButton(
                onPressed: canDownload ? () async {
                  if (await canLaunch(fileUrl)) await launch(fileUrl);
                } : null,
                child: Text(canDownload ? 'Download File' : 'Locked — Pay to Unlock'),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
