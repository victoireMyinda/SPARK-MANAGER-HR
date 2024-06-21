import 'package:location_agent/theme.dart';
import 'package:location_agent/utils/color.util.dart';
import 'package:flutter/material.dart';


class LinearProgressWidget extends StatefulWidget {
  const LinearProgressWidget({ Key? key }) : super(key: key);

  @override
  _LinearProgressWidgetState createState() => _LinearProgressWidgetState();
}

class _LinearProgressWidgetState extends State<LinearProgressWidget> {
  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
            minHeight: 3.0,
            backgroundColor: iconColor.withOpacity(0.5),
            valueColor: new AlwaysStoppedAnimation<Color>(
                Color(ColorUtil.getColorHexFromStr("#F49C54"))),
      );
  }
}