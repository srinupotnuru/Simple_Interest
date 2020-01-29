import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "stateful widget",
    home: MyApp(),
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.indigo,
      accentColor: Colors.indigoAccent,
    ),
  ));
}

class MyApp extends StatefulWidget {
  State<StatefulWidget> createState() {
    return Common();
  }
}

class Common extends State<MyApp> {
  var formkey=GlobalKey<FormState>();
  var currency = ["rupees", "dollars", "euro"];
  var current_val = "rupees";
  TextEditingController prController = new TextEditingController();
  TextEditingController roiController = new TextEditingController();
  TextEditingController termController = new TextEditingController();
  var total = "";
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.subhead;

    debugPrint("created");
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("SIMPLE INTEREST"),
      ),
      body: Form(
        key: formkey,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: ListView(
            children: <Widget>[
              get(),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  controller: prController,
                  style: textStyle,
                validator:(String value){
                 
                  if(value.isEmpty){
                    return  "please enter principal amount!";
                  }
                 

                },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Principal",
                      labelStyle: textStyle,
                      hintText: "enter principal",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  style: textStyle,
                  controller: roiController,
                  validator: (String str){
                    
                    if(str.isEmpty)
                    {
                      return "please enter rate of interest!";
                    }
                    

                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Rate Of interest",
                      labelStyle: textStyle,
                      hintText: "In %age",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: new Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: termController,
                        style: textStyle,
                        validator: (String value){
                          
                          if(value.isEmpty)
                          {
                            return "please enter term !";
                          }
                       
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Term",
                            labelStyle: textStyle,
                            hintText: "In years",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            )),
                      ),
                    ),
                    Container(
                      width: 25.0,
                    ),
                    Expanded(
                      child: new DropdownButton<String>(
                        items: currency.map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (String newval) {
                          ondropdownselected(newval);
                        },
                        value: current_val,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).accentColor,
                        textColor: Theme.of(context).primaryColorDark,
                        child: Text(
                          'calculate',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          if(formkey.currentState.validate() )
                          setState(() {
                            if(formkey.currentState.validate() )
                            {this.total = calcTotal();}
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'reset',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            reset();
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  this.total,
                  style: textStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get() {
    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(20.0),
    );
  }

  void ondropdownselected(String newval) {
    this.current_val = newval;
  }

  String calcTotal() {
    double principal = double.parse(prController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);
    double total = principal + (principal * roi * term) / 100;
    String result =
        "after $term years,your investment willbe worth $total $current_val";

    return result;
  }

  void reset() {
    prController.text = '';
    roiController.text = '';
    termController.text = '';
    current_val = currency[0];
    total = '';
  }
  bool isNumeric(String str) {
  try{
    var value = double.parse(str);
  } on FormatException {
    return false;
  } finally {
    return true;
  }
}
}
