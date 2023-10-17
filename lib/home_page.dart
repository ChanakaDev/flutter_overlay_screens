import 'dart:isolate';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // TODO: create a send port
  // TODO: to send data from main app to overlay/ trigger methods in overlay widget
  SendPort? homePort;

  @override
  void initState() {
    super.initState();
    // TODO: Check is send port null in initstate
    if (homePort != null) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Close overlay when needed
          FlutterOverlayWindow.closeOverlay().then(
            (value) => developer.log('Stpped overlay @@: $value'),
          );
        },
        child: const Text(
          "CLOSE",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('Example App'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () async {
                // TODO: Check whether we have overlay permission or not
                final status = await FlutterOverlayWindow.isPermissionGranted();
                developer.log("Is permission granted @@: $status");
              },
              child: const Text("Check Permission"),
            ),
            const SizedBox(height: 10.0),
            TextButton(
              onPressed: () async {
                // TODO: Require overlay permission, if we dont have
                final bool? res =
                    await FlutterOverlayWindow.requestPermission();
                developer.log("Permission status @@: $res");
              },
              child: const Text("Request Permission"),
            ),
            const SizedBox(height: 10.0),
            TextButton(
              onPressed: () async {
                // TODO: Show overlay window, if it is not already esist in the screen
                if (await FlutterOverlayWindow.isActive()) return;
                await FlutterOverlayWindow.showOverlay(
                  // TODO: Enable or disable dragging the overlay
                  enableDrag: true,
                  overlayTitle: "X-SLAYER",
                  overlayContent: 'Overlay Enabled',
                  flag: OverlayFlag.defaultFlag,
                  visibility: NotificationVisibility.visibilityPublic,
                  positionGravity: PositionGravity.auto,
                  // TODO: Set overlay full screen
                  height: WindowSize.matchParent,
                  width: WindowSize.matchParent,
                );
              },
              child: const Text("Show Overlay"),
            ),
            const SizedBox(height: 10.0),
            TextButton(
              onPressed: () async {
                // TODO: Update the overlay window if needed from the main code
                await FlutterOverlayWindow.shareData('update');
              },
              child: const Text("Update Overlay"),
            ),
            const SizedBox(height: 10.0),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
