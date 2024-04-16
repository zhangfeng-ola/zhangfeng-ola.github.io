import 'package:fluttertoast/fluttertoast.dart';
import 'package:super_clipboard/super_clipboard.dart';

class SuperClipboardUtil {
  /// [message]
  static Future writeData(String message) async {
    DataWriterItem item = DataWriterItem();
    item.add(Formats.plainText.call(message));
    await ClipboardWriter.instance.write([item]);
    print("response Body JSON =>  $message");
    Fluttertoast.showToast(msg: 'Copy Success!!');
  }
}
