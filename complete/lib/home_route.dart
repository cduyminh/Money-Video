// Copyright 2020 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
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

import 'package:awesome_drawing_quiz/app_theme.dart';
import 'package:flutter/material.dart';

// COMPLETE: Import google_mobile_ads.dart
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initGoogleMobileAds(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                " It Was An Awesome Drawing Quiz!",
                style: TextStyle(
                  fontSize: 32,
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 72),
              ),
              if (snapshot.hasData)
                ElevatedButton(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 52.0,
                      vertical: 12.0,
                    ),
                    child: Text('> Let\'s do a drawing quiz !'),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).accentColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/game');
                  },
                )
              else if (snapshot.hasError)
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                )
              else
                SizedBox(
                  child: CircularProgressIndicator(),
                  width: 48,
                  height: 48,
                ),
              ElevatedButton(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28.0,
                    vertical: 12.0,
                  ),
                  child: Text('> Let\'s make money watching ads !'),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).accentColor,
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/adview',
                    arguments: {'exampleArgument': 'example String'},
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }

  // COMPLETE: Change return type to Future<InitializationStatus>
  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }
}
