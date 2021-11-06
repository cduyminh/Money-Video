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
import 'package:qr_flutter/qr_flutter.dart';

class GETADMONEYROUTE extends StatefulWidget {
  @override
  // TODO: implement createState
  _GetAdMoneyRoute createState() => _GetAdMoneyRoute();
}

class _GetAdMoneyRoute extends State<GETADMONEYROUTE> {
  @override
  Widget build(BuildContext context) {

    final _moneyAmount = ModalRoute.of(context)!.settings.arguments as Map;

    final _moneyPayable = _moneyAmount['amount'] * 10 / 100;

    void _moveToHome() {
      Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
    }

    // Completed: implement build
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(child:Text('Scan me to claim \$$_moneyPayable'.toUpperCase()), onPressed: (){},),
          QrImage(
            backgroundColor: Colors.white,
            data: '\$$_moneyPayable',
            size: 300,
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
            child: Text('Return home'.toUpperCase()),
            onPressed: () {
              _moveToHome();
            },
          ),
        ]);
  }
}
