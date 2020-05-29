import 'dart:io';

import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_reading/constants.dart' as Constants;

class WriteJournalPage extends StatefulWidget {
  @override
  _WriteJournalPageState createState() => _WriteJournalPageState();
}

class _WriteJournalPageState extends State<WriteJournalPage> {
  final titleController = TextEditingController();
  final extraController = TextEditingController();
  final fromController = TextEditingController();
  final toController = TextEditingController();

  String selectedValue;
  final List<DropdownMenuItem> items = [
    DropdownMenuItem(
        child: Text("Thinking Fast and Slow"), value: "Thinking Fast and Slow"),
    DropdownMenuItem(child: Text("Give and Take"), value: "Give and Take"),
    DropdownMenuItem(child: Text("무소유"), value: "무소유"),
    DropdownMenuItem(child: Text("포노 사피엔스"), value: "포노 사피엔스"),
    DropdownMenuItem(child: Text("Originals"), value: "Originals"),
    DropdownMenuItem(child: Text("이태원 클라쓰 1"), value: "이태원 클라쓰 2"),
    DropdownMenuItem(child: Text("어떻게 살 것인가"), value: "어떻게 살 것인가"),
    DropdownMenuItem(child: Text("몽실몽실나무"), value: "몽실몽실나무"),
  ];

  @override
  void dispose() {
    titleController.dispose();
    extraController.dispose();
    fromController.dispose();
    toController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("독서기록하기"),
          backgroundColor: Constants.MAIN_COLOR,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.book),
                title: SearchableDropdown(
                  // Books should be sorted by how recently they were added
                  items: items,
                  value: selectedValue,
                  hint: "Select one (필수) ",
                  searchHint: "Select one",
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                  isExpanded: true,
                ),
              ),
              Row(
                children: <Widget>[
                  Flexible(child: Text("쪽수 : ")),
                  SizedBox(
                    width: 10.0,
                  ),
                  Flexible(
                    child: TextField(
                      controller: fromController,
                      decoration: InputDecoration(
                        hintText: "From",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Flexible(
                    child: TextField(
                      controller: toController,
                      decoration: InputDecoration(
                        hintText: "To",
                      ),
                    ),
                  ),
                ],
              ),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: "한 줄 요약 (필수)",
                ),
              ),
              ImageCapture(),
              TextField(
                controller: extraController,
                decoration: InputDecoration(
                  hintText: "추가 글 ",
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ],
          ),
        ));
  }
}

class ImageCapture extends StatefulWidget {
  createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  File _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = selected;
    });
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
    );

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  void _clear() {
    setState(() {
      _imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text("사진 추가 : "),
        IconButton(
          icon: Icon(Icons.photo_camera),
          onPressed: () => _pickImage(ImageSource.camera),
        ),
        IconButton(
          icon: Icon(Icons.photo_library),
          onPressed: () => _pickImage(ImageSource.gallery),
        ),
        IconButton(
          icon: Icon(Icons.crop),
          onPressed: () => _cropImage(),
        ),
      ],
    );
  }
}
