import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/firestore_service.dart';
import '../../models/paper_model.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dashboard_screen.dart';

class PaperDetailScreen extends StatefulWidget {
  final String paperId;
  PaperDetailScreen({required this.paperId});
  @override State<PaperDetailScreen> createState() => _PaperDetailScreenState();
}
class _PaperDetailScreenState extends State<PaperDetailScreen> {
  PaperModel? paper;
  bool loading = true;

  @override
  void initState() { super.initState(); _load(); }

  Future<void> _load() async {
    final fs = Provider.of<FirestoreService>(context, listen:false);
    final p = await fs.getPaperById(widget.paperId);
    setState(()=> paper = p);
    setState(()=> loading=false);
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return Scaffold(appBar: AppBar(), body: Center(child: CircularProgressIndicator()));
    if (paper == null) return Scaffold(appBar: AppBar(), body: Center(child: Text('Not found')));

    return Scaffold(
      appBar: AppBar(title: Text(paper!.title)),
      body: Column(
        children: [
          Text('Preview (first ${paper!.previewPages} pages)'),
          Expanded(
            child: paper!.previewUrl != null
                ? PDFView(filePath: paper!.previewUrl!) // web: need web-compatible pdf viewer; this is mobile example
                : Center(child: Text('No preview available')),
          ),
          SizedBox(height:8),
          ElevatedButton(
            onPressed: () {
              // Buy full paper -> create order for paper type
              Navigator.push(context, MaterialPageRoute(builder: (_) => DashboardScreen())); // placeholder
            },
            child: Text('Buy Full Paper — ৳${paper!.price.toStringAsFixed(0)}'),
          ),
        ],
      ),
    );
  }
}
