import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ElevatedButtonWidget extends StatelessWidget {
  final String text;
  final Color bgColor;

  final Color? textColor;
  void Function()? onPress;
  ElevatedButtonWidget({
    super.key,
    required this.text,
    this.textColor,
    required this.bgColor,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: bgColor,
        textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: bgColor,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onPressed: onPress!,
      child: Text(
        text,
      ),
    );
  }
}









// // ignore_for_file: deprecated_member_use

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:video_player/video_player.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final TextEditingController _videoDescriptionController =
//       TextEditingController();
//   late VideoPlayerController _videoPlayerController;
//   late Future<void> _initializeVideoPlayerFuture;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize the VideoPlayerController with a sample video URL or file path.
//     _videoPlayerController = VideoPlayerController.network(
//       "https://file-examples.com/storage/fe2bf7f2c765b22929a188e/2017/04/file_example_MP4_480_1_5MG.mp4",
//     );
//     // Initialize the future and add a listener for when the initialization is complete.
//     _initializeVideoPlayerFuture = _videoPlayerController.initialize();
//     _initializeVideoPlayerFuture.then((_) {
//       // Ensure the first frame is shown after the video is initialized.
//       setState(() {});
//     });
//   }

//   @override
//   void dispose() {
//     // Ensure the VideoPlayerController is disposed to free up resources.
//     _videoPlayerController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: const Color.fromARGB(255, 244, 204, 201),
//           title: const Text("FM9"),
//         ),
//         body: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 itemCount: 1,
//                 itemBuilder: (BuildContext context, int index) {
//                   return ListTile(
//                     leading: FutureBuilder(
//                       future: _initializeVideoPlayerFuture,
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState == ConnectionState.done) {
//                           return AspectRatio(
//                             aspectRatio:
//                                 _videoPlayerController.value.aspectRatio,
//                             child: VideoPlayer(_videoPlayerController),
//                           );
//                         } else {
//                           return const CircularProgressIndicator();
//                         }
//                       },
//                     ),
//                     trailing: PopupMenuButton<String>(
//                       onSelected: (String result) {
//                         print("Selected: $result");
//                       },
//                       itemBuilder: (BuildContext context) =>
//                           <PopupMenuEntry<String>>[
//                         const PopupMenuItem<String>(
//                           value: 'option1',
//                           child: Text('Edit'),
//                         ),
//                         const PopupMenuItem<String>(
//                           value: 'option2',
//                           child: Text('Delete'),
//                         ),
//                       ],
//                       icon: const Icon(Icons.more_vert),
//                     ),
//                     title: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                             "Video Description: ${_videoDescriptionController.text}"),
//                         const SizedBox(height: 8.0),
//                         TextFormField(
//                           controller: _videoDescriptionController,
//                           decoration: InputDecoration(
//                             hintText: 'Enter video description...',
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () => _pickVideo(context),
//           tooltip: 'Upload Video',
//           child: Icon(Icons.file_upload),
//         ),
//       ),
//     );
//   }

//   Future<void> _pickVideo(BuildContext context) async {
//     final ImagePicker _picker = ImagePicker();
//     final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);

//     if (video != null) {
//       _initializeVideoPlayerFuture
//           .then((_) => _videoPlayerController.dispose());
//       _videoPlayerController = VideoPlayerController.file(
//         File(video.path),
//         videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
//       );
//       _initializeVideoPlayerFuture = _videoPlayerController.initialize();
//       _initializeVideoPlayerFuture.catchError((error) {
//         print("Error initializing video: $error");
//         // Handle the error (e.g., display an error message)
//       });
//       _videoPlayerController.setLooping(true);
//       _videoPlayerController.play();
//     }
//   }
// }
