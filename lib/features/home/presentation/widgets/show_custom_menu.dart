 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky_api/features/home/presentation/widgets/todo_item.dart';

void showCustomMenu(BuildContext context, GlobalKey key , void Function()? deleteOnTapped) {
    final overlay = Overlay.of(context);
    final RenderBox button =
        key.currentContext!.findRenderObject() as RenderBox;

    final position = button.localToGlobal(Offset.zero);

    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) {
        return GestureDetector(
          onTap: () => overlayEntry.remove(),
          child: Material(
            color: Colors.transparent,
            child: Stack(
              children: [
                Positioned(
                  left: position.dx - 70,
                  top: position.dy + button.size.height + 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Transform.translate(
                        offset: Offset(-10, 0),
                        child: CustomPaint(
                          size: Size(20, 10),
                          painter: TrianglePainter(),
                        ),
                      ),

                      Container(
                        width: 100,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(blurRadius: 10, color: Colors.black12),
                          ],
                        ),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                print("Edit");
                              },
                              child: Padding(
                                padding: EdgeInsets.all(12),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Edit"),
                                ),
                              ),
                            ),
                            Divider(height: 0, indent: 10.w, endIndent: 10.w),
                            InkWell(
                              onTap: deleteOnTapped,
                              child: Padding(
                                padding: EdgeInsets.all(12),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(color: Colors.deepOrange),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    overlay.insert(overlayEntry);
  }
