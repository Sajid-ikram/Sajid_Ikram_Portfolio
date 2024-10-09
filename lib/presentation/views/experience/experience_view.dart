import 'package:flutter/material.dart';
import 'package:pretty_animated_buttons/extensions/widget_ex.dart';

import '../wrapper.dart';
import 'subviews/experience_title_page.dart';
import 'subviews/jobs_list_page.dart';

class ExperienceView extends StatefulWidget {
  const ExperienceView({super.key});

  @override
  State<ExperienceView> createState() => _ExperienceViewState();
}

class _ExperienceViewState extends State<ExperienceView> {
  @override
  Widget build(BuildContext context) {
    return Wrapper(
      page: const <Widget>[
        ExperienceTitlePage(),
        JobsListPage(),
      ].addListView(
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
      ),
    );
  }
}
