import 'package:flutter/material.dart';

class ReadingCard extends StatelessWidget {
  const ReadingCard(
      {Key? key,
      required this.name,
      this.year = "1900",
      required this.createdTime,
      required this.score})
      : super(key: key);

  final String name;
  final String year;
  final String createdTime;
  final double score;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 72,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.only(top: 8, left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
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
                    Text(year, style: yearStyle),
                    Text(
                      name,
                      style: nameStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Created on ${createdTime}",
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
                  Text("${score}", style: scoreStyle),
                ],
              )
            ],
          )),
        ],
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
