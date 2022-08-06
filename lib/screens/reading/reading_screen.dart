import 'dart:developer' as developer;

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:noction/failure_model.dart';
import 'package:noction/screens/reading/pages/update_page.dart';
import 'package:noction/data/models/reading_model.dart';
import 'package:noction/data/repositories/reading_repository.dart';

import 'components/reading_card.dart';

class ReadingScreen extends StatefulWidget {
  const ReadingScreen({Key? key}) : super(key: key);

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  late Future<List<ReadingRecord>> _futureItems;

  @override
  void initState() {
    super.initState();
    _futureItems = ReadingRepository().getItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        title:
            const Text('Reading List', style: TextStyle(color: Colors.black87)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return UpdateForm(
                data: ReadingRecord(
              id: '',
              name: '',
              type: '',
              status: '',
              score: 0,
              createdTime: DateTime.now(),
            ));
          })).then((value) => null).then((_) {
            _futureItems = ReadingRepository().getItems();
            setState(() {});
          });
          ;
        },
        backgroundColor: Colors.black87,
        mini: true,
        tooltip: 'Add an record',
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
          onRefresh: () async {
            _futureItems = ReadingRepository().getItems();
            setState(() {});
          },
          child: FutureBuilder<List<ReadingRecord>>(
            future: _futureItems,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final items = snapshot.data!;
                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = items[index];
                    return ReadingCard(
                      data: item,
                    );
                  },
                );
              } else if (snapshot.hasError) {
                final failure = snapshot.error as Failure;
                return Center(child: Text(failure.message));
              }
              return const Center(child: CircularProgressIndicator());
            },
          )),
    );
  }
}
