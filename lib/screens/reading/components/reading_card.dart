import 'package:flutter/material.dart';
import 'package:noction/screens/reading/pages/update_page.dart';
import 'package:noction/data/models/reading_model.dart';

class ReadingCard extends StatefulWidget {
  const ReadingCard({
    Key? key,
    required this.data,
  }) : super(key: key);
  final ReadingRecord data;
  @override
  State<ReadingCard> createState() => _ReadingCardState();
}

class _ReadingCardState extends State<ReadingCard> {
  Color _cardColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          _cardColor = Colors.grey.shade100;
        });
      },
      onTapUp: (details) {
        setState(() {
          _cardColor = Colors.white;
        });
      },
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return UpdateForm(data: widget.data);
        }));
      },
      child: Container(
        width: double.infinity,
        height: 72,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: EdgeInsets.only(top: 8, left: 10, right: 10),
        decoration: BoxDecoration(
          color: _cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              width: 40,
              height: double.infinity,
              child: Icon(Icons.book_outlined, size: 28),
            ),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("1900", style: yearStyle),
                      Text(
                        widget.data.name,
                        style: nameStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "Created on ${widget.data.createdTime}",
                        style: timeStyle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      )
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${widget.data.score}", style: scoreStyle),
                  ],
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}

const TextStyle nameStyle = TextStyle(
  fontSize: 16,
  color: Colors.black,
  fontWeight: FontWeight.w600,
);

const TextStyle yearStyle = TextStyle(
  color: Colors.grey,
  fontSize: 10,
  fontWeight: FontWeight.w400,
);

const TextStyle timeStyle = TextStyle(
  color: Colors.grey,
  fontSize: 10,
  fontWeight: FontWeight.w200,
);

const TextStyle scoreStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w600,
);
