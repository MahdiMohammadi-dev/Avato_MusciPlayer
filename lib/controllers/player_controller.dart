import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query_forked/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayerController extends GetxController{

    final audioQuery = OnAudioQuery();
    final audioPlayer = AudioPlayer();

    var  playIndex=0.obs;
    var isPlaying = false.obs;

    @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkpermission();
  }

  playSongs(String? songurl,index) async {
      playIndex.value = index;
      audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(songurl!)));
      await audioPlayer.play();
      isPlaying(true);
  }

   checkpermission() async{

      var peimission = await Permission.storage.request();
      if(peimission.isGranted){
      }else{
        return checkpermission();
      }


   }



}