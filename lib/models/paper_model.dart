import 'package:cloud_firestore/cloud_firestore.dart';

class PaperModel {
  String id;
  String title;
  String category;
  String? previewUrl; // preview pdf (5/10 pages)
  String? fullUrl;
  int previewPages;
  double price;

  PaperModel({
    required this.id,
    required this.title,
    required this.category,
    this.previewUrl,
    this.fullUrl,
    this.previewPages = 5,
    this.price = 0.0,
  });

  factory PaperModel.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PaperModel(
      id: doc.id,
      title: data['title'] ?? '',
      category: data['category'] ?? '',
      previewUrl: data['previewUrl'],
      fullUrl: data['fullUrl'],
      previewPages: data['previewPages'] ?? 5,
      price: (data['price'] ?? 0).toDouble(),
    );
  }
}
