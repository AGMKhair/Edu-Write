import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';
import '../../services/firestore_service.dart';
import '../../models/order_model.dart';
import 'order_detail_screen.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context, listen:false);
    final fs = Provider.of<FirestoreService>(context, listen:false);
    final uid = auth.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(title: Text('My Orders')),
      body: StreamBuilder<List<OrderModel>>(
        stream: fs.streamUserOrders(uid),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
          final orders = snap.data ?? [];
          if (orders.isEmpty) return Center(child: Text('No orders yet'));
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, i) {
              final o = orders[i];
              return ListTile(
                title: Text(o.subject),
                subtitle: Text('${o.type} • ${o.status}'),
                trailing: o.status == 'waiting_for_payment' ? ElevatedButton(onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Payment flow placeholder')));
                }, child: Text('Pay Now')) : null,
                onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_) => OrderDetailScreen(orderId: o.id!))),
              );
            },
          );
        },
      ),
    );
  }
}
