import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';

class GlobalLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/home'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [];
}
