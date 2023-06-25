import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';

import '/pages/folders/folders_view.dart';

class FoldersLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/folders'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        const BeamPage(
          key: ValueKey('folders'),
          title: 'Folders',
          type: BeamPageType.noTransition,
          child: FoldersScreen(),
        ),
      ];
}
