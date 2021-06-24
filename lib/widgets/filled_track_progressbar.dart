import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

/// Track filled type progress bar
class FilledTrackIndeterminateProgressbar extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  FilledTrackIndeterminateProgressbar({Key? key}) : super(key: key);

  @override
  _FilledTrackIndeterminateProgressbarState createState() =>
      _FilledTrackIndeterminateProgressbarState();
}

class _FilledTrackIndeterminateProgressbarState extends State<FilledTrackIndeterminateProgressbar> with TickerProviderStateMixin {

  late Animation<double> linearAnimation;
  late AnimationController linearAnimationController;
  double animationValue = 0;

  @override
  void initState() {
    super.initState();

    /// Linear animation
    linearAnimationController = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);

    linearAnimation =
    CurvedAnimation(parent: linearAnimationController, curve: Curves.linear)
      ..addListener(() {
        setState(() {
          animationValue = linearAnimation.value * 360;
        });
      });
    linearAnimationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(axes: <RadialAxis>[
      RadialAxis(
        minimum: 0,
        maximum: 100,
        showLabels: false,
        showTicks: false,
        startAngle: animationValue,
        endAngle: animationValue + 359,
        showAxisLine: true,
        radiusFactor: 0.65,
        axisLineStyle: AxisLineStyle(
          thickness: 1,
          gradient: const SweepGradient(
              colors: [Color(0xFF82B1FF), Colors.white],
              stops: <double>[0.25, 1.0]),
          thicknessUnit: GaugeSizeUnit.factor,
        ),
      )
    ]);
  }

  @override
  void dispose() {
    linearAnimationController.dispose();
    super.dispose();
  }
}