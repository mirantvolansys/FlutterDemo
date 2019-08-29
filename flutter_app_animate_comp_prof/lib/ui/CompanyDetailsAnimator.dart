import 'package:flutter/material.dart';
import 'package:flutter_app_animate_comp_prof/repos/repo.dart';
import 'package:flutter_app_animate_comp_prof/ui/CompanyDetailsPage.dart';

class CompanyDetailsAnimator extends StatefulWidget {
  @override
  _CompanyDetailsAnimatorState createState() => _CompanyDetailsAnimatorState();
}

class _CompanyDetailsAnimatorState extends State<CompanyDetailsAnimator> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this,duration: Duration(milliseconds: 1800));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return CompanyDetailsPage(controller: _controller,company1: RepoData.bawp,);
  }
}

