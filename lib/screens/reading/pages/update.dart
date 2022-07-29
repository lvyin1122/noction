import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noction/screens/reading/reading_model.dart';
import 'package:noction/screens/reading/reading_repository.dart';

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
    controllerStatus.text = widget.data.status;
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
        title: const Text('Update'),
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
              ),
              validator: textValidator,
            ),
            TextFormField(
              controller: controllerType,
              decoration: const InputDecoration(
                labelText: 'Type',
              ),
              validator: textValidator,
            ),
            TextFormField(
              controller: controllerStatus,
              decoration: const InputDecoration(
                labelText: 'Status',
              ),
              validator: textValidator,
            ),
            TextFormField(
              controller: controllerScore,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(
                labelText: 'Score',
              ),
              validator: textValidator,
            ),
            MaterialButton(
              child: const Text('Submit'),
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
