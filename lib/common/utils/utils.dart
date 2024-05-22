List<String> listLibrary() => [
      'Riverpod',
      'bottom_picker',
      'en_vi_dic',
      'http',
      'flutter_otp_text_field',
      'percent_indicator',
      'fl_chart',
      'shared_preferences',
      'flutter_spinkit',
      'audioplayers',
      'just_audio',
      'intl',
      'image_picker',
      'permission_handler',
      'cached_network_image',
      'http_parser',
      'youtube_player_flutter',
      'stomp_dart_client',
      'flutter_tts',
      'speech_to_text',
      'circular_countdown_timer'
    ];

const Map<String, String> httpHeaders = {
  'Content-Type': 'application/json; charset=UTF-8',
  'Accept': '*/*',
  'Connection': 'keep-alive',
  'Accept-Encoding': 'gzip, deflate, br',
};

class TypeQuestion {
  static const String multipleChoice = 'Multiple choice';
  static const String fillInBlank = 'Fill in the blank';
  static const String sentenceUnscramble = 'Sentence unscramble';
  static const String sentenceTransformation = 'Sentence transformation';
  static const String listening = 'Listening';
  static const String speaking = 'Speaking';
  static const String exam = 'Exam';
}
