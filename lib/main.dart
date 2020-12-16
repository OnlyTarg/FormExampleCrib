import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var photoFieldController = TextEditingController();

  FocusNode lastNameFocusNode = FocusNode();
  FocusNode positionFocusNode = FocusNode();
  FocusNode photoFocusNode = FocusNode();
  String imageURL = '';

  GlobalKey<FormState> form = GlobalKey<FormState>();

  Map<String, String> person = {
    'firstName': '',
    'lastName': '',
    'position': ''
  };

  @override
  void initState() {
    photoFocusNode.addListener(() {
      if (!photoFocusNode.hasFocus) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    photoFieldController.dispose();
    lastNameFocusNode.dispose();
    positionFocusNode.dispose();
    photoFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => _saveForm(),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: form,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'First Name'),
                textInputAction: TextInputAction.next,
                onChanged: (value) => print(value),
                onFieldSubmitted: (value) =>
                    FocusScope.of(context).requestFocus(lastNameFocusNode),
                onSaved: (newValue) => person['firstName'] = newValue,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Last  Name'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) =>
                    FocusScope.of(context).requestFocus(positionFocusNode),
                focusNode: lastNameFocusNode,
                onSaved: (newValue) => person['lastName'] = newValue,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: 'Position'),
                onFieldSubmitted: (value) =>
                    FocusScope.of(context).requestFocus(photoFocusNode),
                focusNode: positionFocusNode,
                onSaved: (newValue) => person['position'] = newValue,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 8, right: 8),
                    decoration: BoxDecoration(border: Border.all(width: 1)),
                    width: 100,
                    height: 100,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: !photoFieldController.text.isEmpty
                          ? Image.network('${photoFieldController.text}')
                          : Container(),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Photo Url'),
                      focusNode: photoFocusNode,
                      onSaved: (newValue) => person['position'] = newValue,
                      controller: photoFieldController,
                      onFieldSubmitted: (_) => _saveForm,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {}, tooltip: 'Increment', child: Icon(Icons.add)),
    );
  }

  void _saveForm() {
    form.currentState.save();
  }
}
