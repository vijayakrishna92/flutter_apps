import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

class FullScreenCameraRecorder extends StatefulWidget {
  const FullScreenCameraRecorder({super.key});

  @override
  State<FullScreenCameraRecorder> createState() => _FullScreenCameraRecorderState();
}

class _FullScreenCameraRecorderState extends State<FullScreenCameraRecorder> {
  late CameraController _controller;
  bool _isRecording = false;
  bool _isInitialized = false;

  // Show instructions overlay
  bool _showInstructions = true;
  int _currentSlide = 0;

  final List<String> _instructions = [
    "Make sure your face is clearly visible.",
    "Stay still and look into the camera.",
    "Ensure there is no bright light behind you."
  ];

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    await Permission.camera.request();
    await Permission.storage.request();

    final cameras = await availableCameras();
    final frontCam = cameras.firstWhere((c) => c.lensDirection == CameraLensDirection.front);

    _controller = CameraController(frontCam, ResolutionPreset.high);
    await _controller.initialize();
    setState(() => _isInitialized = true);
  }

  Future<String> _getDownloadPath() async {
    const String downloadPath = "/storage/emulated/0/Download";
    final Directory dir = Directory(downloadPath);
    if (!await dir.exists()) await dir.create(recursive: true);
    return path.join(downloadPath, 'video.mp4');
  }

  Future<void> _recordVideo() async {
    if (_isRecording) return;
    setState(() => _isRecording = true);

    final filePath = await _getDownloadPath();
    await _controller.startVideoRecording();
    await Future.delayed(const Duration(seconds: 30));
    final file = await _controller.stopVideoRecording();

    final savedFile = File(file.path);
    await savedFile.copy(filePath);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Video saved to Downloads")),
    );

    setState(() => _isRecording = false);
    Navigator.pop(context);
  }

  Widget _buildInstructionsOverlay() {
    return Container(
      color: Colors.black54,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _instructions[_currentSlide],
            style: const TextStyle(color: Colors.white, fontSize: 22),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  setState(() => _showInstructions = false);
                },
                child: const Text("Skip", style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(width: 30),
              ElevatedButton(
                onPressed: () {
                  if (_currentSlide < _instructions.length - 1) {
                    setState(() => _currentSlide++);
                  } else {
                    setState(() => _showInstructions = false);
                  }
                },
                child: Text(_currentSlide < _instructions.length - 1 ? "Next" : "Start Recording"),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: Stack(
        children: [
          CameraPreview(_controller),
          if (_showInstructions) _buildInstructionsOverlay(),
          if (!_showInstructions)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: ElevatedButton.icon(
                  onPressed: _isRecording ? null : _recordVideo,
                  icon: const Icon(Icons.videocam),
                  label: Text(_isRecording ? "Recording..." : "Record 30 sec"),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
