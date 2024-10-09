import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sajid_ikram/presentation/configs/configs.dart';
import 'package:sajid_ikram/presentation/utils/extensions/context_ex.dart';
import 'package:sajid_ikram/presentation/utils/extensions/extensions.dart';
import 'package:sajid_ikram/presentation/views/home/project_showcase.dart';
import 'package:sajid_ikram/presentation/views/wrapper.dart';
import 'package:sajid_ikram/presentation/widgets/widgets.dart';

import 'introduction_page.dart';
import 'showcase_projects_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();
  List<Widget> mainPages = [];
  final _key = GlobalKey();
  bool _isDrawerOpen = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mainPages = [
      IntroductionPage(
        onTapSeeMyWorks: _onTapSeeMyWorks,
      ),
      //const ShowcaseProjectsPage(),
      HoverProjectList(),
      const FooterPage(),
    ];
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void onMenuTapped() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  void _onTapSeeMyWorks() {
    _scrollController.animateTo(
      context.screenHeight,
      duration: duration500,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrapper(
      page: mainPages.addListView(
          key: _key,
          controller: _scrollController,
          physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
        ),
    );
  }
}
