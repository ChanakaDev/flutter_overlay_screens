import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

class TrueCallerOverlay extends StatefulWidget {
  const TrueCallerOverlay({Key? key}) : super(key: key);

  @override
  State<TrueCallerOverlay> createState() => _TrueCallerOverlayState();
}

class _TrueCallerOverlayState extends State<TrueCallerOverlay> {
  bool isPurple = true;

  @override
  void initState() {
    super.initState();
    // TODO: Update the overlay window if needed from the main code
    FlutterOverlayWindow.overlayListener.listen((event) {
      developer.log(event);
      setState(() {
        if (event == 'update') {
          isPurple = !isPurple;
          developer.log("Event is 'update'");
        } else {
          developer.log("Event is not 'update'");
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Flutter Overlay Screens",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Container(
              color: isPurple ? Colors.purple : Colors.red,
              height: 200,
              width: double.infinity,
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  "testing overlays",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
