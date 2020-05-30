import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:signature/signature.dart';

class TextEditor extends StatefulWidget {
  @override
  _TextEditorState createState() => _TextEditorState();
}

class _TextEditorState extends State<TextEditor> {
  Color pickerC = Color(0xff443a49);

  static const languages = <String>["English", "العربية", "Tamazight"];

  List<Fonts> english = [];
  List<Fonts> arabic = [];
  List<Fonts> tamazight = [];

  String font = "RobotoMono";
  String text;
  @override
  void initState() {
    name.text = "";
    _updateLangue(_selectedItem);
    _updateFont(font);
    english.add(Fonts("English", "RobotoMono"));
    english.add(Fonts("English", "Raleway"));

    arabic.add(Fonts("العربية", "RobotoMono"));
    arabic.add(Fonts("العربية", "Questv1"));

    tamazight.add(Fonts("ⵜⴰⵎⴰⵣⵉⵖⵜ", "Tifinaghe"));
    tamazight.add(Fonts("ⵜⴰⵎⴰⵣⵉⵖⵜ", "Anaruz"));
    super.initState();
  }


  bool visible = false;

  Color currentC = Color(0xff443a49);
  Color currentcolors = Colors.white;
  var opicity = 0.0;
  SignatureController _controller =
      SignatureController(penStrokeWidth: 5, penColor: Colors.green);
// ValueChanged<Color> callback
  void changeC(Color color) {
    setState(() => pickerC = color);
    var points = _controller.points;
    _controller =
        SignatureController(penStrokeWidth: 5, penColor: color, points: points);
  }

  String _selectedItem = "English";

  _updateFont(String name) {
    setState(() {
      font = name;
    });
  }

  _updateLangue(String name) {
    setState(() {
      _selectedItem = name;
      switch (_selectedItem) {
        case "English":
          item = english;
          font = "RobotoMono";

          break;
        case "العربية":
          item = arabic;
          font = "RobotoMono";
          break;
        case "Tamazight":
          item = tamazight;
          font = "Tifinaghe";
          break;
        default:
          item = english;
      }
    });
  }

  String searchData = "";
  List<Fonts> item;

  TextEditingController name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        backgroundColor: Colors.black,
        actions: <Widget>[
          new IconButton(
              icon: Icon(FontAwesomeIcons.alignLeft), onPressed: () {}),
          new IconButton(
              icon: Icon(FontAwesomeIcons.alignCenter), onPressed: () {}),
          new IconButton(
              icon: Icon(FontAwesomeIcons.alignRight), onPressed: () {}),
          new IconButton(
              icon: Icon(FontAwesomeIcons.paintBrush),
              onPressed: () {
                showDialog(
                    context: context,
                    child: AlertDialog(
                      title: const Text('Pick a color!'),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: pickerC,
                          onColorChanged: changeC,
                          showLabel: true,
                          pickerAreaHeightPercent: 0.8,
                        ),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: const Text('Got it'),
                          onPressed: () {
                            setState(() => currentC = pickerC);
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ));
              }),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                child: Center(
                  child: DropdownButton<String>(
                    hint: Align(
                        alignment: Alignment.center,
                        child: Text("Select Language",
                            style: TextStyle(
                                color: Colors.white, fontSize: 18.0))),
                    items: languages.map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, textAlign: TextAlign.center),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        font = null;
                        _updateLangue(value);
                        visible = true;
                      });
                    },
                    value: _selectedItem,
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            new DropdownButton<String>(
              items: item.map((font) {
                return new DropdownMenuItem<String>(
                  value: font.f,
                  child: SizedBox(
                    width: 100.0, // for example
                    child: Text(font.language,
                        style: TextStyle(
                          fontFamily: font.f,
                        ),
                        textAlign: TextAlign.center),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _updateFont(value);
                });
              },
              value: font,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              searchData,
              style: TextStyle(
                  color: Colors.black, fontFamily: font, fontSize: 40),
            ),
            Divider(
              height: 1,
            ),
            SizedBox(
              height: 40,
            ),
            TextField(
              controller: name,
              decoration: InputDecoration(
                hintText: "Insert your message",
                hintStyle: TextStyle(color: Colors.black),
                alignLabelWithHint: true,
              ),
              onChanged: (v) => setState(() {
                searchData = v;
              }),
              style: TextStyle(
                color: pickerC,
              ),
              autofocus: true,
            ),
          ],
        ),
      ),
      bottomNavigationBar: new Container(
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: new FlatButton(
            onPressed: () {
              Navigator.of(context)
                  .pop({"a": name.text, "b": pickerC, "c": font});
            },
            color: Colors.black,
            padding: EdgeInsets.all(15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: new Text(
              "Add Text",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.white),
            )),
      ),
    );
  }
}

class Fonts {
  String language;
  String f;

  Fonts(
    this.language,
    this.f,
  );
}
