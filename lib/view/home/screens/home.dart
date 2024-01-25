// ignore_for_file: unnecessary_null_comparison, library_private_types_in_public_api

import 'dart:developer';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  List<VideoPlayerController> videoControllers = [];
  List<Future<void>> initializeVideoFutures = [];
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _loadSavedVideos();
  }

  @override
  void dispose() {
    for (var controller in videoControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  // Load saved video paths from SharedPreferences
  Future<void> _loadSavedVideos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? savedVideoPaths = prefs.getStringList('videoPaths');

    if (savedVideoPaths != null) {
      for (final String path in savedVideoPaths) {
        final VideoPlayerController controller = VideoPlayerController.file(
          File(path),
          videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
        );
        final Future<void> initializeVideoFuture = controller.initialize();

        setState(() {
          videoControllers.add(controller);
          initializeVideoFutures.add(initializeVideoFuture);
        });
      }
    }
  }

  // Save the video path to SharedPreferences
  Future<void> _saveVideoPath(String path) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> savedVideoPaths =
        prefs.getStringList('videoPaths') ?? [];
    savedVideoPaths.add(path);
    await prefs.setStringList('videoPaths', savedVideoPaths);
  }

  @override
  bool get wantKeepAlive => true; // Return true to keep the state alive.

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 244, 204, 201),
          title: const Text("FM9"),
        ),
        body: ListView.builder(
          itemCount: videoControllers.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: GestureDetector(
                onTap: () => _toggleVideoPlayback(index),
                child: SizedBox(
                  width: 100.0,
                  child: videoControllers[index] != null
                      ? AspectRatio(
                          aspectRatio: 16 / 9,
                          child: VideoPlayer(videoControllers[index]),
                        )
                      : Container(),
                ),
              ),
              trailing: PopupMenuButton<String>(
                onSelected: (String result) {
                  log("Selected: $result");
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'option1',
                    child: Text('Edit'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'option2',
                    child: Text('Delete'),
                  ),
                ],
                icon: const Icon(Icons.more_vert),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Video Name: ${p.basename(videoControllers[index].dataSource)}",
                  ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _pickVideo(context),
          tooltip: 'Upload Video',
          child: const Icon(Icons.file_upload),
        ),
      ),
    );
  }

  Future<void> _pickVideo(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? video = await picker.pickVideo(source: ImageSource.gallery);

    if (video != null) {
      final VideoPlayerController controller = VideoPlayerController.file(
        File(video.path),
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );
      final Future<void> initializeVideoFuture = controller.initialize();

      setState(() {
        videoControllers.add(controller);
        initializeVideoFutures.add(initializeVideoFuture);
      });

      // Save the video path
      await _saveVideoPath(video.path);
    }
  }

  void _toggleVideoPlayback(int index) {
    if (videoControllers[index] != null) {
      if (isPlaying) {
        videoControllers[index].pause();
      } else {
        videoControllers[index].play();
      }
      setState(() {
        isPlaying = !isPlaying;
      });
    }
  }
}
