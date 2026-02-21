import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:tamil_pdf_shaper/tamil_pdf_shaper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PdfHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PdfHomePage extends StatelessWidget {
  const PdfHomePage({super.key});

  Future<void> generateTamilPDF() async {
    final pdf = pw.Document();


    final tamilFont = await TamilPdfFont.load();
    pdf.addPage(
      pw.Page(
        theme: pw.ThemeData.withFont(
          base: tamilFont, // required for Tamil rendering
        ),
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text(
              "வணக்கம் பிரவீன்! இது தமிழ் PDF எழுத்து சரியாக வருகிறது."
                  .toTamilPdf, // keep this
              style: pw.TextStyle(
    font: tamilFont,
                fontSize: 24,
              ),
            ),
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: TextButton(onPressed: generateTamilPDF, child: Text("give tamil")),),);}}
  