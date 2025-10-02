import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/paper_model.dart';
import '../models/order_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Papers
  Stream<List<PaperModel>> streamPapers() {
    return _db.collection('papers').orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => PaperModel.fromDoc(d)).toList());
  }

  Future<PaperModel?> getPaperById(String id) async {
    final doc = await _db.collection('papers').doc(id).get();
    if (!doc.exists) return null;
    return PaperModel.fromDoc(doc);
  }

  // Orders
  Future<void> createOrder(OrderModel order) async {
    final ref = _db.collection('orders').doc();
    order.id = ref.id;
    await ref.set(order.toMap());
  }

  Stream<List<OrderModel>> streamUserOrders(String uid) {
    return _db.collection('orders')
        .where('userId', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => OrderModel.fromDoc(d)).toList());
  }

  Future<OrderModel?> getOrderById(String id) async {
    final doc = await _db.collection('orders').doc(id).get();
    if (!doc.exists) return null;
    return OrderModel.fromDoc(doc);
  }

  Future<void> addPaymentRecord(Map<String, dynamic> payment) async {
    await _db.collection('payments').add(payment);
  }
}
