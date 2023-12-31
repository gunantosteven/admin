import 'package:admin/features/schedule/application/controller/delete_schedule_controller.dart';
import 'package:admin/features/schedule/application/controller/list_schedule_controller.dart';
import 'package:admin/features/schedule/application/controller/search_schedule_controller.dart';
import 'package:admin/features/schedule/application/controller/sort_schedule_controller.dart';
import 'package:admin/features/schedule/presentation/widgets/custom_list_schedule.dart';
import 'package:admin/features/schedule/presentation/widgets/sort_dialog.dart';
import 'package:admin/routes/app_route.dart';
import 'package:admin/shared/widgets/custom_button.dart';
import 'package:admin/shared/widgets/custom_loading.dart';
import 'package:admin/shared/widgets/custom_snackbar.dart';
import 'package:admin/shared/widgets/custom_text.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ScheduleScreen extends ConsumerStatefulWidget {
  static const routeName = 'schedule';

  const ScheduleScreen({super.key});

  @override
  ConsumerState<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends ConsumerState<ScheduleScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(listScheduleControllerProvider.notifier).initSchedule();
    });
  }

  @override
  Widget build(BuildContext context) {
    final schedulesRef = ref.watch(listScheduleControllerProvider);
    final deleteScheduleRef = ref.watch(deleteScheduleControllerProvider);
    // ignore: unused_local_variable
    final searchSchedules = ref.watch(searchScheduleControllerProvider);
    final searchNotifier = ref.read(searchScheduleControllerProvider.notifier);

    ref.listen<AsyncValue<bool>>(deleteScheduleControllerProvider,
        (previous, next) {
      next.when(
          data: (data) {
            if (data) {
              CustomSnackbar.show(
                  context: context,
                  type: ToastType.ERROR,
                  text: 'Schedule has been deleted');
            }
          },
          error: (o, s) {
            CustomSnackbar.show(
              context: context,
              type: ToastType.ERROR,
              text: o.toString(),
            );
          },
          loading: () {});
    });

    ref.listen<AsyncValue<bool>>(sortScheduleControllerProvider,
        (previous, next) {
      next.when(
          data: (data) {
            ref.read(searchScheduleControllerProvider.notifier).reload();
            ref.read(listScheduleControllerProvider.notifier).initSchedule();
          },
          error: (o, s) {},
          loading: () {});
    });

    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          AppLocalizations.of(context)!.schedule(searchNotifier.isSearchMode()
              ? '(Not Realtime Stream)'
              : '(Realtime Stream)'),
          textType: TextType.H4,
        ),
        actions: [
          CustomButton(
            onPressed: () {
              showDialog(
                  context: context, builder: (context) => const SortDialog());
            },
            buttonType: ButtonType.ICON,
            icon: Icons.sort,
          ),
        ],
      ),
      body: Stack(
        children: [
          schedulesRef.when(
            data: (args) => const CustomListSchedule(),
            error: (e, s) => Center(child: Text(e.toString())),
            loading: () => const CustomLoading(),
          ),
          Positioned.fill(
            child: deleteScheduleRef.when(
              data: (args) => Container(),
              error: (e, s) => Container(),
              loading: () => const CustomLoading(),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AutoRouter.of(context).push(const NewScheduleRoute());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
