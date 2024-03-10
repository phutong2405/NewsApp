import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:newsapplication/controller/loading_controller.dart';

class LoadingOverlay {
  LoadingOverlay._sharedInstance();
  static final LoadingOverlay _shared = LoadingOverlay._sharedInstance();
  factory LoadingOverlay.instance() => _shared;

  LoadingController? controller;

  void show({
    required BuildContext context,
  }) {
    controller = showOverlay(
      context: context,
    );
  }

  void hide() {
    controller?.closeOptions();
    controller = null;
  }

  LoadingController showOverlay({
    required BuildContext context,
  }) {
    final overlayState = Overlay.of(context);
    final overlay = OverlayEntry(
      builder: (context) {
        print("runned");
        return Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.black.withOpacity(0.1),
            ),
            Center(
              // top: 0,
              child: GlassContainer(
                blur: 20,
                child: Container(
                    height: 100,
                    width: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.onBackground,
                    )),
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
