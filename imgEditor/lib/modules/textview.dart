import 'package:flutter/material.dart';

class TextView extends StatefulWidget {
  final double left;
  final double top;
  final Function ontap;
  final Function(DragUpdateDetails) onpanupdate;
  final double fontsize;
  final String font;
  final String value;
  final Color color;
  final TextAlign align;
  const TextView(
      {Key key,
      this.font,
      this.left,
      this.top,
      this.ontap,
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
          child: Text(widget.value,
              textAlign: widget.align,
              style: TextStyle(
                  fontSize: widget.fontsize,
                  color: widget.color,
                  fontFamily: widget.font))),
    );
  }
}
