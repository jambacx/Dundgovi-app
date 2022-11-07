import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:travel_hour/config/ad_config.dart';

class AdsBloc extends ChangeNotifier {
  int _clickCounter = 0;
  int get clickCounter => _clickCounter;

  bool? _adsEnabled = false;
  bool? get adsEnabled => _adsEnabled;

  bool _isAdLoaded = false;
  bool get isAdLoaded => _isAdLoaded;

  Future<bool?> checkAdsEnable() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection('admin')
        .doc('ads')
        .get()
        .then((DocumentSnapshot snap) {
      bool? _enabled = snap['ads_enabled'];
      _adsEnabled = _enabled;
      notifyListeners();
    }).catchError((e) {
      print('error : $e');
    });
    return _adsEnabled;
  }

  void increaseClickCounter() {
    _clickCounter++;
    debugPrint('Clicks : $_clickCounter');
    notifyListeners();
  }

  //enable only one
  void loadAds() {
    if (_adsEnabled == true) {
      //admob
      //createInterstitialAdFb();      //fb
    }
  }

  //enable only one
  @override
  void dispose() {
    //disposefbInterstitial();      //fb
    super.dispose();
  }

  // Admob Ads -- START --

  // Admob Ads -- END --

  // Fb Ads -- START --

  void showInterstitialAdFb() async {
    if (_adsEnabled == true) {}
  }

  Future disposefbInterstitial() async {
    if (_isAdLoaded == true) {
      _isAdLoaded = false;
      notifyListeners();
    }
  }

  // Fb Ads -- END --
}
