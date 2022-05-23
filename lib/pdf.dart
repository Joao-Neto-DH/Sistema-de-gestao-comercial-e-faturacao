import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:path/path.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';

class PDFGenerator {
  final pdf = pw.Document();

  addPage() {
    pdf.addPage(pw.MultiPage(
      build: (context) {
        return [pw.Text("ola")];
      },
    ));
  }

  Future<File> save() async {
    //-${DateTime.now().toString()}

    final path = await getExternalStorageDirectory();
    final joined = join(path!.path, "fatura-${DateTime.now().toString()}.pdf");
    var file = File(joined);
    return await file.writeAsBytes(await pdf.save());
  }
}
