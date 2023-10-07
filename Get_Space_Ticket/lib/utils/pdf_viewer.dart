import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';

class PdfView extends StatefulWidget {
  final String pdfUrl;
  const PdfView({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  State<PdfView> createState() => _PdfViewState(pdfUrl);
}

class _PdfViewState extends State<PdfView> {
  PDFDocument? document;
  _PdfViewState(String pdfUrl);
  void initialisePdf() async {
    document = await PDFDocument.fromURL(widget.pdfUrl);
    setState(() {});
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: document != null
          ? PDFViewer(document: document!)
          : const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
