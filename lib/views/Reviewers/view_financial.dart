import 'dart:async';
import 'package:dio/dio.dart';
import 'package:donorlink/Models/Financial.dart';
import 'package:donorlink/Models/Reviewer.dart';
import 'package:donorlink/resources/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class FinancialDocument extends StatefulWidget {
  final Reviewer user;
  final Financial fin;

  const FinancialDocument({super.key, required this.user, required this.fin});

  @override
  _FinancialDocumentState createState() => _FinancialDocumentState();
}

class _FinancialDocumentState extends State<FinancialDocument> {
  late Future<String> pdfUrlFuture;
  int? pages;
  bool isReady = false;
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();

  @override
  void initState() {
    super.initState();
    pdfUrlFuture = _getPDFUrl(widget.fin.getLocation() ?? '');
  }

  Future<String> _getPDFUrl(String location) async {
    try {
      final ref = FirebaseStorage.instance.refFromURL(location);
      final url = await ref.getDownloadURL();
      final filePath = await _downloadAndSavePDF(url);
      return filePath;
    } catch (e) {
      return 'Error';
    }
  }

  Future<String> _downloadAndSavePDF(String url) async {
    try {
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/financial_document.pdf';
      await Dio().download(url, filePath);
      return filePath;
    } catch (e) {
      return 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Bar(),
      body: FutureBuilder<String>(
        future: pdfUrlFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.data!.isEmpty ||
              snapshot.data == 'Error') {
            return const Center(
              child: Text('No document available.'),
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
                setState(() {
                  pages = _pages;
                  isReady = true;
                });
              },
              onViewCreated: (PDFViewController pdfViewController) {
                _controller.complete(pdfViewController);
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
