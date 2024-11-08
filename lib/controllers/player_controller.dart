import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query_forked/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayerController extends GetxController{

    final audioQuery = OnAudioQuery();
    final audioPlayer = AudioPlayer();
    var  playIndex=0.obs;
    var isPlaying = false.obs;
    var musicDuration  =''.obs;
    var musicPosition  =''.obs;
    var max = 0.0.obs;
    var value = 0.0.obs;


    @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkpermission();
  }

  updatePosition() {
   audioPlayer.durationStream.listen((event) {
     musicDuration.value = event.toString().split(".")[0];
     max.value = event!.inSeconds.toDouble();
   },);
   audioPlayer.positionStream.listen((event) {
     musicPosition.value = event.toString().split(".")[0];
     value.value = event.inSeconds.toDouble();
   },);
  }

  changeDurationToSeconds(seconds){
      var duration = Duration(seconds: seconds);
      audioPlayer.seek(duration);
  }

  playSongs(String? songUrl,index) async {
      playIndex.value = index;
      audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(songUrl!)));
      await audioPlayer.play();
      isPlaying(true);
      updatePosition();
  }

   checkpermission() async{

      var peimission = await Permission.storage.request();
      if(peimission.isGranted){
      }else{
        return checkpermission();
      }


   }



}