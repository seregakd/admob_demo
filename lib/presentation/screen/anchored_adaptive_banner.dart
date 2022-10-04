import 'package:admob_demo/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AnchoredAdaptiveBanner extends StatefulWidget {
  const AnchoredAdaptiveBanner({super.key});

  @override
  State<AnchoredAdaptiveBanner> createState() => _AnchoredAdaptiveBannerState();
}

class _AnchoredAdaptiveBannerState extends State<AnchoredAdaptiveBanner> {
  BannerAd? _anchoredAdaptiveAd;
  bool _isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAd();
  }

  @override
  void dispose() {
    super.dispose();
    _anchoredAdaptiveAd?.dispose();
  }

  Future<void> _loadAd() async {
    await _anchoredAdaptiveAd?.dispose();
    setState(() {
      _anchoredAdaptiveAd = null;
      _isLoaded = false;
    });

    if (!mounted) return;

    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
      MediaQuery.of(context).size.width.truncate(),
    );

    if (size == null) {
      print('Unable to get height of anchored banner.');
      return;
    }

    _anchoredAdaptiveAd = BannerAd(
      adUnitId: Constants.bannerAdUnitId,
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$ad loaded: ${ad.responseInfo}');
          setState(() {
            _anchoredAdaptiveAd = ad as BannerAd;
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Anchored adaptive banner failedToLoad: $error');
          ad.dispose();
        },
      ),
    );
    return _anchoredAdaptiveAd!.load();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Anchored adaptive banner'),
        ),
        body: Center(
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: <Widget>[
              ListView.separated(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                  bottom: (_anchoredAdaptiveAd?.size.height.toDouble() ?? 0) + 16,
                ),
                itemBuilder: (context, index) {
                  return const Text(
                    Constants.placeholderText,
                    style: TextStyle(fontSize: 24),
                  );
                },
                separatorBuilder: (context, index) {
                  return Container(height: 20);
                },
                itemCount: 5,
              ),
              if (_anchoredAdaptiveAd != null && _isLoaded)
                SizedBox(
                  width: _anchoredAdaptiveAd!.size.width.toDouble(),
                  height: _anchoredAdaptiveAd!.size.height.toDouble(),
                  child: AdWidget(ad: _anchoredAdaptiveAd!),
                ),
            ],
          ),
        ),
      );
}
