import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ImageAttributionDialog extends StatelessWidget {
  final String imageAttribution;
  final String imageLicenseLink;
  const ImageAttributionDialog(
      {Key? key, this.imageAttribution = '', this.imageLicenseLink = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: const Text('Image Credit'),
      content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(imageAttribution),
            const SizedBox(height: 10),
            MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    launchUrl(Uri.parse(imageLicenseLink));
                  },
                  child: Text(
                    imageLicenseLink,
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                ))
          ]),
    );
  }
}
