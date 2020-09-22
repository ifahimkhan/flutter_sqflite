import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_sqflite/screens/json_api_screen.dart';
import 'package:flutter_app_sqflite/screens/note_list.dart';
import 'package:flutter_app_sqflite/utils/preferences.dart';
import 'package:intl/intl.dart';

class IphoneStateFull extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Iphone();
  }
}

class Iphone extends State<IphoneStateFull> {
  var _lights = true;
  var _groupValue = 0;
  double _progress = 2.0;
  DateTime _dateTime;

  int selectedValue = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: true,
      navigationBar: CupertinoNavigationBar(
        trailing: GestureDetector(
            child: Text('More'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return IphoneTabScaffold();
              }));
            }),
        leading: CupertinoNavigationBarBackButton(
          previousPageTitle: 'Notes',
          onPressed: () {
            navigate(context);
            /*final result = await
            Navigator.push(
                context, CupertinoPageRoute(builder: (context) => NoteList(),));
           */ /*_showCupertinoAlertDialog(
                "Iphone dialog", "this subtitle show iphone dialog content");*/
          },
        ),
        middle: const Text('Sample'),
      ),
      child: SafeArea(
        child: Container(
          margin: EdgeInsets.all(16.0),
          child: Container(
            child: ListView(
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: CupertinoButton(
                          child: Text('Button'),
                          onPressed: () {
                            setState(() {
                              _showSnackBar(context, "Button is pressed");
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: CupertinoButton.filled(
                          child: Text('Button'),
                          onPressed: () {
                            setState(() {
                              _showSnackBar(
                                  context, "Button filled is pressed");
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => PhotoApi(),
                                  ));
                            });
                          },
                        ),
                      ),
                    ]),
                SizedBox(
                  height: 10.0,
                ),
                Material(
                  child: MergeSemantics(
                    child: ListTile(
                      title: Text('Lights'),
                      trailing: CupertinoSwitch(
                        value: _lights,
                        onChanged: (bool value) {
                          setState(() {
                            _lights = value;
                            print("value $value");
                          });
                        },
                      ),
                      onTap: () {
                        setState(() {
                          _showSnackBar(context, "switched turned $_lights");

                          _lights = !_lights;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                CupertinoSegmentedControl(
                  children: <int, Widget>{
                    0: Text('Section 1'),
                    1: Text('Section 2'),
                    2: Text('Section 3'),
                  },
                  groupValue: _groupValue,
                  selectedColor: CupertinoColors.activeBlue,
                  onValueChanged: (T) {
                    print(T);
                    setState(() {
                      _groupValue = T;
                    });
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                CupertinoSlider(
                  value: _progress.toDouble(),
                  min: 1.0,
                  max: 10.0,
                  divisions: 10,
                  onChanged: (double newValue) {
                    setState(() {
                      _progress = newValue.round().toDouble();
                    });
                  },
                  activeColor: CupertinoColors.activeBlue,
                  onChangeStart: (value) => _progress = value,
                  onChangeEnd: (value) => _progress = value,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 200.0,
                  child: CupertinoDatePicker(
                    initialDateTime: DateTime.now(),
                    onDateTimeChanged: (value) {
                      setState(() {
                        _dateTime = value;
                        print(DateFormat.yMMMd().format(_dateTime));
                      });
                    },
                    use24hFormat: false,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 200.0,
                  child: CupertinoTimerPicker(
                    initialTimerDuration: Duration.zero,
                    onTimerDurationChanged: (value) {
                      setState(() {
                        print(value);
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                CupertinoButton.filled(
                    child: Text("Bottom sheet Button"),
                    onPressed: () => showPicker()),
                SizedBox(
                  height: 10.0,
                ),
                MyPrefilledText(),
                SizedBox(
                  height: 10.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showCupertinoAlertDialog(String title, String message) {
    CupertinoAlertDialog alertDialog = CupertinoAlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        CupertinoDialogAction(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop("OK");
            _showSnackBar(context, "Ok is pressed");
          },
          isDefaultAction: true,
        ),
        CupertinoDialogAction(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop("Cancel");
            _showSnackBar(context, "Cancel is pressed");
          },
          isDestructiveAction: true,
        )
      ],
    );
    showDialog(context: context, child: alertDialog);
  }

  showPicker() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return CupertinoPicker(
            backgroundColor: Colors.white,
            onSelectedItemChanged: (value) {
              setState(() {
                selectedValue = value;
              });
            },
            itemExtent: 32.0,
            children: const [
              Text('Item01'),
              Text('Item02'),
              Text('Item03'),
            ],
          );
        });
  }

  void navigate(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteList()),
    );
    if (result == null) {
      setState(() {});
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }
}

class MyPrefilledText extends StatefulWidget {
  @override
  _MyPrefilledTextState createState() => _MyPrefilledTextState();
}

class _MyPrefilledTextState extends State<MyPrefilledText> {
  TextEditingController _textController;
  Preferences preferences = new Preferences();

  @override
  void initState() {
    super.initState();
    print("init state is called");
    _textController = TextEditingController();
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    preferences.getNoteTitle().then((value) => _textController.text = value);

    return CupertinoTextField(
      controller: _textController,
      placeholder: "Enter your Name:",
      onSubmitted: (value) {
        if (value.isEmpty) {
          _showSnackBar(context, "Field can't be blank");
        } else {
          _showSnackBar(context, "Hello $value");
        }
      },
    );
  }
}

class IphoneTabScaffold extends StatefulWidget {
  @override
  _IphoneTabScaffoldState createState() => _IphoneTabScaffoldState();
}

class _IphoneTabScaffoldState extends State<IphoneTabScaffold> {
  Preferences preferences = new Preferences();

  String title;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    preferences.getNoteTitle().then((value) => title = value);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
        home: CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.book_solid),
            title: Text('Articles'),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.eye_solid),
            title: Text('views'),
          ),
        ],
      ),
      tabBuilder: (context, index) => CupertinoTabView(
        builder: (context) => CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: (index == 0) ? Text('Articles') : Text('Views'),
          ),
          child: Center(
            child: CupertinoButton(
              onPressed: () {
                Navigator.push(context, CupertinoPageRoute(
                  builder: (context) {
                    return DetailScreen(index == 0 ? 'Articles' : "Views");
                  },
                ));
              },
              child: Text(
                'This is Tab $index $title',
                style: CupertinoTheme.of(context)
                    .textTheme
                    .actionTextStyle
                    .copyWith(fontSize: 32),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}

class DetailScreen extends StatefulWidget {
  const DetailScreen(this.topic);

  final String topic;

  @override
  _DetailScreenState createState() => _DetailScreenState(topic);
}

class _DetailScreenState extends State<DetailScreen> {
  var _booleanSwitchValue = false;
  String topic;

  _DetailScreenState(this.topic);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Details for $topic'),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(child: Text('A switch')),
                    CupertinoSwitch(
                      value: _booleanSwitchValue,
                      onChanged: (value) {
                        setState(() {
                          _booleanSwitchValue = value;
                        });
                      },
                    )
                  ],
                ),
                CupertinoButton(
                  child: Text('Launch action sheet'),
                  onPressed: () => showCupertinoModalPopup<int>(
                      context: context,
                      builder: (context) {
                        return CupertinoActionSheet(
                          title: Text('Some choices!'),
                          actions: [
                            CupertinoActionSheetAction(
                              child: Text('one'),
                              onPressed: () => Navigator.pop(context, 1),
                              isDefaultAction: true,
                            ),
                            CupertinoActionSheetAction(
                              child: Text('two'),
                              onPressed: () => Navigator.pop(context, 2),
                            ),
                            CupertinoActionSheetAction(
                              child: Text('three'),
                              onPressed: () => Navigator.pop(context, 3),
                            )
                          ],
                        );
                      }),
                )
              ],
            ),
          ),
        ));
  }
}
