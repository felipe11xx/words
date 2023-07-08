import 'package:text_to_speech/text_to_speech.dart';

class AppTTS extends TextToSpeech {

  speakEN(String word){
    setLanguage('en-US');
    speak(word);
  }

}