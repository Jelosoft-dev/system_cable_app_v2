import 'package:tv_cable/components/MKTemplateScreen.dart';
import 'package:tv_cable/models/reporte.dart';
import 'package:tv_cable/utils/jasper_report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PantallaViewPdf extends StatefulWidget {
  final Reporte reporte;
  PantallaViewPdf(this.reporte, {Key? key}) : super(key: key);

  @override
  State<PantallaViewPdf> createState() => _PantallaViewPdfState(reporte);
}

class _PantallaViewPdfState extends State<PantallaViewPdf> {
  _PantallaViewPdfState(this.reporte);

  Reporte reporte;

  String filePath = "";

  void loadDocument() async {
    String path = await JasperReport.view_reporte(reporte.url, reporte.fileName, reporte.rptName, params: reporte.params);
    setState(() {
      filePath = path;
    });
  }


  @override
  initState() {
    loadDocument();
    super.initState();
  }

  Widget _body(){
    return Center(
      child: filePath.isEmpty
      ? Center(child: CircularProgressIndicator())
      : PDFView(filePath: filePath!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MKTemplateScreen(
      title: reporte.title,
      body: _body(),
    );
  }
}
