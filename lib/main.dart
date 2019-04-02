import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Simple Interest Calculator App",
    home: SIForm(),
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.indigo,
      accentColor: Colors.indigo,
    ),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  var _formKey = GlobalKey<FormState>();
  var _currencies = ["Rupees", "Dollars", "Pounds"];
  final _miniumPadding = 5.0;
  var _currentItemSelected = "";
  @override
  void initState(){
    super.initState();
    _currentItemSelected = _currencies[0];
  }
  TextEditingController principalControlled = TextEditingController();
  TextEditingController roiControlled = TextEditingController();
  TextEditingController termControlled = TextEditingController();
  var displayResult = "";
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
//      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Simple Interest Calculator"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(_miniumPadding * 2),
          child: ListView(
            children: <Widget>[
              getImageAsset(),
              Padding(
                padding:
                EdgeInsets.only(top: _miniumPadding, bottom: _miniumPadding),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: principalControlled,
                  validator: (String value){
                    if(value.isEmpty){
                      return "Please enter principal amount";
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Principal",
                      hintText: "Enter Principal e.g 12000",
                      labelStyle: textStyle,
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 15.0,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              Padding(
                padding:
                EdgeInsets.only(top: _miniumPadding, bottom: _miniumPadding),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: roiControlled,
                  validator: (String value){
                    if(value.isEmpty){
                      return "Please enter Rate of Interest";
                    }
                    if(double.parse(value) > 10){
                      return "Please enter Rate of Interest not over 10";
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Rate of Interest",
                      hintText: "In percent",
                      labelStyle: textStyle,
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 15.0,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: _miniumPadding, bottom: _miniumPadding),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: textStyle,
                          controller: termControlled,
                          validator: (String value){
                            if(value.isEmpty){
                              return "Please enter Rate of Interest";
                            }
                          },
                          decoration: InputDecoration(
                              labelStyle: textStyle,
                              labelText: "Term",
                              hintText: "Time in years",
                              errorStyle: TextStyle(
                                color: Colors.yellowAccent,
                                fontSize: 15.0,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        ),
                      ),
                      Container(
                        width: _miniumPadding * 5,
                      ),
                      Expanded(
                          child: DropdownButton<String>(
                            items: _currencies.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            value: _currentItemSelected,
                            onChanged: (String newValuesSelected) {
                              _onDropDownItemSelected(newValuesSelected);
                            },
                          ))
                    ],
                  )),
              Padding(
                padding:
                EdgeInsets.only(top: _miniumPadding, bottom: _miniumPadding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        onPressed: () {
                          setState(() {
                            if(_formKey.currentState.validate()){
                              this.displayResult = _calculateTotalReturns();
                            }
                          });
                        },
                        color: Theme.of(context).accentColor,
                        textColor: Theme.of(context).primaryColorDark,
                        child: Text("Calculate", textScaleFactor: 1.5,),
                      ),
                    ),
                    Expanded(
                      child: RaisedButton(
                        onPressed: () {
                          setState(() {
                            _reset();
                          });
                        },
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text("Reset", textScaleFactor: 1.5,),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: _miniumPadding, bottom: _miniumPadding),
                  child: Text(this.displayResult, style: textStyle))
            ],
          ),
        )
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/logo.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(_miniumPadding * 10),
    );
  }
  void _onDropDownItemSelected(String newValuesSelected) {
    setState(() {
      this._currentItemSelected = newValuesSelected;
    });
  }
  String _calculateTotalReturns(){
    double principal = double.parse(principalControlled.text) ;
    double roi = double.parse(roiControlled.text) ;
    double term = double.parse(termControlled.text) ;

    double _totalAmountPayable = principal + (principal * roi * term) /100;
    String result = "After $term years, your investment will be worth $_totalAmountPayable $_currentItemSelected";
    return result;
  }
  void _reset() {
    principalControlled.text = "";
    roiControlled.text = "";
    termControlled.text = "";
    displayResult = "";
    _currentItemSelected = _currencies[0];
  }
}


