import 'package:corriol_app/controllers/file_io_controller.dart';
import 'package:corriol_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerWidget extends StatelessWidget {
  const PdfViewerWidget({super.key, required this.title, required this.path});

  final String path;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            tooltip: '${S.current.download} $title PDF',
            onPressed: () => FileIoController.savePDFFromAssets(
              context: context,
              assetPath: path,
              fileName: title,
            ),
          )
        ],
      ),
      body: ExcludeSemantics(
        child: SafeArea(
          child: SfPdfViewer.asset(path),
        ),
      ),
    );
  }
}
