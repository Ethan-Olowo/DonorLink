import 'package:donorlink/Models/Financial.dart';
import 'package:donorlink/Models/Organisation.dart';
import 'package:donorlink/views/Organisations/add_financial.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FinancialDocument extends StatelessWidget {
  final Organisation user;
  final Financial fin;

  const FinancialDocument({super.key, required this.user, required this.fin});

  Future<String> _getPDFUrl(String location) async {
    try {
      final ref = FirebaseStorage.instance.refFromURL(location);
      return await ref.getDownloadURL();
    } catch (e) {
      //print(e.toString());
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Financial Document'),
      ),
      body: FutureBuilder<String>(
        future: _getPDFUrl(fin.getLocation() ?? ''),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No document available.'),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddFinancialPage(organisation: user),
                        ),
                      );
                    },
                    child: const Text('Upload Financial'),
                  ),
                ],
              ),
            );
          } else {
            return PDFView(
              filePath: snapshot.data!,
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: false,
              pageFling: true,
              onError: (error) {
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
                print('$page: ${error.toString()}');
              },
            );
          }
        },
      ),
    );
  }
}
