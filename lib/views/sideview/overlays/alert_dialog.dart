import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:newsapplication/controller/loading_controller.dart';

class AlertOverlay {
  AlertOverlay._sharedInstance();
  static final AlertOverlay _shared = AlertOverlay._sharedInstance();
  factory AlertOverlay.instance() => _shared;

  LoadingController? controller;

  void show({
    required BuildContext context,
    required String text,
  }) {
    if (controller?.updateOptions(text) ?? false) {
      return;
    } else {
      controller = showOverlay(
        context: context,
        text: text,
      );
    }
  }

  void hide() {
    controller?.closeOptions();
    controller = null;
  }

  LoadingController showOverlay({
    required BuildContext context,
    required String text,
  }) {
    final overlayState = Overlay.of(context);
    final overlay = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              // color: Colors.black.withOpacity(0.1),
            ),
            Positioned(
              bottom: 0,
              child: GlassContainer(
                height: 100,
                width: MediaQuery.of(context).size.width - 20,
                blur: 20,
                child: Material(
                    color: Colors.transparent, child: const Text("pop up")),
              ),
            )
          ],
        );
      },
    );

    overlayState.insert(overlay);

    return LoadingController(
      closeOptions: () {
        overlay.remove();
        return true;
      },
      updateOptions: (text) {
        return true;
      },
    );
  }
}
