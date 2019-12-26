import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'user_provider.dart';

import 'display_data.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: Text(
            "Change Notifier Provider",
            style: TextStyle(
                fontFamily: 'arial',
                color: Colors.white,
                fontSize: 18,
                letterSpacing: 1.4),
          )),
      body: Align(
        alignment: Alignment(0.0, -0.5),
        child: RaisedButton(
          onPressed: () {
            _buildModalBottomSheet(context);
          },
          child: Text("Show Data"),
        ),
      ),
    );
  }
}

Future<void> _buildModalBottomSheet(BuildContext context) {
  final UserProvider userProvider =
      Provider.of<UserProvider>(context, listen: false);
  return showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return ChangeNotifierProvider.value(
          value: userProvider, child: DisplayData());
    },
  );
}
