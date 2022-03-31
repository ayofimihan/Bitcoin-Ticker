import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String currency = 'AUD';

//ANDROID DROP DOWN BUTTON
  DropdownButton<String> androidDropdownButton() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(child: Text(currency), value: currency);
      dropdownItems.add(newItem);
    }
    return DropdownButton<String>(
        value: currency,
        items: dropdownItems,
        onChanged: (value) {
          setState(() {
            currency = value;
            getData();
          });
        });
  }

  //IOS PICKER BUTTON
  CupertinoPicker iOSPicker() {
    List<Widget> pickerItems = [];
    for (String currency in currenciesList) {
      var newItem = Text(currency);
      pickerItems.add(newItem);
    }
    return CupertinoPicker(
        backgroundColor: Colors.lightBlue,
        itemExtent: 28.0,
        onSelectedItemChanged: (selectedIndex) {
          print(selectedIndex);
          setState(() {
            currency = currenciesList[selectedIndex];
            getData();
          });
        },
        children: pickerItems);
  }

  String coinPrice = '?';

  void getData() async {
    try {
      double data = await CoinData().getHttp(currency);
      setState(() {
        coinPrice = data.toStringAsFixed(0);
      });
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crypto'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              children: [
                CoinWidget(
                  coinPrice: coinPrice,
                  currency: currency,
                  crypto: 'ETH',
                ),
                CoinWidget(
                  coinPrice: coinPrice,
                  currency: currency,
                  crypto: 'BTC',
                ),
                CoinWidget(
                  coinPrice: coinPrice,
                  currency: currency,
                  crypto: 'LTC',
                )
              ],
            ),
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isIOS ? iOSPicker() : androidDropdownButton()),
        ],
      ),
    );
  }
}

class CoinWidget extends StatelessWidget {
  const CoinWidget(
      {Key key,
      @required this.coinPrice,
      @required this.currency,
      @required this.crypto})
      : super(key: key);

  final String coinPrice;
  final String currency;
  final String crypto;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '$crypto price = $coinPrice $currency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
