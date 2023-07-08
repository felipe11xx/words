import 'package:text_to_speech/text_to_speech.dart';

class AppTTS extends TextToSpeech {

  speakEN(String word){
    setLanguage('en-US');
    speak(word);
  }

  speakES(String word){
    setLanguage('es-ES');
    speak(word);
  }

  speakPT(String word){
    setLanguage('pt-BR');
    speak(word);
  }

}