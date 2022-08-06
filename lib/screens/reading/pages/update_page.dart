import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noction/data/models/reading_model.dart';
import 'package:noction/data/repositories/reading_repository.dart';

class UpdateForm extends StatefulWidget {
  const UpdateForm({
    Key? key,
    required this.data,
  }) : super(key: key);

  final ReadingRecord data;

  @override
  State<UpdateForm> createState() => _UpdateFormState();
}

class _UpdateFormState extends State<UpdateForm> {
  final _formKey = GlobalKey<FormState>();

  final controllerName = TextEditingController();
  final controllerType = TextEditingController();
  final controllerStatus = TextEditingController();
  final controllerScore = TextEditingController();
  final controllerCreatedTime = TextEditingController();

  List<String> readingStatusList = [
    "Finished",
    "In Progress",
  ];

  String? textValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    controllerName.text = widget.data.name;
    controllerType.text = widget.data.type;
    controllerStatus.text =
        widget.data.status.isEmpty ? "In Progress" : widget.data.status;
    controllerScore.text = widget.data.score.toString();
  }

  @override
  void dispose() {
    controllerName.dispose();
    controllerType.dispose();
    controllerStatus.dispose();
    controllerScore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text(
          'Update',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: controllerName,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
                hintText: 'Enter a reading name',
              ),
              validator: textValidator,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: controllerType,
              decoration: const InputDecoration(
                labelText: 'Type',
                border: OutlineInputBorder(),
                hintText: 'Enter a reading type',
              ),
              validator: textValidator,
            ),
            SizedBox(height: 10),
            FormField<String>(
              builder: (FormFieldState<String> state) {
                return InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Status',
                    border: OutlineInputBorder(),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: controllerStatus.text,
                      isDense: true,
                      onChanged: (String? newValue) {
                        controllerStatus.text = newValue.toString();
                      },
                      items: readingStatusList.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value.toString(),
                          child: Text(value.toString()),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: controllerScore,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(
                labelText: 'Score',
                border: OutlineInputBorder(),
                hintText: 'Enter a score number',
              ),
              validator: textValidator,
            ),
            SizedBox(height: 10),
            MaterialButton(
              child:
                  const Text('Submit', style: TextStyle(color: Colors.white)),
              color: Colors.black,
              height: 50,
              minWidth: 100,
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final id = widget.data.id;
                  if (id.isEmpty) {
                    await ReadingRepository().addItem(ReadingRecord(
                      name: controllerName.text,
                      type: controllerType.text,
                      status: controllerStatus.text,
                      score: double.parse(controllerScore.text),
                      createdTime: DateTime.now(),
                    ));
                  } else {
                    await ReadingRepository().updateItem(ReadingRecord(
                      id: id,
                      name: controllerName.text,
                      type: controllerType.text,
                      status: controllerStatus.text,
                      score: double.parse(controllerScore.text),
                      createdTime: widget.data.createdTime,
                    ));
                  }
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
