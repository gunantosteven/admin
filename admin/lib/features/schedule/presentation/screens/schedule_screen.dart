import 'package:admin/features/schedule/presentation/provider/state/schedule_providers.dart';
import 'package:admin/routes/app_route.dart';
import 'package:admin/shared/widgets/custom_loading.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ScheduleScreen extends ConsumerStatefulWidget {
  static const routeName = '/schedule';

  const ScheduleScreen({super.key});

  @override
  ConsumerState<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends ConsumerState<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(AppLocalizations.of(context)!.schedule),
      ),
      body: StreamBuilder(
        stream:
            ref.watch(scheduleStateNotifierProvider.notifier).streamSchedule(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something Wrong'));
          }

          final list = snapshot.data;
          if (list != null) {
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return Text(list[index].job);
              },
            );
          }

          return const CustomLoading();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AutoRouter.of(context).push(const NewScheduleRoute());
        },
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
