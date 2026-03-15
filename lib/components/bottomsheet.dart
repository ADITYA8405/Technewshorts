import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:technewshorts/components/components.dart';
import 'package:technewshorts/utils/text.dart';

import 'package:url_launcher/url_launcher.dart';

void showMyBottomSheet(
    BuildContext context, String title, String description, imageurl, url) {
  showBottomSheet(
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      elevation: 20,
      context: context,
      builder: (context) {
        return MyBottomSheetLayout(
          url: url,
          imageurl: imageurl,
          title: title,
          description: description,
        ); // returns your BottomSheet widget
      });
}

// NOTE: For Android, ensure you have an intent filter for browsers in your AndroidManifest.xml.
// See: https://pub.dev/packages/url_launcher#android
Future<void> _launchURL(BuildContext context, String url) async {
  if (url.trim().isEmpty) return;
  Uri uri = Uri.tryParse(url) ?? Uri();
  if (uri.scheme.isEmpty) {
    // If no scheme provided, assume https
    uri = Uri.parse('https://$url');
  }

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Could not launch the article link.')),
    );
  }
}

//your bottom sheet widget class
//you can put your things here, like buttons, callbacks and layout
class MyBottomSheetLayout extends StatelessWidget {
  final String title, description, imageurl, url;

  const MyBottomSheetLayout(
      {Key? key,
      required this.title,
      required this.description,
      required this.imageurl,
      required this.url})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          BottomSheetImage(imageurl: imageurl, title: title),
          Container(
              padding: EdgeInsets.all(10),
              child: modifiedText(
                  text: description, size: 16, color: Colors.white)),
          Container(
            padding: EdgeInsets.all(10),
            child: InkWell(
              onTap: () => _launchURL(context, url),
              child: Text(
                'Read Full Article',
                style: GoogleFonts.lato(
                  color: Colors.blue.shade400,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}