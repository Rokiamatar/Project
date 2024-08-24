import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class ShowCamera extends StatefulWidget {
  @override _ShowCameraState createState() => _ShowCameraState(); }
class _ShowCameraState extends State<ShowCamera> {
  late VlcPlayerController _videoPlayerController;
  @override
  void initState() {
    super.initState();
    _videoPlayerController = VlcPlayerController.network(
      'rtsp://admin:LJJRLI@156.220.101.164',
      hwAcc: HwAcc.full,
      autoPlay: true,
      options: VlcPlayerOptions(),
    );
  }
  @override
  void dispose() async {
    super.dispose();
    await _videoPlayerController.stopRendererScanning();
    await _videoPlayerController.dispose(); }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("CAMERA"),
        centerTitle: true,
      ),
      body: Center(
        child: VlcPlayer( controller: _videoPlayerController,
          aspectRatio: 16 / 9,
          placeholder: Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}