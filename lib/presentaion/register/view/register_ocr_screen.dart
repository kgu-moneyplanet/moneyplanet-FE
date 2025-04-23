import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class RegisterOcrScreen extends StatefulWidget {
  const RegisterOcrScreen({Key? key}) : super(key: key);

  @override
  State<RegisterOcrScreen> createState() => _RegisterOcrScreenState();
}

class _RegisterOcrScreenState extends State<RegisterOcrScreen> {
  String _ocrText = '';
  Map<String, String> tessimgs = {
    "kor":
        "https://raw.githubusercontent.com/khjde1207/tesseract_ocr/master/example/assets/test1.png",
    "en": "https://tesseract.projectnaptha.com/img/eng_bw.png",
    "ch_sim": "https://tesseract.projectnaptha.com/img/chi_sim.png",
    "ru": "https://tesseract.projectnaptha.com/img/rus.png",
  };
  var LangList = ["kor", "eng", "deu", "chi_sim"];
  var selectList = ["eng", "kor"];
  String path = "";
  bool bload = false;

  bool bDownloadtessFile = false;

  var urlEditController =
      TextEditingController()
        ..text = "https://tesseract.projectnaptha.com/img/eng_bw.png";

  Future<void> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return new File(
      path,
    ).writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  void runFilePiker() async {
    // android && ios only
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      _ocr(pickedFile.path);
    }
  }

  void _ocr(url) async {
    if (selectList.length <= 0) {
      print("Please select language");
      return;
    }
    path = url;
    if (kIsWeb == false &&
        (url.indexOf("http://") == 0 || url.indexOf("https://") == 0)) {
      Directory tempDir = await getTemporaryDirectory();
      HttpClient httpClient = new HttpClient();
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
      HttpClientResponse response = await request.close();
      Uint8List bytes = await consolidateHttpClientResponseBytes(response);
      String dir = tempDir.path;
      print('$dir/test.jpg');
      File file = new File('$dir/test.jpg');
      await file.writeAsBytes(bytes);
      url = file.path;
    }
    var langs = selectList.join("+");

    bload = true;
    setState(() {});

    _ocrText = await FlutterTesseractOcr.extractText(
      url,
      language: langs,
      args: {"preserve_interword_spaces": "1"},
    );

    bload = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("title")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    runFilePiker(); // 이미지 선택
                  },
                  icon: const Icon(Icons.image),
                  label: const Text('갤러리'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // 카메라 촬영도 붙이고 싶다면 이 부분 확장 가능
                  },
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('카메라'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (path.isNotEmpty)
              path.startsWith("http")
                  ? Image.network(path, height: 200)
                  : Image.file(File(path), height: 200),
            const SizedBox(height: 16),
            if (bload) const Center(child: CircularProgressIndicator()),
            if (!bload)
              Expanded(
                child: SingleChildScrollView(
                  child: Text(_ocrText, style: const TextStyle(fontSize: 16)),
                ),
              ),
            Container(
              color: Colors.black26,
              child:
                  bDownloadtessFile
                      ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            Text('download Trained language files'),
                          ],
                        ),
                      )
                      : SizedBox(),
            ),
          ],
        ),
      ),
      floatingActionButton:
          kIsWeb
              ? Container()
              : FloatingActionButton(
                onPressed: () {
                  runFilePiker();
                  // _ocr("");
                },
                tooltip: 'OCR',
                child: Icon(Icons.add),
              ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
