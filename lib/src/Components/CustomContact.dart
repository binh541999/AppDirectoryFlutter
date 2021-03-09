import 'package:flutter/material.dart';

class CustomContact extends StatelessWidget {
  final String shortName;
  final String titleName;
  final String picURL;

  CustomContact({
    @required this.shortName,
    @required this.titleName,
    @required this.picURL,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        height: 75,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 60,
                child: ClipRRect(
                  borderRadius:  BorderRadius.circular(50),
                  child: Image.network(
                    picURL,
                    height: 70,
                    alignment: Alignment.topCenter,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),

              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      shortName,
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      titleName,
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 50.0,
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child:
                          IconButton(onPressed: () {}, icon: Icon(Icons.phone)),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
