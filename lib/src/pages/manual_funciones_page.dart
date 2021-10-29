import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';

class ManualFuncionesPage extends StatefulWidget {
  const ManualFuncionesPage({Key? key}) : super(key: key);

  @override
  State<ManualFuncionesPage> createState() => _ManualFuncionesPageState();
}

class _ManualFuncionesPageState extends State<ManualFuncionesPage> {
  final sampleUrl = 'http://www.africau.edu/images/default/sample.pdf';

  String? pdfFlePath;

  Future<String> downloadAndSavePdf() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/sample.pdf');
    if (await file.exists()) {
      return file.path;
    }
    final response = await http.get(Uri.parse(sampleUrl));
    await file.writeAsBytes(response.bodyBytes);
    return file.path;
  }

  void loadPdf() async {
    pdfFlePath = await downloadAndSavePdf();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadPdf();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Theme.of(context).hintColor,
        title: Text('Manual de Funciones'),
      ),
      body: Stack(
        children: [
          if (pdfFlePath != null)
            Expanded(
              child: Container(
                child: PdfView(path: pdfFlePath!),
              ),
            )
          else
            Text('PDF no se cargo')
        ],
      ),
    );
  }
}
