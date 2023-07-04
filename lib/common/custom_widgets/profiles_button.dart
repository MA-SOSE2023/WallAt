import 'package:flutter/cupertino.dart';

import '/router/router.dart';

class ProfilesButton extends StatelessWidget {
  const ProfilesButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: const Icon(CupertinoIcons.profile_circled, size: 30.0),
      onPressed: () => Routers.globalRouterDelegate.beamToNamed('/profiles'),
    );
  }
}
