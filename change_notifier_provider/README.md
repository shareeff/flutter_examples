# change_notifier_provider

This project shows provider example to access data from different widget tree. As showModalBottomSheet isn't a child of main widget tree, it can't directly access data from provider. So, it is therefore necessary to add the disired providers in the new widget tree.

```dart
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

```
