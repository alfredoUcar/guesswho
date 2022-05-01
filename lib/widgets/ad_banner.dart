import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:guesswho/states/config.dart';
import 'package:provider/provider.dart';

class AdBanner extends StatefulWidget {
  final String adNameKey;

  const AdBanner({
    Key? key,
    required this.adNameKey,
  }) : super(key: key);

  @override
  State<AdBanner> createState() => _AdBannerState();
}

class _AdBannerState extends State<AdBanner> {
  BannerAd? banner;
  bool bannerAvailable = false;

  loadBanner(String id) {
    banner = BannerAd(
      size: AdSize.banner,
      adUnitId: id,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            bannerAvailable = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          FirebaseCrashlytics.instance.recordError(error, StackTrace.current);
          ad.dispose();
          setState(() {
            bannerAvailable = false;
          });
        },
      ),
      request: const AdRequest(),
    );

    banner!.load();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Config>(builder: (context, config, child) {
      if (!config.loaded || !config.data.containsKey(widget.adNameKey)) {
        return Container();
      }

      if (banner == null) {
        loadBanner(config.data[widget.adNameKey]);
        return Container();
      }

      if (!bannerAvailable) {
        return Container();
      }

      return Container(
        alignment: Alignment.center,
        height: (banner!.size.height + 20).toDouble(),
        width: banner!.size.width.toDouble(),
        child: AdWidget(key: const Key('banner'), ad: banner as BannerAd),
      );
    });
  }
}
