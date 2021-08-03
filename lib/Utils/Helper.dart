

class Helper {

  String parceDuration (Duration duration){

    String twoDigits(int a){



      return a >= 10 ? "$a" : "0$a";  
    }

    final String minutes = twoDigits(duration.inMinutes);
    final String seconds = twoDigits(duration.inSeconds.remainder(60));

    return "$minutes : $seconds";
  }


}