import 'package:donorlink/Models/Financial.dart';
import 'package:donorlink/Models/Reviewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class FinancialDocument extends StatelessWidget {
  final Reviewer user;
  final Financial fin;

  const FinancialDocument({super.key, required this.user, required this.fin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Financial Document'),
      ),
      body: fin.getLocation() != null
          ? PDFView(
              filePath: fin.getLocation(),
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: false,
              pageFling: true,
              onError: (error) {
                // Handle error
                print(error.toString());
              },
              onRender: (_pages) {
                // Handle render
              },
              onViewCreated: (PDFViewController pdfViewController) {
                // Handle view created
              },
              onPageChanged: (int? page, int? total) {
                // Handle page change
              },
              onPageError: (page, error) {
                // Handle page error
                print('$page: ${error.toString()}');
              },
            )
          : Center(
              child: Text('No document available.'),
            ),
    );
  }
}
