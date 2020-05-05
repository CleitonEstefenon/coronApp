import 'package:flutter/material.dart';

class ImageCheckBox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String checkDescription;

  ImageCheckBox({Key key,
    @required this.value,
    @required this.onChanged,
    @required this.checkDescription
  }) : super(key: key);

  @override
  _ImageCheckBoxState createState() => _ImageCheckBoxState();
}

class _ImageCheckBoxState extends State<ImageCheckBox> {

  int checkedIcon = 0;

  Widget getIcon() {
    if (checkedIcon == 0 ) 
      return Icon(Icons.check_box_outline_blank);
    else 
    return Icon(Icons.check_box);

  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: getIcon(),
          onPressed: () {
            setState(() {
              checkedIcon == 0 ? checkedIcon = 1 : checkedIcon = 0;
            });
          },
        ),
        SizedBox(width: 5,),
        Text('${widget.checkDescription}')
      ],
    );
  }
}