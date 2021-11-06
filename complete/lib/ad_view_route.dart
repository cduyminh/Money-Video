// Copyright 2021 RM LLC
//
// Licensed under the F Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
import 'package:flutter/material.dart';

// COMPLETE: Import google_mobile_ads.dart
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'ad_helper.dart';

class ADVIEWROUTE extends StatefulWidget {
  @override
  // TODO: implement createState
  _AdViewRouteState createState() => _AdViewRouteState();
}
  // COMPLETE: Add _isRewardedAdReady

  class _AdViewRouteState extends State<ADVIEWROUTE>
  with TickerProviderStateMixin {
  // COMPLETE: Add _adsCounter
  int _adsCounter = 0;

  // COMPLETE: Add _rewardedAd
  RewardedAd? _rewardedAd;

  bool _isRewardedAdReady = false;

  bool _haventWatched = true;

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute
        .of(context)!
        .settings
        .arguments as Map;

    if (arguments != null) debugPrint(arguments['exampleArgument']);
    // Completed: implement build
    return _myLoadRewardedAd();
  }

  Widget _myLoadRewardedAd() {
    if (_isRewardedAdReady) {
      setState(() {
        _haventWatched = !_haventWatched;
      });
      return _clickToWatchAd();
    }
    if (_haventWatched) {
      _loadRewardedAd();
      return _waitingForAdScreen();
    } else {
      return _afterAdScreen();
    }
}

// COMPLETE: Implement _loadRewardedAd()
void _loadRewardedAd() {
  RewardedAd.load(
    adUnitId: AdHelper.rewardedAdUnitId,
    request: AdRequest(),
    rewardedAdLoadCallback: RewardedAdLoadCallback(
      onAdLoaded: (ad) {
        this._rewardedAd = ad;

        ad.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: (ad) {
            setState(() {
              _isRewardedAdReady = false;
              _adsCounter++;
            });
          },
        );

        setState(() {
          _isRewardedAdReady = true;
        });
      },
      onAdFailedToLoad: (err) {
        print('Failed to load a rewarded ad: ${err.message}');
        setState(() {
          _isRewardedAdReady = false;
        });
      },
    ),
  );
}

Column _afterAdScreen() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      TextButton(
          onPressed: () {
            setState(() {
              _haventWatched = true;
            });
            if (_haventWatched) _loadRewardedAd();
          },
          child: Text('> Continue watching ads'.toUpperCase())),
      TextButton(
        child: Text("You've watched $_adsCounter ads".toUpperCase()),
        onPressed: () {},
      ),
      TextButton(
        child: Text(
            "> Claim \$${_adsCounter * 1 / 100} and stop".toUpperCase()),
        onPressed: () {
          Navigator.of(context)
              .pushNamed('/admoney', arguments: {'amount': _adsCounter});
        },
      ),
    ],
  );
}

TextButton _clickToWatchAd() {
  return TextButton(
      child:
      Text("> Good, we've found ad No.${_adsCounter + 1} !".toUpperCase()),
      onPressed: () {
        _rewardedAd?.show(
          onUserEarnedReward: (_, reward) {},
        );
      });
}

Column _waitingForAdScreen() {
  return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(
          child: Text("We're looking up an ad for you".toUpperCase()),
          onPressed: () {},
        ),
        TextButton(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RotatingDot().elementAt(0),
              RotatingDot().elementAt(1),
              RotatingDot().elementAt(2),
            ],
          ),
          onPressed: () {},
        ),
      ]);
}

List<AnimatedBuilder> RotatingDot() {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 20),
    vsync: this,
  )
    ..repeat();
  final animation =
  Tween<double>(begin: 0, end: 90).animate(_controller);
  return [
    AnimatedBuilder(
        animation: animation,
        child: Text(".".toUpperCase()),
        builder: (BuildContext context, Widget? child) {
          return Transform.rotate(
            angle: animation.value,
            child: child,
          );
        }),
    AnimatedBuilder(
        animation: animation,
        child: Text(".".toUpperCase()),
        builder: (BuildContext context, Widget? child) {
          return Transform.rotate(
            angle: animation.value - 100,
            child: child,
          );
        }),
    AnimatedBuilder(
        animation: animation,
        child: Text(".".toUpperCase()),
        builder: (BuildContext context, Widget? child) {
          return Transform.rotate(
            angle: animation.value - 200,
            child: child,
          );
        }),
  ];
}

@override
void dispose() {
  // COMPLETE: Dispose a RewardedAd object
  _rewardedAd?.dispose();

  super.dispose();
}}
