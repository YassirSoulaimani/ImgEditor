import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class TextView extends StatefulWidget {
  final double left;
  final double top;
  final Function ontap;
  final Function ontap2;
  final Function(DragUpdateDetails) onpanupdate;
  final double fontsize;
  final String font;
  final String value;
  final Color color;
  final TextAlign align;
  final bool pressed;
  const TextView(
      {Key key,
      this.pressed,
      this.font,
      this.left,
      this.top,
      this.ontap,
      this.ontap2,
      this.onpanupdate,
      this.fontsize,
      this.value,
      this.color,
      this.align})
      : super(key: key);
  @override
  _TextViewState createState() => _TextViewState();
}

class _TextViewState extends State<TextView> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.left,
      top: widget.top,
      child: GestureDetector(
          onTap: widget.ontap,
          onPanUpdate: widget.onpanupdate,
          child: widget.pressed
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    DottedBorder(
                        borderType: BorderType.RRect,
                        radius: Radius.circular(12),
                        padding: EdgeInsets.all(6),
                        child: Text(widget.value,
                            textAlign: widget.align,
                            style: TextStyle(
                                fontSize: widget.fontsize,
                                color: widget.color,
                                fontFamily: widget.font))),
                    IconButton(
                      icon: new Icon(Icons.delete_forever),
                      color: Colors.red,
                      onPressed: widget.ontap2,
                    )
                  ],
                )
              : Container(
                  padding: EdgeInsets.all(7),
                  child: Text(widget.value,
                      textAlign: widget.align,
                      style: TextStyle(
                          fontSize: widget.fontsize,
                          color: widget.color,
                          fontFamily: widget.font)))),
    );
  }
}
