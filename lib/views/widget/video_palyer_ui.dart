import 'package:bilivideo_down/util/common_util.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:window_manager/window_manager.dart';

class VideoPlayerUI extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerUI({super.key, required this.videoUrl});

  @override
  State<VideoPlayerUI> createState() => _VideoPlayerDialogState();
}

class _VideoPlayerDialogState extends State<VideoPlayerUI> {
  late VideoPlayerController _controller;
  double _progressValue = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {}); // Update the state once the video is initialized
      });
    _controller.addListener(() {
      setState(() {
        _progressValue = _controller.value.position.inMilliseconds.toDouble() /
            _controller.value.duration.inMilliseconds;
      });
    });
    _controller.setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    return Dialog(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: DragToMoveArea(
            child: AppBar(
              automaticallyImplyLeading: false, // Hide the back button
              actions: [
                Align(
                  alignment: Alignment.topRight,
                  child: Wrap(
                    spacing: 5,
                    children: [
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: WindowCaptionButton.minimize(
                          brightness: brightness,
                          onPressed: () async {
                            bool isMinimized =
                                await windowManager.isMinimized();
                            if (isMinimized) {
                              windowManager.restore();
                            } else {
                              windowManager.minimize();
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: FutureBuilder<bool>(
                          future: windowManager.isMaximized(),
                          builder: (BuildContext context,
                              AsyncSnapshot<bool> snapshot) {
                            if (snapshot.data == true) {
                              return WindowCaptionButton.unmaximize(
                                brightness: brightness,
                                onPressed: () async {
                                  await windowManager.unmaximize();
                                  setState(() {});
                                },
                              );
                            }
                            return WindowCaptionButton.maximize(
                              brightness: brightness,
                              onPressed: () async {
                                await windowManager.maximize();
                                setState(() {});
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: WindowCaptionButton.close(
                          brightness: brightness,
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            // VideoPlayer widget displays the video
            VideoPlayer(_controller),
            // Positioned widget to place controls at the bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (_controller.value.isInitialized)
                    Slider(
                      activeColor: Colors.blue,
                      inactiveColor: Colors.grey.withOpacity(0.5),
                      value: _progressValue,
                      onChanged: (newValue) {
                        setState(() {
                          _progressValue = newValue;
                          final Duration duration = _controller.value.duration;
                          _controller.seekTo(Duration(
                              milliseconds: (duration.inMilliseconds * newValue)
                                  .round()));
                        });
                      },
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // Aligns children to start and end of the row
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                if (_controller.value.isPlaying) {
                                  _controller.pause();
                                } else {
                                  _controller.play();
                                }
                              });
                            },
                            icon: Icon(
                              _controller.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: Colors.grey,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _controller.seekTo(Duration(
                                    milliseconds: _controller
                                            .value.position.inMilliseconds +
                                        10000));
                              });
                            },
                            icon: const Icon(
                              Icons.fast_forward,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            '${CommonUtil.formatDuration(_controller.value.position)} / ${CommonUtil.formatDuration(_controller.value.duration)}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      // Row(
                      //   children: [
                      //     IconButton(
                      //       onPressed: () {
                      //         // Implement sound control
                      //       },
                      //       icon: const Icon(
                      //         Icons.volume_up,
                      //         color: Colors.white,
                      //       ),
                      //     ),
                      //     IconButton(
                      //       onPressed: () {},
                      //       icon: const Icon(
                      //         Icons.fullscreen,
                      //         color: Colors.white,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
