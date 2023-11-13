import 'package:admin/features/schedule/application/delete_schedule_controller.dart';
import 'package:admin/features/schedule/application/list_schedule_controller.dart';
import 'package:admin/features/schedule/presentation/widgets/custom_list_schedule.dart';
import 'package:admin/routes/app_route.dart';
import 'package:admin/shared/widgets/custom_loading.dart';
import 'package:admin/shared/widgets/custom_snackbar.dart';
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
  Widget build(BuildContext context) {
    final schedulesRef = ref.watch(listScheduleControllerProvider);
    final deleteScheduleRef = ref.watch(deleteScheduleControllerProvider);

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

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.schedule),
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
