import 'package:admin/features/schedule/application/list_schedule_controller.dart';
import 'package:admin/features/schedule/presentation/widgets/custom_list_schedule.dart';
import 'package:admin/routes/app_route.dart';
import 'package:admin/shared/widgets/custom_loading.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ListScheduleScreen extends ConsumerStatefulWidget {
  static const routeName = '/schedule';

  const ListScheduleScreen({super.key});

  @override
  ConsumerState<ListScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends ConsumerState<ListScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    final schedules = ref.watch(listScheduleControllerProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(AppLocalizations.of(context)!.schedule),
      ),
      body: schedules.when(
        data: (args) => const CustomListSchedule(),
        error: (e, s) => Center(child: Text(e.toString())),
        loading: () => const CustomLoading(),
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
