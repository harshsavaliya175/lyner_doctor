import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:path_provider/path_provider.dart';

class PDFScreen extends StatefulWidget {
  final String path;

  PDFScreen({Key? key, required this.path}) : super(key: key);

  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  String remotePDFpath = "";

  @override
  void initState() {
    super.initState();
    createFileOfPdfUrl().then((f) {
      setState(() {
        remotePDFpath = f.path;
      });
    });
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        if (Platform.isAndroid) {
          await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
        }
      },
    );
  }

  Future<File> createFileOfPdfUrl() async {
    Completer<File> completer = Completer();
    try {
      final url = widget.path;
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }
    return completer.future;
  }

  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  int? totalPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   toolbarHeight: 70,
      //   centerTitle: false,
      //   title: Text(
      //     "${remotePDFpath.isNotEmpty ? (currentPage ?? 0) + 1 : currentPage} / $totalPage",
      //     textAlign: TextAlign.start,
      //     style: TextStyle(
      //       fontFamily: Assets.fonts.maax,
      //       fontWeight: FontWeight.w700,
      //       color: Colors.black,
      //       fontSize: !isTablet ? 20 : 22,
      //     ),
      //   ),
      //   leading: Assets.icons.icBack
      //       .svg(
      //         height: 35,
      //         width: 35,
      //         fit: !isTablet ? BoxFit.scaleDown : BoxFit.fill,
      //       )
      //       .paddingOnly(
      //         left: 10,
      //         top: isTablet ? 22 : 2,
      //         bottom: isTablet ? 22 : 0,
      //         right: 10,
      //       )
      //       .onClick(() {
      //     Get.back();
      //   }),
      //   backgroundColor: Colors.white,
      //   shadowColor: Colors.grey[300],
      //   titleSpacing: 1,
      //   elevation: 0.5,
      //   scrolledUnderElevation: 0,
      // ),
      body: Stack(
        children: <Widget>[
          if (remotePDFpath.isNotEmpty)
            PDFView(
              filePath: remotePDFpath,
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: true,
              pageFling: false,
              pageSnap: true,
              defaultPage: currentPage!,
              fitPolicy: FitPolicy.WIDTH,
              preventLinkNavigation: false,
              // if set to true the link is handled in flutter
              onRender: (_pages) {
                setState(() {
                  pages = _pages;
                  isReady = true;
                });
              },
              onError: (error) {
                setState(() {
                  errorMessage = error.toString();
                });
                print(error.toString());
              },
              onPageError: (page, error) {
                setState(() {
                  errorMessage = '$page: ${error.toString()}';
                });
                print('$page: ${error.toString()}');
              },
              onViewCreated: (PDFViewController pdfViewController) {
                _controller.complete(pdfViewController);
              },
              onLinkHandler: (String? uri) {
                print('goto uri: $uri');
              },
              onPageChanged: (int? page, int? total) {
                setState(() {
                  currentPage = page;
                  totalPage = total;
                });
              },
            ),
          errorMessage.isEmpty
              ? !isReady
                  ? Center(child: CircularProgressIndicator())
                  : Container()
              : Center(
                  child: Text(errorMessage),
                )
        ],
      ),
    );
  }
}
