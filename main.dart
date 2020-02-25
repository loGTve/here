import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'common_widgets/current_location_widget.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

//버튼을 만들고 해당 버튼 클릭시 체크 화면으로...
void main() => runApp(Geolocator());

enum TabItem {
  singleLocation,
  singleFusedLocation,
  locationStream,
  distance,
  geocode
}

class Geolocator extends StatefulWidget {
  @override
  State<Geolocator> createState() => BottomNavigationState();
}

class BottomNavigationState extends State<Geolocator> {
  TabItem _currentItem = TabItem.singleLocation;
  final List<TabItem> _bottomTabs = [
    TabItem.singleLocation,
    if (Platform.isAndroid) TabItem.singleFusedLocation,
    TabItem.locationStream,
    TabItem.distance,
    TabItem.geocode,
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Hello'),
        ),
        body: Center(
          child: FloatingActionButton(onPressed: () {
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => Check_page())
            );
          }),
        ),
      ),
    );
  }


//Show Location
  Widget _buildBody() {
    switch (_currentItem) {
      default:
        return CurrentLocationWidget(androidFusedLocation: false);
    }
  }
}

class Check_page extends StatefulWidget {
  State<Check_page> createState() => new _Check();
}

class _Check extends State<Check_page> {
  String _myActivity;
  String _myActivityResult;
  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _myActivity = '';
    _myActivityResult = '';
  }

  _saveForm() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        _myActivityResult = _myActivity;
      });
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Column(
      key: formKey,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(16),
          child: DropDownFormField(
            titleText: 'My workout',
            hintText: 'Please choose one',
            value: _myActivity,
            onSaved: (value) {
              setState(() {
                _myActivity = value;
              });
            },
            onChanged: (value) {
              setState(() {
                _myActivity = value;
              });
            },
            dataSource: [
              {
                "display": "1명",
                "value": "One",
              },
              {
                "display": "2명",
                "value": "Two",
              },
              {
                "display": "3명",
                "value": "Three",
              },
              {
                "display": "4명",
                "value": "Four",
              },
              {
                "display": "5명",
                "value": "Five",
              },
              {
                "display": "6명",
                "value": "Six",
              },
              {
                "display": "7명",
                "value": "Seven",
              },
              {
                "display": "8명",
                "value": "Eight",
              },
            ],
            textField: 'display',
            valueField: 'value',
          ),
        ),
        Container(
          padding: EdgeInsets.all(8),
          child: RaisedButton(
            child: Text('Save'),
            onPressed: _saveForm,
          ),
        ),
        Container(
          padding: EdgeInsets.all(16),
          child: Text(_myActivityResult),
        )
      ],
    ),
    );
  }
  }