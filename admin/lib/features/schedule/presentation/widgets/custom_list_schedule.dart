import 'package:admin/features/schedule/application/list_schedule_controller.dart';
import 'package:admin/shared/theme/app_padding.dart';
import 'package:admin/shared/widgets/custom_loading.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomListSchedule extends ConsumerWidget {
  const CustomListSchedule({
    super.key,
    this.padding = AppPadding.all24,
  });

  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schedules = ref.watch(listScheduleControllerProvider);
    return schedules.when(
      data: (stream) => StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Text(AppLocalizations.of(context)!.somethingWrong));
          }

          final list = snapshot.data;
          if (list != null) {
            return ListView.builder(
              itemCount: list.length,
              padding: padding,
              itemBuilder: (context, index) {
                return Text(
                    '${list[index].job} ${list[index].createdAt?.toString() ?? ''}');
              },
            );
          }

          return const CustomLoading();
        },
      ),
      error: (e, s) => Center(child: Text(e.toString())),
      loading: () => const CustomLoading(),
    );
  }
}
