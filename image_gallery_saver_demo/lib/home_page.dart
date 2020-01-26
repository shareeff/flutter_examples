import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'image_provider_view_model.dart';
import 'dialogs.dart';
import 'package:toast/toast.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  @override
  Widget build(BuildContext context) {
    final _screenHeight = MediaQuery.of(context).size.height - 16;
    final _screenWidth = MediaQuery.of(context).size.width - 32;
    final _imageProviderViewModel =
        Provider.of<ImageProviderViewModel>(context, listen: true);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            "Gallery Image Saver",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        body: Material(
          color: Colors.grey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Container(
                width: _screenWidth,
                height: _screenHeight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 18 / 11,
                      child: _imageProviderViewModel.pickedImage == null
                          ? Center(
                              child: Text("No image selected"),
                            )
                          : Ink.image(
                              image: new MemoryImage(
                                  _imageProviderViewModel.pickedImage),
                              fit: BoxFit.fitWidth,
                            ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RaisedButton(
                              child: Text("Camera",
                                  style: TextStyle(
                                      fontFamily: 'arial',
                                      color: Colors.black,
                                      fontSize: 18,
                                      letterSpacing: 1.4)),
                              onPressed: () =>
                                  _imageProviderViewModel.pickCameraImage(),
                              color: Colors.lightGreen[800],
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              splashColor: Colors.grey,
                            ),
                            RaisedButton(
                              child: Text("Gallery",
                                  style: TextStyle(
                                      fontFamily: 'arial',
                                      color: Colors.black,
                                      fontSize: 18,
                                      letterSpacing: 1.4)),
                              onPressed: () =>
                                  _imageProviderViewModel.pickGalleryImage(),
                              color: Colors.lightGreen[800],
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              splashColor: Colors.grey,
                            ),
                            RaisedButton(
                              child: Text("Save",
                                  style: TextStyle(
                                      fontFamily: 'arial',
                                      color: Colors.black,
                                      fontSize: 18,
                                      letterSpacing: 1.4)),
                              onPressed: () => _saveImage(context),
                              color: Colors.lightGreen[800],
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              splashColor: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Future<void> _saveImage(BuildContext context) async {
    try {
      Dialogs.showLoadingDialog(context, _keyLoader);
      new Future.delayed(new Duration(seconds: 3), () {
        //Navigator.pop(context); //pop dialog
        final imageProviderViewModel =
            Provider.of<ImageProviderViewModel>(context, listen: false);
        imageProviderViewModel.saveImage().whenComplete(() {
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          Toast.show("Image Saved", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
        });
      });
    } catch (error) {
      print(error);
    }
  }
}
