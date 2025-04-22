// ignore_for_file: use_key_in_widget_constructors, depend_on_referenced_packages, implementation_imports

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/src/pdf/page_format.dart';
import 'package:printing/printing.dart';
import 'package:req_livestream_helper/src/controller/app_controller.dart';
import 'package:pdf/src/widgets/geometry.dart' as a show Alignment, EdgeInsets;
import 'package:pdf/src/widgets/flex.dart'
    as f
    show MainAxisAlignment, CrossAxisAlignment;
import 'package:pdf/src/widgets/text_style.dart' as tS;
import 'package:req_livestream_helper/src/view/theme.dart';
import 'package:pdf/src/widgets/decoration.dart' as d;
import 'package:pdf/src/pdf/color.dart' as pC;
import 'package:pdf/src/widgets/box_border.dart' as bB;
import 'package:pdf/src/widgets/border_radius.dart' as bR;

class PrintViewer extends StatelessWidget {
  List<ClientOrder> clientOrderList;
  PrintViewer({super.key, required this.clientOrderList});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PDF Preview')),
      body: PdfPreview(
        canChangeOrientation: false,
        canChangePageFormat: false,
        build: (format) => _generatePdf(format),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  pw.Page CustomPdfPage(PdfPageFormat format, ClientOrder clientOrder) {
    return pw.Page(
      pageFormat: format,
      build:
          (ctx) => pw.Padding(
            padding: a.EdgeInsets.all(30),
            child: pw.Column(
              children: [
                pw.Center(
                  child: pw.Text(
                    "Separação Pedido (SP) - #${clientOrderList.indexOf(clientOrder)}",
                    style: tS.TextStyle(
                      fontSize: 20,
                      fontWeight: tS.FontWeight.bold,
                    ),
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Row(
                  // mainAxisAlignment: f.MainAxisAlignment.center,
                  children: [
                    pw.Text("Cliente (@ instagram)"),
                    pw.SizedBox(width: 200),
                    pw.Text(clientOrder.client),
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Row(
                  // mainAxisAlignment: f.MainAxisAlignment.center,
                  children: [
                    pw.Text("Nome(real)"),
                    pw.SizedBox(width: 140),
                    pw.Text("_______________________________"),
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Row(
                  // mainAxisAlignment: f.MainAxisAlignment.center,
                  children: [
                    pw.Text("Whatsapp/Contato"),
                    pw.SizedBox(width: 100),
                    pw.Text("_______________________________"),
                  ],
                ),

                pw.SizedBox(height: 10),
                pw.Row(
                  // mainAxisAlignment: f.MainAxisAlignment.center,
                  children: [
                    pw.Text("Produtos(Quantidade)"),
                    pw.SizedBox(width: 270),
                    pw.Text(clientOrder.products.length.toString()),
                  ],
                ),
                pw.SizedBox(height: 30),

                /// product listing
                pw.Row(
                  children: [
                    pw.SizedBox(width: 15),
                    pw.Text("#Cod    Descricao"),
                    pw.SizedBox(width: 210),
                    pw.Text("Tamanho"),
                    pw.SizedBox(width: 10),
                    pw.Text("Check"),
                  ],
                ),
                pw.Container(
                  padding: a.EdgeInsets.all(10),
                  decoration: d.BoxDecoration(
                    // color: pC.PdfColor.fromInt(0),
                    border: bB.Border.all(
                      color: pC.PdfColor.fromInt(1),
                      width: 1.5,
                    ),
                    borderRadius: bR.BorderRadius.circular(8),
                  ),
                  child: pw.Column(
                    mainAxisAlignment: f.MainAxisAlignment.spaceBetween,
                    children:
                        clientOrder.products
                            .map(
                              (Product p) => pw.Padding(
                                padding: a.EdgeInsets.all(13),
                                child: pw.Row(
                                  mainAxisAlignment:
                                      f.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Row(
                                      children: [
                                        pw.Text('#${p.cod} -'),
                                        pw.SizedBox(width: 5),
                                        pw.Text('${p.dsc}'),
                                      ],
                                    ),
                                    pw.Row(
                                      children: [
                                        pw.Text('${p.prodSize}'),
                                        pw.SizedBox(width: 20),

                                        pw.Text('[  ]'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document();
    // ignore: avoid_function_literals_in_foreach_calls
    clientOrderList.forEach((clientOrder) {
      pdf.addPage(CustomPdfPage(format, clientOrder));
    });
    return pdf.save();
  }
}
