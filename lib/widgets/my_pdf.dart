import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:invoice/model/user_data_model.dart';
import 'package:invoice/widgets/design.dart';
import 'package:invoice/widgets/total_sum.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class MyPdf {
  static Future<File> generateNewPdf(
      {required UserModel model, required Uint8List signature}) async {
    final pdf = pw.Document();
    var logo =
        (await rootBundle.load("assets/images/logo.jpeg")).buffer.asUint8List();
    var image = pw.MemoryImage(logo);
    var qr = (await rootBundle.load("assets/images/qrcode.png"))
        .buffer
        .asUint8List();
    var pics = pw.MemoryImage(qr);
    // var quantity = int.parse(item['price']);
    // var price = int.parse(item['quantity']);

    var grandTotal = TotalSum.grandTotal();
    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(0),
        build: (pw.Context context) => [
              // MyDesign.upperContainer(),

              pw.Text(grandTotal.toString()),

              /// First Upper Container
              MyDesign.upperContainer(),
              pw.Row(children: [
                pw.Expanded(
                    child: pw.Container(
                        height: 140.h,
                        // color: PdfColors.yellow,
                        child: pw.Container(
                            //color: PdfColors.green,
                            child: pw.Image(image),
                            margin: pw.EdgeInsets.symmetric(
                                vertical: 30.sp, horizontal: 30.sp)))),
                pw.Expanded(
                    child: pw.Container(
                        height: 140.h,
                        // color: PdfColors.red,
                        child: pw.Column(children: [
                          pw.Expanded(
                              child: pw.Text('Invoice',
                                  style: pw.TextStyle(fontSize: 20.sp))),
                          pw.Expanded(
                              child: pw.Text('Invoice ID# 0001',
                                  style: pw.TextStyle(fontSize: 20.sp))),
                          pw.Expanded(
                              flex: 2,
                              child: pw.Row(children: [
                                pw.Expanded(
                                    child: pw.Container(
                                        // color: PdfColors.blue,
                                        child: pw.Column(children: [
                                  pw.Expanded(
                                      child: pw.Text('Invoice Date',
                                          style: const pw.TextStyle(
                                              color: PdfColors.grey))),
                                  pw.Expanded(
                                      child: pw.Text(DateFormat('dd-MM-yyy')
                                              .format(DateTime.now())
                                          // model.invoiceDate
                                          )),
                                ]))),
                                pw.Expanded(
                                    child: pw.Container(
                                        // color: PdfColors.orange300,
                                        child: pw.Column(children: [
                                  pw.Expanded(
                                      child: pw.Text('Due Date',
                                          style: const pw.TextStyle(
                                              color: PdfColors.grey))),
                                  pw.Expanded(
                                      child: pw.Text(DateFormat('dd-MM-yyy')
                                          .format(DateTime.now()))),
                                ]))),
                              ]))
                        ]))),

                ///
                pw.Expanded(
                    child: pw.Container(
                        height: 140.h,
                        // color: PdfColors.blueGrey,
                        child: pw.Container(
                          margin: pw.EdgeInsets.symmetric(
                              vertical: 30.sp, horizontal: 30.sp),
                          // color: PdfColors.yellow,
                          child: pw.Image(pics),
                        ))),
              ]),

              ///
              pw.Container(
                  height: 150.h,
                  // color: PdfColors.red,
                  child: pw.Row(children: [
                    pw.Expanded(
                        child: pw.Container(
                      margin: pw.EdgeInsets.only(left: 30.sp, top: 10.sp),
                      // color: PdfColors.blue,
                      child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Expanded(
                              child: pw.Text('Billed By',
                                  style: pw.TextStyle(
                                      color: PdfColors.orange300,
                                      fontSize: 18.sp)),
                            ),
                            pw.Expanded(
                              child: pw.Text(model.byOrganization,
                                  style: pw.TextStyle(
                                      color: PdfColors.black, fontSize: 18.sp)),
                            ),
                            pw.Expanded(
                              child: pw.Text('Email:${model.byEmail}',
                                  style: pw.TextStyle(
                                      color: PdfColors.black, fontSize: 18.sp)),
                            ),
                            pw.Expanded(
                              child: pw.Text('Address:${model.byAddress}',
                                  style: pw.TextStyle(
                                      color: PdfColors.black, fontSize: 18.sp)),
                            ),
                            pw.Expanded(
                              child: pw.Text('Phone:${model.byPhone}',
                                  style: pw.TextStyle(
                                      color: PdfColors.black, fontSize: 18.sp)),
                            ),
                          ]),
                    )),
                    pw.Expanded(
                        child: pw.Container(
                      margin: pw.EdgeInsets.only(left: 10.sp, top: 10.sp),
                      // color: PdfColors.green,
                      child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Expanded(
                              child: pw.Text('Billed To',
                                  style: pw.TextStyle(
                                      color: PdfColors.orange300,
                                      fontSize: 18.sp)),
                            ),
                            pw.Expanded(
                              child: pw.Text(model.toOrganization,
                                  style: pw.TextStyle(
                                      color: PdfColors.black, fontSize: 18.sp)),
                            ),
                            pw.Expanded(
                              child: pw.Text('Email:${model.toEmail}',
                                  style: pw.TextStyle(
                                      color: PdfColors.black, fontSize: 18.sp)),
                            ),
                            pw.Expanded(
                              child: pw.Text('Address:${model.toAddress}',
                                  style: pw.TextStyle(
                                      color: PdfColors.black, fontSize: 18.sp)),
                            ),
                            pw.Expanded(
                              child: pw.Text('Phone:${model.toPhone}',
                                  style: pw.TextStyle(
                                      color: PdfColors.black, fontSize: 18.sp)),
                            ),
                          ]),
                    )),
                  ])),

              ///

              pw.Container(
                  height: 40.h,
                  color: PdfColors.orange300,
                  child: pw.Row(children: [
                    pw.Expanded(
                      child: pw.Align(
                          alignment: pw.Alignment.center,
                          child: pw.Text(
                            'S.No',
                            style: pw.TextStyle(
                                color: PdfColors.white, fontSize: 18.sp),
                          )),
                    ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Text(
                        'Item name',
                        style: pw.TextStyle(
                            color: PdfColors.white, fontSize: 18.sp),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Align(
                        alignment: pw.Alignment.center,
                        child: pw.Text(
                          'Quantity',
                          style: pw.TextStyle(
                              color: PdfColors.white, fontSize: 18.sp),
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        'Item price',
                        style: pw.TextStyle(
                            color: PdfColors.white, fontSize: 18.sp),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        'Total',
                        style: pw.TextStyle(
                            color: PdfColors.white, fontSize: 18.sp),
                      ),
                    ),
                  ])),

              ///
              ///

              pw.Container(
                  height: 120.h,
                  // color: PdfColors.brown,
                  child: pw.Column(children: [
                    pw.Expanded(
                      child: pw.ListView.builder(
                        itemCount: model.items.length,
                        itemBuilder: (context, int index) {
                          var item = model.items[index];
                          var quantity = int.parse(item['price']);
                          var price = int.parse(item['quantity']);
                          var total = quantity * price;

                          return pw.Row(children: [
                            pw.Expanded(
                              child: pw.Align(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text(
                                    "${index + 1}",
                                    style: pw.TextStyle(
                                        color: PdfColors.black,
                                        fontSize: 18.sp),
                                  )),
                            ),
                            pw.Expanded(
                              flex: 2,
                              child: pw.Text(
                                item['Name'],
                                style: pw.TextStyle(
                                    color: PdfColors.black, fontSize: 18.sp),
                              ),
                            ),
                            pw.Expanded(
                              child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text(
                                  item['price'],
                                  style: pw.TextStyle(
                                      color: PdfColors.black, fontSize: 18.sp),
                                ),
                              ),
                            ),
                            pw.Expanded(
                              child: pw.Text(
                                item['quantity'],
                                style: pw.TextStyle(
                                    color: PdfColors.black, fontSize: 18.sp),
                              ),
                            ),
                            pw.Expanded(
                              child: pw.Text(
                                '$total',
                                style: pw.TextStyle(
                                    color: PdfColors.black, fontSize: 18.sp),
                              ),
                            ),
                          ]);
                        },
                      ),
                    ),
                  ])),

              ///
              pw.Container(
                  height: 180.h,
                  // color: PdfColors.blue,
                  child: pw.Row(children: [
                    pw.Expanded(
                      child: pw.Container(
                          // color: PdfColors.yellow200,
                          child: pw.Column(children: [
                        pw.Expanded(
                            child: pw.Container(
                                margin:
                                    pw.EdgeInsets.symmetric(horizontal: 20.sp),
                                // color: PdfColors.pink,
                                child: pw.Column(children: [
                                  pw.Expanded(
                                    child: pw.Align(
                                        alignment: pw.Alignment.topLeft,
                                        child: pw.Container(
                                          // color: PdfColors.deepOrange,
                                          child: pw.Text('Description:',
                                              style: pw.TextStyle(
                                                  color: PdfColors.black,
                                                  fontSize: 20.sp,
                                                  fontWeight:
                                                      pw.FontWeight.bold)),
                                        )),
                                  ),
                                  pw.Expanded(
                                    flex: 2,
                                    child: pw.Align(
                                      alignment: pw.Alignment.topLeft,
                                      child: pw.Container(
                                          // color: PdfColors.deepOrange,
                                          child: pw.Text(
                                        model.description,
                                        style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 14.sp,
                                        ),
                                      )),
                                    ),
                                  ),
                                ]))),
                        pw.Expanded(
                            child: pw.Container(
                                margin: pw.EdgeInsets.only(
                                    left: 20.sp, right: 20.sp, bottom: 20.sp),
                                // color: PdfColors.red,
                                child: pw.Column(children: [
                                  pw.Expanded(
                                    child: pw.Align(
                                        alignment: pw.Alignment.topLeft,
                                        child: pw.Container(
                                          // color: PdfColors.deepOrange,
                                          child: pw.Text(
                                              'Terms and Conditions:',
                                              style: pw.TextStyle(
                                                  color: PdfColors.black,
                                                  fontSize: 20.sp,
                                                  fontWeight:
                                                      pw.FontWeight.bold)),
                                        )),
                                  ),
                                  pw.Expanded(
                                    flex: 2,
                                    child: pw.Align(
                                      alignment: pw.Alignment.topLeft,
                                      child: pw.Container(
                                          // color: PdfColors.deepOrange,
                                          child: pw.Text(
                                        model.terms,
                                        style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 14.sp,
                                        ),
                                      )),
                                    ),
                                  ),
                                ]))),
                      ])),
                    ),
                    pw.Expanded(
                      child: pw.Container(
                          margin: pw.EdgeInsets.only(
                              bottom: 20.sp, left: 20.sp, right: 20.sp),
                          child: pw.Column(children: [
                            pw.Expanded(
                              child: pw.Container(
                                  decoration: pw.BoxDecoration(
                                    // color: PdfColors.green400,
                                    color: PdfColors.orange500,
                                    border: pw.Border.all(
                                      width: 2,
                                    ),
                                  ),
                                  child: pw.Align(
                                      alignment: pw.Alignment.topLeft,
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text('Total Summary',
                                              style: pw.TextStyle(
                                                  color: PdfColors.white,
                                                  fontSize: 20.sp,
                                                  fontWeight:
                                                      pw.FontWeight.bold))))),
                            ),
                            pw.Expanded(
                              flex: 3,
                              child: pw.Container(
                                  decoration: pw.BoxDecoration(
                                    color: PdfColors.amber50,
                                    border: pw.Border.all(
                                      width: 2,
                                    ),
                                  ),
                                  child: pw.Row(children: [
                                    pw.Expanded(
                                        flex: 3,
                                        child: pw.Container(
                                          margin:
                                              pw.EdgeInsets.only(left: 10.sp),
                                          // color: PdfColors.white,
                                          child: pw.Column(
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.start,
                                              children: [
                                                pw.Spacer(),
                                                pw.Expanded(
                                                    child: pw.Text(
                                                        'Total(Exc TAX',
                                                        style: pw.TextStyle(
                                                            fontSize: 13.sp,
                                                            color: PdfColors
                                                                .black))),
                                                pw.Expanded(
                                                    child: pw.Text('Discount',
                                                        style: pw.TextStyle(
                                                            fontSize: 13.sp,
                                                            color: PdfColors
                                                                .black))),
                                                pw.Expanded(
                                                    child: pw.Text(
                                                        'Sub Total(Inc TAX)',
                                                        style: pw.TextStyle(
                                                            fontSize: 12.sp,
                                                            color: PdfColors
                                                                .black))),
                                                pw.Expanded(
                                                    child: pw.Text(
                                                        'Total(Exc TAX',
                                                        style: pw.TextStyle(
                                                            fontSize: 13.sp,
                                                            color: PdfColors
                                                                .black))),
                                              ]),
                                        )),
                                    pw.Expanded(
                                        flex: 2,
                                        child: pw.Container(
                                          // margin:
                                          //  pw.EdgeInsets.only(left: 10.sp),
                                          // color: PdfColors.red,
                                          child: pw.Column(
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.start,
                                              children: [
                                                pw.Spacer(),
                                                pw.Expanded(
                                                    child: pw.Text(
                                                        grandTotal.toString(),
                                                        style: pw.TextStyle(
                                                            fontSize: 13.sp,
                                                            color: PdfColors
                                                                .black))),
                                                pw.Expanded(
                                                    child: pw.Text('1045 Pkr',
                                                        style: pw.TextStyle(
                                                            fontSize: 13.sp,
                                                            color: PdfColors
                                                                .black))),
                                                pw.Expanded(
                                                    child: pw.Text('1045 Pkr',
                                                        style: pw.TextStyle(
                                                            fontSize: 13.sp,
                                                            color: PdfColors
                                                                .black))),
                                                pw.Expanded(
                                                    child: pw.Text('16315 Pkr',
                                                        style: pw.TextStyle(
                                                            fontSize: 13.sp,
                                                            color: PdfColors
                                                                .black))),
                                              ]),
                                        )),
                                  ])),
                            ),
                          ])),
                    ),
                  ])),
              pw.Expanded(
                child: pw.Container(
                    margin: pw.EdgeInsets.only(right: 20.sp),
                    alignment: pw.Alignment.topRight,
                    width: 100.w,
                    height: 30.h,
                    child: pw.Image(pw.MemoryImage(signature))),
              ),
              pw.Spacer(),

              pw.Expanded(
                child: pw.Container(
                  margin: pw.EdgeInsets.only(right: 100.sp),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.orange500,
                    borderRadius: pw.BorderRadius.only(
                      topRight: pw.Radius.circular(80.r),
                    ),
                    // boxShadow: [
                    //   pw.BoxShadow(
                    //     color: PdfColors.grey,
                    //     spreadRadius: 10,
                    //     blurRadius: 5,
                    //     // changes position of shadow
                    //   ),
                    // ],
                  ),
                  height: 10.h,
                  alignment: pw.Alignment.bottomCenter,
                ),
              ),
            ]));

    var tempDirectory = await getTemporaryDirectory();

    debugPrint('=======================');
    debugPrint(tempDirectory.path);
    final file = File('${tempDirectory.path}' '/' 'example.pdf');

    var newPdf = await file.writeAsBytes(await pdf.save());

    return newPdf;
  }

  static Future openMyFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
  }
}

//
// pw.Padding(
// padding: const pw.EdgeInsets.only(
// right: 55,
// bottom: 10,
// ),
// child: pw.Container(
// height: 30,
// color: PdfColors.lightGreen,
// ),
// )
