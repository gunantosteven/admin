import 'package:admin/features/dashboard/presentation/widgets/navigation_transition.dart';
import 'package:admin/routes/app_route.dart';
import 'package:admin/shared/theme/app_theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'constants.dart';

@RoutePage()
class DashboardScreen extends ConsumerStatefulWidget {
  static const routeName = '/dashboard';

  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late final AnimationController controller;
  late final CurvedAnimation railAnimation;
  bool controllerInitialized = false;
  bool showMediumSizeLayout = false;
  bool showLargeSizeLayout = false;

  int screenIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: transitionLength.toInt() * 2),
      value: 0,
      vsync: this,
    );
    railAnimation = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.5, 1.0),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final double width = MediaQuery.of(context).size.width;
    final AnimationStatus status = controller.status;
    if (width > mediumWidthBreakpoint) {
      if (width > largeWidthBreakpoint) {
        showMediumSizeLayout = false;
        showLargeSizeLayout = true;
      } else {
        showMediumSizeLayout = true;
        showLargeSizeLayout = false;
      }
      if (status != AnimationStatus.forward &&
          status != AnimationStatus.completed) {
        controller.forward();
      }
    } else {
      showMediumSizeLayout = false;
      showLargeSizeLayout = false;
      if (status != AnimationStatus.reverse &&
          status != AnimationStatus.dismissed) {
        controller.reverse();
      }
    }
    if (!controllerInitialized) {
      controllerInitialized = true;
      controller.value = width > mediumWidthBreakpoint ? 1 : 0;
    }
  }

  PreferredSizeWidget createAppBar() {
    return AppBar(
      title: const Text('Admin App'),
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          final AnimationStatus status = controller.status;
          if (status != AnimationStatus.forward &&
              status != AnimationStatus.completed) {
            controller.forward();
          } else {
            controller.reverse();
          }
        },
      ),
      actions: !showMediumSizeLayout && !showLargeSizeLayout
          ? [
              const _BrightnessButton(),
            ]
          : [Container()],
    );
  }

  Widget _trailingActions() => const Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: _BrightnessButton(
              showTooltipBelow: false,
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return AutoTabsRouter(
          routes: const [
            ScheduleRoute(),
            ColorPalettesRoute(),
            TypographyRoute(),
            ElevationRoute()
          ],
          builder: (ctx, child) {
            final tabsRouter = AutoTabsRouter.of(ctx);

            screenIndex = tabsRouter.activeIndex;

            return NavigationTransition(
              scaffoldKey: scaffoldKey,
              animationController: controller,
              railAnimation: railAnimation,
              appBar: createAppBar(),
              body: Expanded(child: child),
              navigationRail: LayoutBuilder(builder: (context, constraint) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraint.maxHeight),
                    child: IntrinsicHeight(
                      child: NavigationRail(
                        extended: showLargeSizeLayout,
                        destinations: navRailDestinations,
                        selectedIndex: screenIndex,
                        onDestinationSelected: (index) {
                          screenIndex = index;
                          tabsRouter.setActiveIndex(screenIndex);
                        },
                        trailing: Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: showLargeSizeLayout
                                ? const _ExpandedTrailingActions()
                                : _trailingActions(),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            );
          },
        );
      },
    );
  }
}

class _BrightnessButton extends ConsumerWidget {
  const _BrightnessButton({
    this.showTooltipBelow = true,
  });

  final bool showTooltipBelow;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBright = Theme.of(context).brightness == Brightness.light;
    return Tooltip(
      preferBelow: showTooltipBelow,
      message: 'Toggle brightness',
      child: IconButton(
        icon: isBright
            ? const Icon(Icons.dark_mode_outlined)
            : const Icon(Icons.light_mode_outlined),
        onPressed: () {
          ref.read(appThemeProvider.notifier).toggleTheme();
        },
      ),
    );
  }
}

class _ExpandedTrailingActions extends StatelessWidget {
  const _ExpandedTrailingActions();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final trailingActionsBody = Container(
      constraints: const BoxConstraints.tightFor(width: 250),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Text('Brightness'),
              Expanded(child: Container()),
              Switch(
                  value: true,
                  onChanged: (value) {
                    // handleBrightnessChange(value);
                  })
            ],
          ),
        ],
      ),
    );
    return screenHeight > 740
        ? trailingActionsBody
        : SingleChildScrollView(child: trailingActionsBody);
  }
}
