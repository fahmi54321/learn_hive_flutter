import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learn_hive_flutter/constants.dart';
import 'package:learn_hive_flutter/models/color_path.dart';

class DrawingScreen extends StatefulWidget {
  const DrawingScreen({super.key});

  @override
  _DrawingScreenState createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  var selectedColorIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                ValueListenableBuilder(
                  valueListenable:
                      Hive.box<ColoredPath>(sketchBox).listenable(),
                  builder: drawPathsFromBox,
                ),
                DrawingArea(selectedColorIndex),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (var i = 0; i < ColoredPath.colors.length; i++)
                buildColorCircle(i),
              const ClearButton(),
              const UndoButton(),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget drawPathsFromBox(
    BuildContext context,
    Box<ColoredPath> box,
    Widget? child,
  ) {
    return Stack(
      children: <Widget>[
        for (var path in box.values)
          CustomPaint(
            size: Size.infinite,
            painter: PathPainter(path),
          ),
      ],
    );
  }

  Widget buildColorCircle(int colorIndex) {
    var selected = selectedColorIndex == colorIndex;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColorIndex = colorIndex;
        });
      },
      child: ClipOval(
        child: Container(
          padding: const EdgeInsets.only(bottom: 16.0),
          height: selected ? 50 : 36,
          width: selected ? 50 : 36,
          color: ColoredPath.colors[colorIndex],
        ),
      ),
    );
  }
}

class DrawingArea extends StatefulWidget {
  final int selectedColorIndex;

  const DrawingArea(this.selectedColorIndex, {super.key});

  @override
  _DrawingAreaState createState() => _DrawingAreaState();
}

class _DrawingAreaState extends State<DrawingArea> {
  var path = ColoredPath(0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        addPoint(details.globalPosition);
      },
      onPanStart: (details) {
        path = ColoredPath(widget.selectedColorIndex);
        addPoint(details.globalPosition);
      },
      onPanEnd: (details) {
        Hive.box<ColoredPath>(sketchBox).add(path);
        setState(() {
          path = ColoredPath(0);
        });
      },
      child: CustomPaint(
        size: Size.infinite,
        painter: PathPainter(path),
      ),
    );
  }

  void addPoint(Offset point) {
    var renderBox = context.findRenderObject() as RenderBox;
    setState(() {
      path.addPoint(renderBox.globalToLocal(point));
    });
  }
}

class PathPainter extends CustomPainter {
  final ColoredPath path;

  PathPainter(this.path);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(path.path, path.paint);
  }

  @override
  bool shouldRepaint(PathPainter oldDelegate) => true;
}

class ClearButton extends StatelessWidget {
  const ClearButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<ColoredPath>(sketchBox).listenable(),
      builder: (context, box, _) {
        return IconButton(
          icon: const Icon(Icons.delete),
          onPressed: box.length == 0 ? null : () => box.clear(),
        );
      },
    );
  }
}

class UndoButton extends StatelessWidget {
  const UndoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<ColoredPath>(sketchBox).listenable(),
      builder: (context, box, _) {
        return IconButton(
          icon: const Icon(Icons.undo),
          onPressed:
              box.length == 0 ? null : () => box.deleteAt(box.length - 1),
        );
      },
    );
  }
}
