import 'package:aloqa_nazorati/utils/utils.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key, required this.description});
  final CameraDescription? description;

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> with WidgetsBindingObserver {
  late CameraController? _cameraController;
  late Future<void>? _initialiseCameras;

  @override
  void initState() {
    _cameraController = CameraController(
        widget.description!, ResolutionPreset.medium,
        imageFormatGroup: ImageFormatGroup.jpeg);

    _initialiseCameras = _cameraController!.initialize();
    super.initState();
  }

  @override
  void dispose() {
    _cameraController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: body!,
            ),
            Expanded(flex: 2, child: takePickButton!)
          ],
        ),
      ),
      // floatingActionButton: takePickButton,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget? get takePickButton {
    return FloatingActionButton(
      backgroundColor: ColorsUtils.myColor,
      onPressed: () async {
        try {
          await _initialiseCameras;
          final XFile image = await _cameraController!.takePicture();
          // ignore: use_build_context_synchronously
          if (Navigator.canPop(context)) {
            // ignore: use_build_context_synchronously
            Navigator.of(context).pop(image);
          }
          log(image.path);
        } catch (e) {
          log(e);
        }
      },
      child: const Icon(Icons.camera),
    );
  }

  Widget? get body {
    return FutureBuilder(
        future: _initialiseCameras,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(
              _cameraController!,
            );
          } else {
            return const CupertinoActivityIndicator();
          }
        });
  }
}
