import 'package:admin/features/schedule/application/list_schedule_controller.dart';
import 'package:admin/routes/app_route.dart';
import 'package:admin/shared/extension/date_extension.dart';
import 'package:admin/shared/theme/app_padding.dart';
import 'package:admin/shared/theme/app_spacer.dart';
import 'package:admin/shared/widgets/custom_button.dart';
import 'package:admin/shared/widgets/custom_loading.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomListSchedule extends ConsumerWidget {
  const CustomListSchedule({
    super.key,
    this.padding = AppPadding.zero,
  });

  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schedules = ref.watch(listScheduleControllerProvider);
    final notifier = ref.read(listScheduleControllerProvider.notifier);
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
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    itemCount: list.length,
                    padding: padding,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final scheduleModel = list[index];
                      return ListTile(
                        key: Key(index.toString()),
                        title: Text(scheduleModel.job),
                        subtitle: Text(scheduleModel.createdAt
                                ?.string(DateType.simpleDateTime) ??
                            ''),
                        onTap: () => AutoRouter.of(context).push(
                          UpdateScheduleRoute(scheduleModel: scheduleModel),
                        ),
                      );
                    },
                  ),
                  if (notifier.canLoadMore(list.length))
                    Padding(
                      padding: AppPadding.all24,
                      child: CustomButton(
                        text: AppLocalizations.of(context)!.loadMore,
                        buttonType: ButtonType.TEXT,
                        onPressed: () {
                          notifier.loadMore();
                        },
                      ),
                    ),
                  AppSpacer.height24,
                ],
              ),
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
