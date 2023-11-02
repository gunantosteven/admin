import 'package:admin/features/dashboard/presentation/widgets/component_decoration.dart';
import 'package:admin/features/dashboard/presentation/widgets/navigation_drawer_section.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class NavigationDrawers extends StatelessWidget {
  const NavigationDrawers({super.key, required this.scaffoldKey});
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return ComponentDecoration(
      label: 'Navigation drawer',
      tooltipMessage:
          'Use NavigationDrawer. For modal navigation drawers, see Scaffold.endDrawer',
      child: Column(
        children: [
          const SizedBox(height: 520, child: NavigationDrawerSection()),
          colDivider,
          colDivider,
          TextButton(
            child: const Text('Show modal navigation drawer',
                style: TextStyle(fontWeight: FontWeight.bold)),
            onPressed: () {
              scaffoldKey.currentState!.openEndDrawer();
            },
          ),
        ],
      ),
    );
  }
}
