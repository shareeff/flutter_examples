package com.example.imagegallerysaver

import android.content.Intent
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.net.Uri
import android.os.Environment
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.PluginRegistry.Registrar
import kotlinx.coroutines.*
import java.io.File
import java.io.FileOutputStream
import java.io.IOException

class ImageGallerySaverPlugin(private val registrar: Registrar): MethodCallHandler, CoroutineScope by MainScope(){

  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "image_gallery_saver")
      channel.setMethodCallHandler(ImageGallerySaverPlugin(registrar))
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result): Unit {
    when {
        call.method == "saveImageToGallery" -> {
          val image = call.arguments as ByteArray
          launch {
            result.success(saveImageToGallery(BitmapFactory.decodeByteArray(image,0,image.size)))
          }

        }
        call.method == "saveFileToGallery" -> {
          val path = call.arguments as String
          launch {
            result.success(saveFileToGallery(path))
          }

        }
        else -> result.notImplemented()
    }

  }

  private fun generateFile(extension: String = ""): File {
    val storePath =  Environment.getExternalStorageDirectory().absolutePath + File.separator + getApplicationName()
    val appDir = File(storePath)
    if (!appDir.exists()) {
      appDir.mkdir()
    }
    var fileName = System.currentTimeMillis().toString()
    if (extension.isNotEmpty()) {
      fileName += ("." + extension)
    }
    return File(appDir, fileName)
  }

  private suspend fun saveImageToGallery(bmp: Bitmap): String {
    val result = saveImageToGalleryDispatchers(bmp)
    return withContext(Dispatchers.Main) {
      return@withContext result
    }
  }

  private suspend fun saveImageToGalleryDispatchers(bmp: Bitmap): String {
    return withContext(Dispatchers.Default){
      val context = registrar.activeContext().applicationContext
      val file = generateFile("png")
      try {
        val fos = FileOutputStream(file)
        bmp.compress(Bitmap.CompressFormat.PNG, 60, fos)
        fos.flush()
        fos.close()
        val uri = Uri.fromFile(file)
        context.sendBroadcast(Intent(Intent.ACTION_MEDIA_SCANNER_SCAN_FILE, uri))
        return@withContext uri.toString()
      } catch (e: IOException) {
        e.printStackTrace()
      }
      return@withContext ""
    }
  }

  private suspend fun saveFileToGallery(filePath: String): String {
    val result = saveFileToGalleryDispatchers(filePath)
    return withContext(Dispatchers.Main) {
      return@withContext result
    }
  }



  private suspend fun saveFileToGalleryDispatchers(filePath: String): String {
   return withContext(Dispatchers.Default){
     val context = registrar.activeContext().applicationContext
     return@withContext try {
       val originalFile = File(filePath)
       val file = generateFile(originalFile.extension)
       originalFile.copyTo(file)

       val uri = Uri.fromFile(file)
       context.sendBroadcast(Intent(Intent.ACTION_MEDIA_SCANNER_SCAN_FILE, uri))
       return@withContext uri.toString()
     } catch (e: IOException) {
       e.printStackTrace()
       ""
     }
   }
  }

  private fun getApplicationName(): String {
    val context = registrar.activeContext().applicationContext
    var ai: ApplicationInfo? = null
    try {
        ai = context.packageManager.getApplicationInfo(context.packageName, 0)
    } catch (e: PackageManager.NameNotFoundException) {
    }
    var appName: String
    appName = if (ai != null) {
      val charSequence = context.packageManager.getApplicationLabel(ai)
      StringBuilder(charSequence.length).append(charSequence).toString()
    } else {
      "image_gallery_saver"
    }
    return  appName
  }


}
