import 'package:admob_demo/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'anchored_adaptive_banner.dart';
import 'banner_ads.dart';
import 'fluid_banner.dart';
import 'inline_adaptive_banner.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  static const double _buttonPadding = 16;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  static const AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  static const int maxFailedLoadAttempts = 3;

  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;

  InterstitialAd? _interstitialVideoAd;
  int _numInterstitialVideoLoadAttempts = 0;

  RewardedAd? _rewardedAd;
  int _numRewardedLoadAttempts = 0;

  RewardedInterstitialAd? _rewardedInterstitialAd;
  int _numRewardedInterstitialLoadAttempts = 0;

  @override
  void initState() {
    super.initState();
    _createInterstitialAd();
    _createInterstitialVideoAd();
    _createRewardedAd();
    _createRewardedInterstitialAd();
  }

  @override
  void dispose() {
    super.dispose();
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
    _rewardedInterstitialAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: DashboardScreen._buttonPadding,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BannerAds(),
                      ),
                    );
                  },
                  child: const Text('Banner'),
                ),
                const SizedBox(
                  height: DashboardScreen._buttonPadding,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AnchoredAdaptiveBanner(),
                      ),
                    );
                  },
                  child: const Text('Anchored adaptive banner'),
                ),
                const SizedBox(
                  height: DashboardScreen._buttonPadding,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const InlineAdaptiveBanner(),
                      ),
                    );
                  },
                  child: const Text('Inline adaptive banner'),
                ),
                const SizedBox(
                  height: DashboardScreen._buttonPadding,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FluidBanner(),
                      ),
                    );
                  },
                  child: const Text('Fluid banner'),
                ),
                const SizedBox(
                  height: DashboardScreen._buttonPadding * 3,
                ),
                TextButton(
                  onPressed: () => _showInterstitialAd(),
                  child: const Text('Interstitial'),
                ),
                const SizedBox(
                  height: DashboardScreen._buttonPadding,
                ),
                TextButton(
                  onPressed: () => _showInterstitialVideoAd(),
                  child: const Text('Interstitial video'),
                ),
                const SizedBox(
                  height: DashboardScreen._buttonPadding * 3,
                ),
                TextButton(
                  onPressed: () => _showRewardedAd(),
                  child: const Text('Rewarded'),
                ),
                const SizedBox(
                  height: DashboardScreen._buttonPadding,
                ),
                TextButton(
                  onPressed: () => _showRewardedInterstitialAd(),
                  child: const Text('Rewarded Interstitial'),
                ),
                const SizedBox(
                  height: DashboardScreen._buttonPadding,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: Constants.interstitialAdUnitId,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
              _createInterstitialAd();
            }
          },
        ));
  }

  void _createInterstitialVideoAd() {
    InterstitialAd.load(
        adUnitId: Constants.interstitialVideoAdUnitId,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialVideoAd = ad;
            _numInterstitialVideoLoadAttempts = 0;
            _interstitialVideoAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialVideoLoadAttempts += 1;
            _interstitialVideoAd = null;
            if (_numInterstitialVideoLoadAttempts < maxFailedLoadAttempts) {
              _createInterstitialVideoAd();
            }
          },
        ));
  }

  void _createRewardedAd() {
    RewardedAd.load(
        adUnitId: Constants.rewardedAdUnitId,
        request: request,
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad loaded.');
            _rewardedAd = ad;
            _numRewardedLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
            _rewardedAd = null;
            _numRewardedLoadAttempts += 1;
            if (_numRewardedLoadAttempts < maxFailedLoadAttempts) {
              _createRewardedAd();
            }
          },
        ));
  }

  void _createRewardedInterstitialAd() {
    RewardedInterstitialAd.load(
        adUnitId: Constants.rewardedInterstitialAdUnitId,
        request: request,
        rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
          onAdLoaded: (RewardedInterstitialAd ad) {
            print('$ad loaded.');
            _rewardedInterstitialAd = ad;
            _numRewardedInterstitialLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedInterstitialAd failed to load: $error');
            _rewardedInterstitialAd = null;
            _numRewardedInterstitialLoadAttempts += 1;
            if (_numRewardedInterstitialLoadAttempts < maxFailedLoadAttempts) {
              _createRewardedInterstitialAd();
            }
          },
        ));
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  void _showInterstitialVideoAd() {
    if (_interstitialVideoAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialVideoAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialVideoAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialVideoAd();
      },
    );
    _interstitialVideoAd!.show();
    _interstitialVideoAd = null;
  }

  void _showRewardedAd() {
    if (_rewardedAd == null) {
      print('Warning: attempt to show rewarded before loaded.');
      return;
    }
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedAd();
      },
    );

    _rewardedAd!.setImmersiveMode(true);
    _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
        });
    _rewardedAd = null;
  }

  void _showRewardedInterstitialAd() {
    if (_rewardedInterstitialAd == null) {
      print('Warning: attempt to show rewarded interstitial before loaded.');
      return;
    }
    _rewardedInterstitialAd!.fullScreenContentCallback =
        FullScreenContentCallback(
          onAdShowedFullScreenContent: (RewardedInterstitialAd ad) =>
              print('$ad onAdShowedFullScreenContent.'),
          onAdDismissedFullScreenContent: (RewardedInterstitialAd ad) {
            print('$ad onAdDismissedFullScreenContent.');
            ad.dispose();
            _createRewardedInterstitialAd();
          },
          onAdFailedToShowFullScreenContent:
              (RewardedInterstitialAd ad, AdError error) {
            print('$ad onAdFailedToShowFullScreenContent: $error');
            ad.dispose();
            _createRewardedInterstitialAd();
          },
        );

    _rewardedInterstitialAd!.setImmersiveMode(true);
    _rewardedInterstitialAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
        });
    _rewardedInterstitialAd = null;
  }

}
