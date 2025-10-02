import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String? id;
  String userId;
  String subject;
  String type; // Assignment / Project / Paper
  String details;
  int previewPagesAllowed;
  Map<String, dynamic>? files; // reference url etc.
  String status; // pending / waiting_for_payment / paid / in_progress / completed
  double amount;
  Timestamp createdAt;

  OrderModel({
    this.id,
    required this.userId,
    required this.subject,
    required this.type,
    required this.details,
    this.previewPagesAllowed = 5,
    this.files,
    this.status = 'pending',
    this.amount = 0.0,
    Timestamp? createdAt,
  }) : createdAt = createdAt ?? Timestamp.now();

  Map<String, dynamic> toMap() => {
    'userId': userId,
    'subject': subject,
    'type': type,
    'details': details,
    'previewPagesAllowed': previewPagesAllowed,
    'files': files ?? {},
    'status': status,
    'amount': amount,
    'createdAt': createdAt,
  };

  factory OrderModel.fromDoc(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return OrderModel(
      id: doc.id,
      userId: d['userId'] ?? '',
      subject: d['subject'] ?? '',
      type: d['type'] ?? '',
      details: d['details'] ?? '',
      previewPagesAllowed: d['previewPagesAllowed'] ?? 5,
      files: d['files'] != null ? Map<String,dynamic>.from(d['files']) : null,
      status: d['status'] ?? 'pending',
      amount: (d['amount'] ?? 0).toDouble(),
      createdAt: d['createdAt'] ?? Timestamp.now(),
    );
  }
}
