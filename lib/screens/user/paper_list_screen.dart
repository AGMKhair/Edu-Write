import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/firestore_service.dart';
import '../../models/paper_model.dart';
import 'paper_detail_screen.dart';

class PaperListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fs = Provider.of<FirestoreService>(context, listen:false);
    return Scaffold(
      appBar: AppBar(title: Text('Papers')),
      body: StreamBuilder<List<PaperModel>>(
        stream: fs.streamPapers(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
          final papers = snap.data ?? [];
          if (papers.isEmpty) return Center(child: Text('No papers yet'));
          return ListView.builder(
            itemCount: papers.length,
            itemBuilder: (context, i) {
              final p = papers[i];
              return ListTile(
                title: Text(p.title),
                subtitle: Text('${p.category} • ${p.previewPages} pages preview'),
                trailing: Text('৳${p.price.toStringAsFixed(0)}'),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PaperDetailScreen(paperId: p.id))),
              );
            },
          );
        },
      ),
    );
  }
}
