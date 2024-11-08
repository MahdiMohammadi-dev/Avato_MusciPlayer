import 'package:avato/constant/app_colors.dart';
import 'package:avato/controllers/player_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query_forked/on_audio_query.dart';

class PlayerScreen extends StatelessWidget {
  final List<SongModel> songModel;

  const PlayerScreen({
    super.key,
    required this.songModel,
  });

  @override
  Widget build(BuildContext context) {
    var controller = Get.put<PlayerController>(PlayerController());
    return SafeArea(
        child: Scaffold(
            backgroundColor: bgColor,
            body: Padding(
              padding: const EdgeInsets.all(8),
              child: Obx(
                  ()=> Column(
                  children: [
                    Expanded(
                      child: Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          height: 350,
                          width: 350,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: QueryArtworkWidget(
                            id: songModel[controller.playIndex.value].id,
                            type: ArtworkType.AUDIO,
                            artworkHeight: double.infinity,
                            artworkWidth: double.infinity,
                            nullArtworkWidget: Icon(Icons.music_note),
                          )),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          borderRadius:
                          BorderRadius.vertical(top: Radius.circular(18)),
                          color: whiteColor,
                        ),
                        child: Column(
                          children: [
                            Text(songModel[controller.playIndex.value].displayNameWOExt,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w900, fontSize: 24)),
                            const SizedBox(height: 8),
                            Text(songModel[controller.playIndex.value].artist!,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.normal, fontSize: 20)),
                            const SizedBox(
                              height: 12,
                            ),
                            Obx(() =>
                                Row(
                                  children: [
                                    Text(controller.musicPosition.value,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.normal,
                                            color: bgDarkColor,
                                            fontSize: 20)),
                                    Expanded(
                                        child: Slider(
                                          value: controller.value.value,
                                          min: Duration(seconds: 0).inSeconds.toDouble(),
                                          max: controller.max.value,
                                          onChanged: (value) {
                                            controller.changeDurationToSeconds(value.toInt());
                                            value = value;
                                          },
                                          activeColor: bgDarkColor,
                                          inactiveColor: bgColor,
                                          thumbColor: sliderColor,
                                        )),
                                    Text(controller.musicDuration.value,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.normal,
                                            color: bgDarkColor,
                                            fontSize: 20)),
                                  ],
                                ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      controller.playSongs(songModel[controller.playIndex.value-1].uri, controller.playIndex.value-1);
                                    },
                                    icon: const Icon(
                                      Icons.skip_previous_rounded,
                                      size: 30,
                                    )),
                                Obx(
                                      () =>
                                      CircleAvatar(
                                          backgroundColor: bgDarkColor,
                                          radius: 35,
                                          child: Transform.scale(
                                              scale: 2.5,
                                              child: IconButton(
                                                  onPressed: () {
                                                    if (controller.isPlaying
                                                        .value) {
                                                      controller.audioPlayer
                                                          .pause();
                                                      controller.isPlaying(false);
                                                    }
                                                    else {
                                                      controller.audioPlayer
                                                          .play();
                                                      controller.isPlaying(true);
                                                    }
                                                  },
                                                  icon: controller.isPlaying.value
                                                      ? Icon(
                                                    Icons.pause_rounded,
                                                    size: 30,
                                                    color: whiteColor,
                                                  )
                                                      : Icon(
                                                    Icons.play_arrow_rounded,
                                                    size: 30, color: whiteColor,
                                                  )))),
                                ),
                                IconButton(
                                    onPressed: () {
                                      controller.playSongs(songModel[controller.playIndex.value+1].uri, controller.playIndex.value+1);
                                    },
                                    icon: const Icon(
                                      Icons.skip_next_rounded,
                                      size: 30,
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
