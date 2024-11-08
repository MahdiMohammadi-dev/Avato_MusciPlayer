import 'package:avato/constant/app_colors.dart';
import 'package:avato/controllers/player_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query_forked/on_audio_query.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put<PlayerController>(PlayerController());

    return Scaffold(
        backgroundColor: bgDarkColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: bgDarkColor,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: whiteColor,
                )),
          ],
          leading: const Icon(
            Icons.sort_rounded,
            color: whiteColor,
          ),
          title: Text('Avato Player',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  color: whiteColor)),
        ),
        body: FutureBuilder<List<SongModel>>(
            future: controller.audioQuery.querySongs(
              ignoreCase: false,
              orderType: OrderType.ASC_OR_SMALLER,
              sortType: null,
              uriType: UriType.EXTERNAL,
            ),
            builder: (context, snapshot) {
              print(snapshot.data);

              if (snapshot.data == null || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('No Songs Found',
                      style: TextStyle(color: whiteColor)),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(()=>
                            ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            tileColor: bgColor,
                            title: Text(
                              snapshot.data![index].displayNameWOExt,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 15,
                                  color: whiteColor),
                            ),
                            subtitle: Text(
                                snapshot.data![index].artist ?? 'Unknown Artist',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.normal,
                                    color: whiteColor)),
                            leading: QueryArtworkWidget(
                                id: snapshot.data![index].id,
                                artworkBorder: BorderRadius.circular(12),

                                type: ArtworkType.AUDIO,
                                nullArtworkWidget: const Icon(Icons.music_note,
                                    color: whiteColor, size: 32)),
                            trailing:
                            controller.playIndex.value == index &&controller.isPlaying.value ?
                            const Icon(
                              Icons.play_arrow,
                              color: whiteColor,
                              size: 26,
                            ):null,
                            onTap: () {
                              controller.playSongs(snapshot.data![index].uri,index);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            }));
  }
}
