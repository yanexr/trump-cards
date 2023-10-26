import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../app.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Material(
          child: Container(
              alignment: Alignment.center,
              color: Colors.blue,
              width: double.infinity,
              height: kToolbarHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        side: const BorderSide(width: 2, color: Colors.white60),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/about');
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.info,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 10,
                            height: 35,
                          ),
                          Text(
                            tr('about'),
                            style: const TextStyle(color: Colors.white),
                          )
                        ],
                      )),
                  const SizedBox(
                    width: 15,
                  ),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        side: const BorderSide(width: 2, color: Colors.white60),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/statistics');
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.emoji_events_rounded,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 10,
                            height: 35,
                          ),
                          Text(
                            '${App.wins}',
                            style: const TextStyle(color: Colors.white),
                          )
                        ],
                      )),
                  const SizedBox(
                    width: 15,
                  ),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        side: const BorderSide(width: 2, color: Colors.white60),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/settings');
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.settings_rounded,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 10,
                            height: 35,
                          ),
                          Text(
                            tr('settings'),
                            style: const TextStyle(color: Colors.white),
                          )
                        ],
                      ))
                ],
              )),
        ));
  }

  @override
  Size get preferredSize => const Size(200, kToolbarHeight);
}
