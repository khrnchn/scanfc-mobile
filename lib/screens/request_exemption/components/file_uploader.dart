import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nfc_smart_attendance/constant.dart';
import 'package:nfc_smart_attendance/form_bloc/request_exemption_form_bloc.dart';
import 'package:nfc_smart_attendance/public_components/space.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart' as path;
import 'package:file_picker/file_picker.dart';

class UploadFile extends StatefulWidget {
  final Function(XFile) onFileSelected;
  final RequestExemptionFormBloc formBloc;
  const UploadFile(
      {super.key, required this.onFileSelected, required this.formBloc});

  @override
  State<UploadFile> createState() => _InputPassportPhotoState();
}

class _InputPassportPhotoState extends State<UploadFile> {
  String filePlaceHolderName = "Exemption File Proof";
  XFile? _selectedFile;

  Future<void> _selectAndUploadImage() async {
    List<XFile>? selectedFile = await selectFile();
    if (selectedFile != null && selectedFile.isNotEmpty) {
      setFileTotext(selectedFile[0], widget.onFileSelected);
    }
  }

  Future<List<XFile>?> selectFile() async {
    try {
      FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'png', 'jpeg', 'jpg'],
      );

      if (pickedFile != null) {
        return [XFile(pickedFile.files.single.path!)];
      }
    } catch (e) {
      print('Error selecting PDF file: $e');
    }
  }

  void setFileTotext(XFile selectedFilePDF, Function(XFile) onFileSelected) {
    setState(() {
      _selectedFile = selectedFilePDF;
      onFileSelected(selectedFilePDF);
      filePlaceHolderName = path.basename(_selectedFile!.path);
      widget.formBloc.newExemptionRequestFile = _selectedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: ScaleTap(
            onPressed: widget.formBloc.newExemptionRequestFile != null
                ? () async {
                    await OpenFilex.open(_selectedFile!.path);
                    return [XFile(_selectedFile!.path)];
                  }
                : null,
            child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: kGrey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        filePlaceHolderName,
                        style: TextStyle(
                            color:
                                widget.formBloc.newExemptionRequestFile != null
                                    ? kBlack
                                    : kGrey),
                      ),
                    ),
                    widget.formBloc.newExemptionRequestFile != null
                        ? ScaleTap(
                            onPressed: () {
                              setState(() {
                                filePlaceHolderName = "Exemption File Proof";
                                _selectedFile = null;
                                widget.formBloc.newExemptionRequestFile = null;
                              });
                            },
                            child: Icon(
                              Icons.cancel,
                              color: kDarkGrey,
                            ),
                          )
                        : Space(0)
                  ],
                )),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 1,
          child: UploadButton(
            icon: Icons.upload,
            title: "Upload",
            onPressed: () async {
              _selectAndUploadImage();
            },
          ),
        ),
      ],
    );
  }
}

class UploadButton extends StatelessWidget {
  const UploadButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
  });

  final IconData icon;
  final String title;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      onPressed: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: kPrimaryColor),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: kPrimaryColor,
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(color: kPrimaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
