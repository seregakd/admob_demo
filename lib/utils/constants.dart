import 'dart:io';

class Constants {

  static String get bannerAdUnitId {
    return Platform.isAndroid
        ? 'ca-app-pub-3940256099942544/6300978111'
        : 'ca-app-pub-3940256099942544/2934735716';
  }

  static String get interstitialAdUnitId {
    return Platform.isAndroid
        ? 'ca-app-pub-3940256099942544/1033173712'
        : 'ca-app-pub-3940256099942544/4411468910';
  }

  static String get interstitialVideoAdUnitId {
    return Platform.isAndroid
        ? 'ca-app-pub-3940256099942544/8691691433'
        : 'ca-app-pub-3940256099942544/5135589807';
  }

  static String get rewardedAdUnitId {
    return Platform.isAndroid
        ? 'ca-app-pub-3940256099942544/5224354917'
        : 'ca-app-pub-3940256099942544/1712485313';
  }

  static String get rewardedInterstitialAdUnitId {
    return Platform.isAndroid
        ? 'ca-app-pub-3940256099942544/5354046379'
        : 'ca-app-pub-3940256099942544/6978759866';
  }

  static const String adMobAdaptiveBanner ='ca-app-pub-3940256099942544/9214589741';

  static const String placeholderText =
      'Two households, both alike in dignity,'
      'In fair Verona, where we lay our scene,'
      'From ancient grudge break to new mutiny,'
      'Where civil blood makes civil hands unclean.'
      'From forth the fatal loins of these two foes';
}