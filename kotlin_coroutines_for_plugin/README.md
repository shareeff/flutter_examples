# image_gallery_saver

This Project shows how to use kotlin coroutines for flutter android plugin. Sometimes you need to run some heavy computation in bacground thread to prevent ui blocking experience. Flutter has isolate method for this purpose. However, there is no direct way to use isolate for native channel method. Kotlin coroutines is the easiest way for this purpose. 

In this demo [hui-z/image_gallery_saver](https://github.com/hui-z/image_gallery_saver) package is modified for demonstrating kotlin coroutines. You can compare this file(ImageGallerySaverPlugin.kt) for both implementation to get the idea. 

# aync_function_for_stream_builder

This implementation is same as my previous [implementation](https://github.com/shareeff/flutter_examples/tree/master/aync_function_for_stream_builder). Here I use my modified image_gallery_saver package. This is the only difference. If you run both this implementation(previous and new), it will be clear to you that, new one doesn't have any blocing ui experience while saving image to gallery.   
 


