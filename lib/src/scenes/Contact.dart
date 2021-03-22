import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redux_example/src/Components/CustomContact.dart';
import 'package:redux_example/src/models/Member.dart';
import 'package:redux_example/src/providers/MemberModel.dart';
import 'package:redux_example/src/providers/StatusModel.dart';

import '../Components/CustomContact.dart';


class Contact extends StatefulWidget {
  Contact({
    Key key,
  }) : super(key: key);

  @override
  _Contact createState() => _Contact();
}

class _Contact extends State<Contact> {
  var _controller = TextEditingController();

  @override
  void initState() {

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed:(){
                    Provider.of<MemberModel>(context, listen: false)
                        .changeSearchString('');
                  return _controller.clear();
                  } ,
                  icon: Icon(Icons.clear),
                ),
                hintText: 'Search ',
                hintStyle: TextStyle(
                  fontSize: 14,
                ),
              ),
              onChanged: (text) {
                text = text.toLowerCase();
                Provider.of<MemberModel>(context, listen: false)
                    .changeSearchString(text);
              },
            ),
          ),
          Expanded(
            child:
                Consumer<MemberModel>(builder: (context, membersData, child) {
             // print(membersData.members.toString());
              return ListView.builder(
                itemCount: membersData.members.length,
                itemBuilder: (BuildContext context, int index) => CustomContact(
                  employeeData: membersData.members[index],
                  key: Key(membersData.members[index].employeeId.toString()),
                ),
                //children: _buildPosts(posts),
              );
            }),
          ),
        ],
      ),
    );
  }
}
