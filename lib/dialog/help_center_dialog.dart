import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/**
 * help page
 */
class HelpCenterDialog extends StatefulWidget {
  const HelpCenterDialog({Key? key});

  static Future<void> show({required BuildContext context}) async {
    await showDialog(
      context: context,
      builder: (context) => HelpCenterDialog(),
      barrierDismissible: true,
    );
  }

  @override
  State<HelpCenterDialog> createState() => _HelpCenterDialogState();
}

class _HelpCenterDialogState extends State<HelpCenterDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        alignment: AlignmentDirectional.topCenter,
        padding: const EdgeInsetsDirectional.all(45.0),
        width: 500,
        height: 500,
        decoration: const BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "How to use ??",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                "This feature comes from PT!! Thanks 👇👇👇",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "https://github.com/olachat/web_log_console",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10.0),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () async {
                    Uri uri = Uri.parse(
                        'https://github.com/olachat/web_log_console/blob/main/README.md');
                    if (!await launchUrl(uri)) {
                      throw Exception('Could not launch $uri');
                    }
                  },
                  child: Container(
                    padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(8)),
                    child: const Text(
                      "Click to help page 🔜",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
