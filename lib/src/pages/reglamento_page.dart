import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';

class ReglamentoPage extends StatefulWidget {
  const ReglamentoPage({Key? key}) : super(key: key);

  @override
  State<ReglamentoPage> createState() => _ReglamentoPageState();
}

class _ReglamentoPageState extends State<ReglamentoPage> {
  final sampleUrl =
      'http://intranet.lafar.net/newApiLafarnet/assets/documentos/reglamento_interno.pdf';

  String? pdfFlePath;

  Future<String> downloadAndSavePdf() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/reglamento.pdf');
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).hintColor,
        title: Text('Reglamento Interno LAFAR'),
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
            Text('No se pudo cargar el Reglamento Interno')
        ],
      ),
    );
  }
}
