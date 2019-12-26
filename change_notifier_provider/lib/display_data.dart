import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'user_provider.dart';

class DisplayData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return userProvider.isLoading
        ? Center(
            child: Container(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(),
            ),
          )
        : ListView.builder(
            itemCount: userProvider.users.length,
            itemBuilder: (context, index) {
              return Container(
                  height: 50,
                  color: Colors.grey[(index * 200) % 400],
                  child: Center(
                      child: Text(
                          '${userProvider.users[index].firstName} ${userProvider.users[index].lastName} | ${userProvider.users[index].website}')));
            },
          );
  }
}
