import 'package:admin/features/auth/application/auth_controller.dart';
import 'package:admin/features/dashboard/application/expand_navigation_controller.dart';
import 'package:admin/features/dashboard/presentation/widgets/navigation_transition.dart';
import 'package:admin/features/user/application/controller/check_user_controller.dart';
import 'package:admin/routes/app_route.dart';
import 'package:admin/shared/theme/app_padding.dart';
import 'package:admin/shared/theme/app_spacer.dart';
import 'package:admin/shared/theme/app_theme.dart';
import 'package:admin/shared/widgets/custom_button.dart';
import 'package:admin/shared/widgets/custom_text.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

    ref.read(checkUserControllerProvider.notifier).checkUser();
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
      title: CustomText(
        AppLocalizations.of(context)!.admin,
        textType: TextType.H1,
      ),
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
          _BrightnessButton(
            showTooltipBelow: false,
          ),
          _ExpandButton(),
          AppSpacer.height16,
          _LogoutButton(),
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
            final extended = ref.watch(expandNavigationControllerProvider);

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
                        extended: extended,
                        destinations: navRailDestinations,
                        selectedIndex: screenIndex,
                        onDestinationSelected: (index) {
                          screenIndex = index;
                          tabsRouter.setActiveIndex(screenIndex);
                        },
                        trailing: Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: extended
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

class _ExpandedTrailingActions extends ConsumerWidget {
  const _ExpandedTrailingActions();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                value: ref.read(appThemeProvider) == ThemeMode.light,
                onChanged: (value) {
                  ref.read(appThemeProvider.notifier).toggleTheme();
                },
              ),
            ],
          ),
          Row(
            children: [
              const Text('Shrink Tab'),
              Expanded(child: Container()),
              const Padding(
                padding: AppPadding.right8,
                child: _ExpandButton(),
              ),
            ],
          ),
          AppSpacer.height16,
          Row(
            children: [
              const Text('Log Out'),
              Expanded(child: Container()),
              const Padding(
                padding: AppPadding.right8,
                child: _LogoutButton(),
              ),
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

class _BrightnessButton extends ConsumerWidget {
  const _BrightnessButton({
    this.showTooltipBelow = true,
  });

  final bool showTooltipBelow;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBright = ref.read(appThemeProvider) == ThemeMode.light;
    return Tooltip(
      preferBelow: showTooltipBelow,
      message: 'Toggle brightness',
      child: CustomButton(
        buttonType: ButtonType.ICON,
        icon: isBright ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
        onPressed: () {
          ref.read(appThemeProvider.notifier).toggleTheme();
        },
      ),
    );
  }
}

class _ExpandButton extends ConsumerWidget {
  const _ExpandButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpand = ref.watch(expandNavigationControllerProvider);
    return CustomButton(
      buttonType: ButtonType.ICON,
      icon: isExpand ? Icons.arrow_back : Icons.arrow_forward,
      onPressed: () {
        ref.read(expandNavigationControllerProvider.notifier).expand();
      },
    );
  }
}

class _LogoutButton extends ConsumerWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomButton(
      buttonType: ButtonType.ICON,
      icon: Icons.logout,
      onPressed: () {
        ref.read(authControllerProvider.notifier).logout();
        AutoRouter.of(context).replace(const AuthRoute());
      },
    );
  }
}
