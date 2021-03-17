import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redux_example/src/providers/MemberModel.dart';
import 'package:redux_example/src/providers/StatusModel.dart';
import 'package:redux_example/src/services/api/fetchData.dart';

class LogIn extends StatefulWidget {
  @override
  _LogIn createState() => _LogIn();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _LogIn extends State<LogIn> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final password = TextEditingController();
  final username = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    password.dispose();
    username.dispose();
    super.dispose();
  }

  void _onFetchPostsPressed(BuildContext context) async {
 await  fetchPostsAction(context, 'binhtatnguyen', 'T61b2541999').then((value) {
   Navigator.pushNamed(context, '/homePage');
 }).catchError((value) => print(value));


    // Provider.of<MemberModel>(context, listen: false).loadData();


    //

    // Provider.of<MemberModel>(context, listen: false).loadUserInfo();
    // Provider.of<MemberModel>(context, listen: false).loadUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                        border: OutlineInputBorder(),
                        labelText: 'username',
                      ),
                      controller: username,
                    ),
                  ),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                    controller: password,
                  ),
                  RawMaterialButton(
                    child: SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("Log in"),
                              SizedBox(
                                width: (MediaQuery. of(context). size. width)/3.2,
                              ),
                              Consumer<StatusModel>(
                                  builder: (context, statusData, child) {
                                if (statusData.isLoading) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 10,right: 10),
                                    child: SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator()),
                                  );
                                } else {
                                  return SizedBox(
                                    height: 20,
                                    width: 40,
                                  );
                                }
                              }),

                            ])),
                    fillColor: Colors.grey,
                    onPressed: () =>
                        //deleteDB,
                        //testPress,
                        _onFetchPostsPressed(context),
                  ),
                  Consumer<StatusModel>(
                      builder: (context, statusData, child) {
                        if (statusData.isError) {
                          return Text("Failed to get posts");
                        } else {
                          return SizedBox.shrink();
                        }
                      }),
                ])),
      ),

    );
  }
}
