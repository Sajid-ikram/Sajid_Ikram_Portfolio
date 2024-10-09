import 'dart:ui'; // Import for ImageFilter
import 'package:flutter/material.dart';
import 'package:sajid_ikram/presentation/utils/extensions/context_ex.dart';
import 'package:sajid_ikram/presentation/utils/extensions/extensions.dart';

import '../../configs/constant_sizes.dart';

class HoverProjectList extends StatefulWidget {
  @override
  _HoverProjectListState createState() => _HoverProjectListState();
}

class _HoverProjectListState extends State<HoverProjectList> {
  String hoveredProject = "";
  bool showPreview = false; // To control scale and fade animations

  @override
  Widget build(BuildContext context) {
    var appBarHeight = Theme.of(context).appBarTheme.toolbarHeight!;
    var containerHeight = context.screenHeight - (appBarHeight + s10);
    return Stack(
      children: [
        // Background Container for BackdropFilter to have something to blur
        Container(
          width: double.infinity,
          height: containerHeight,
          color: Colors.black.withOpacity(0.05), // Add a subtle background color
        ),

        // Apply blur filter on everything except hovered project
        BackdropFilter(
          filter: hoveredProject.isNotEmpty
              ? ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0) // Blur effect when hovered
              : ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0), // No blur when not hovering
          child: Container(
            width: double.maxFinite,
            height: containerHeight,
            color: Colors.transparent, // Make sure the Container doesn't cover anything
            padding: context.symmetricPercentPadding(
              hPercent: context.adaptive(
                s2,
                s10,
                md: s4,
              ),
            ),
            child: Stack(
              children: [
                // Project List on the left
                Positioned(
                  left: 0,
                  top: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      projectItem("iphone lockers", 0),
                      customDevider(),
                      projectItem("firstfloor raffle", 1),
                      customDevider(),
                      projectItem("read.cv nda post", 2),
                      customDevider(),
                      projectItem("spotify comment section", 3),
                      customDevider(),
                      projectItem("post cards app", 4),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Keep the selected name and popup phone preview in focus
        if (hoveredProject == "iphone lockers" || hoveredProject == "firstfloor raffle")
          Positioned(
            right: context.screenWidth * 0.1,
            top: 20,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.5, end: showPreview ? 1.0 : 0.5), // Scaling animation
              duration: Duration(milliseconds: 400), // Animation duration
              builder: (context, scale, child) {
                return Transform.scale(
                  scale: scale, // Apply scaling transformation
                  child: AnimatedOpacity(
                    opacity: showPreview ? 1.0 : 0.0, // Fade in and out
                    duration: Duration(milliseconds: 300), // Fade duration
                    child: child,
                  ),
                );
              },
              child: _buildMobileScreenPreview(hoveredProject == "iphone lockers"
                  ? "assets/images/projects/notee.png"
                  : "assets/images/projects/iron_man.png"), // The mobile screen preview widget
            ),
          ),
      ],
    );
  }

  Container customDevider() {
    return Container(
      height: 2,
      width: MediaQuery.of(context).size.width * 0.8,
      color: Colors.black.withOpacity(0.2),
    );
  }

  // Widget for each project item
  Widget projectItem(String projectName, int index) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          hoveredProject = projectName;
          showPreview = true; // Show the preview with animation when hovered
        });
      },
      onExit: (_) {
        setState(() {
          hoveredProject = "";
          showPreview = false; // Hide the preview with animation when not hovered
        });
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: BackdropFilter(
            filter: hoveredProject.isNotEmpty && hoveredProject != projectName
                ? ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0)
                : ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Conditionally blur the text of non-hovered projects
                Text(
                  projectName,
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: hoveredProject == projectName ? Colors.black : Colors.grey,
                  ),
                ),
                Text(
                  index.toString(),
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: hoveredProject == projectName ? Colors.black : Colors.grey,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // The mobile screen preview widget
  Widget _buildMobileScreenPreview(String imageUrl) {
    return Container(
      width: 300,
      height: 600,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey,
          width: 4,
        ),
      ),
      child: Column(
        children: [
          // Screen content (sample image, warning icon, etc.)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              imageUrl,
              height: 150,
            ),
          ),

        ],
      ),
    );
  }
}
