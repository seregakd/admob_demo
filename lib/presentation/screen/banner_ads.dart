import 'package:admob_demo/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAds extends StatefulWidget {
  const BannerAds({super.key});

  @override
  State<BannerAds> createState() => _BannerAdsState();
}

class _BannerAdsState extends State<BannerAds> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAd();
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd?.dispose();
  }

  Future<void> _loadAd() async {
    await _bannerAd?.dispose();
    setState(() {
      _bannerAd = null;
      _isLoaded = false;
    });

    _bannerAd = BannerAd(
      adUnitId: Constants.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$ad loaded: ${ad.responseInfo}');
          setState(() {
            _bannerAd = ad as BannerAd;
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Anchored adaptive banner failedToLoad: $error');
          ad.dispose();
        },
      ),
    );
    return _bannerAd!.load();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Banner'),
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
                  bottom: (_bannerAd?.size.height.toDouble() ?? 0) + 16,
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
                itemCount: 7,
              ),
              if (_bannerAd != null && _isLoaded)
                SizedBox(
                  width: _bannerAd!.size.width.toDouble(),
                  height: _bannerAd!.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAd!),
                ),
            ],
          ),
        ),
      );
}
