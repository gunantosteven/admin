import 'package:admin/features/schedule/application/delete_schedule_controller.dart';
import 'package:admin/features/schedule/application/list_schedule_controller.dart';
import 'package:admin/routes/app_route.dart';
import 'package:admin/shared/extension/date_extension.dart';
import 'package:admin/shared/theme/app_padding.dart';
import 'package:admin/shared/theme/app_spacer.dart';
import 'package:admin/shared/widgets/custom_button.dart';
import 'package:admin/shared/widgets/custom_dialog.dart';
import 'package:admin/shared/widgets/custom_loading.dart';
import 'package:admin/shared/widgets/custom_text.dart';
import 'package:admin/shared/widgets/custom_textfield.dart';
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
    final listNotifier = ref.read(listScheduleControllerProvider.notifier);
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
            if (list.isEmpty) {
              return Center(
                child: CustomText(
                  AppLocalizations.of(context)!.scheduleEmpty,
                  textType: TextType.BODY,
                ),
              );
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  const CustomTextField(
                    textFieldType: TextFieldType.SEARCH,
                    placeholder: 'Search Schedule',
                  ),
                  ListView.builder(
                    itemCount: list.length,
                    padding: padding,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final scheduleModel = list[index];
                      return ListTile(
                        key: Key(index.toString()),
                        title: Text(scheduleModel.title),
                        subtitle: Text(scheduleModel.createdAt
                                ?.string(DateType.simpleDateTime) ??
                            ''),
                        onTap: () => AutoRouter.of(context).push(
                          UpdateScheduleRoute(scheduleModel: scheduleModel),
                        ),
                        trailing: CustomButton(
                          text: AppLocalizations.of(context)!.delete,
                          onPressed: () {
                            showDialog<void>(
                              context: context,
                              builder: (context) => CustomDialog(
                                title: AppLocalizations.of(context)!
                                    .deleteScheduleTitle,
                                desc: AppLocalizations.of(context)!
                                    .deleteScheduleDesc,
                                dialogType: DialogType.REMOVE,
                                onConfirm: () {
                                  ref
                                      .read(deleteScheduleControllerProvider
                                          .notifier)
                                      .deleteSchedule(
                                          scheduleModel: scheduleModel);
                                },
                              ),
                            );
                          },
                          buttonType: ButtonType.ICON,
                          icon: Icons.delete,
                        ),
                      );
                    },
                  ),
                  if (listNotifier.canLoadMore(list.length))
                    Padding(
                      padding: AppPadding.all24,
                      child: CustomButton(
                        text: AppLocalizations.of(context)!.loadMore,
                        buttonType: ButtonType.TEXT,
                        onPressed: () {
                          listNotifier.loadMore();
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
