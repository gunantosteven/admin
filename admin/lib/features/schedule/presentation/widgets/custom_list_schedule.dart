import 'package:admin/features/schedule/application/delete_schedule_controller.dart';
import 'package:admin/features/schedule/application/list_schedule_controller.dart';
import 'package:admin/features/schedule/application/search_schedule_controller.dart';
import 'package:admin/features/schedule/domain/models/schedule_model.dart';
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

class CustomListSchedule extends ConsumerStatefulWidget {
  const CustomListSchedule({
    super.key,
    this.padding = AppPadding.zero,
  });

  final EdgeInsetsGeometry padding;

  @override
  ConsumerState<CustomListSchedule> createState() => _CustomListScheduleState();
}

class _CustomListScheduleState extends ConsumerState<CustomListSchedule> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final listSchedules = ref.watch(listScheduleControllerProvider);
    final searchSchedules = ref.watch(searchScheduleControllerProvider);
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              CustomTextField(
                textFieldType: TextFieldType.SEARCH,
                placeholder: AppLocalizations.of(context)!.searchSchedule,
                controller: _searchController,
                onChanged:
                    ref.read(searchScheduleControllerProvider.notifier).search,
              ),
              _searchController.text.isNotEmpty
                  ? searchScheduleWidget()
                  : streamScheduleWidget(),
            ],
          ),
        ),
        if (searchSchedules.isLoading || listSchedules.isLoading)
          const CustomLoading(),
      ],
    );
  }

  Widget streamScheduleWidget() {
    final listSchedules = ref.watch(listScheduleControllerProvider);
    final listNotifier = ref.read(listScheduleControllerProvider.notifier);
    return listSchedules.when(
      data: (stream) => StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Text(AppLocalizations.of(context)!.somethingWrong));
          }

          final list = snapshot.data;
          if (list != null) {
            return scheduleList(
              list: list,
              canLoadMore: listNotifier.canLoadMore(list.length),
              onLoadMore: () => listNotifier.loadMore(),
            );
          }

          return Container();
        },
      ),
      error: (e, s) => Center(child: Text(e.toString())),
      loading: () => Container(),
    );
  }

  Widget searchScheduleWidget() {
    final searchSchedules = ref.watch(searchScheduleControllerProvider);
    final searchNotifier = ref.read(searchScheduleControllerProvider.notifier);

    return searchSchedules.when(
      data: (data) => scheduleList(
          list: data,
          canLoadMore: searchNotifier.canLoadMore(data.length),
          onLoadMore: () => searchNotifier.loadMore()),
      error: (e, s) => Center(child: Text(e.toString())),
      loading: () => Container(),
    );
  }

  Widget scheduleList(
      {required List<ScheduleModel> list,
      required bool canLoadMore,
      dynamic Function()? onLoadMore}) {
    if (list.isEmpty) {
      return Padding(
        padding: AppPadding.verticall24,
        child: Center(
          child: CustomText(
            AppLocalizations.of(context)!.scheduleEmpty,
            textType: TextType.BODY,
          ),
        ),
      );
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            itemCount: list.length,
            padding: widget.padding,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final scheduleModel = list[index];
              return ListTile(
                key: Key(index.toString()),
                title: Text(scheduleModel.title),
                subtitle: Text(
                    scheduleModel.createdAt?.string(DateType.simpleDateTime) ??
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
                        title:
                            AppLocalizations.of(context)!.deleteScheduleTitle,
                        desc: AppLocalizations.of(context)!.deleteScheduleDesc,
                        dialogType: DialogType.REMOVE,
                        onConfirm: () {
                          ref
                              .read(deleteScheduleControllerProvider.notifier)
                              .deleteSchedule(scheduleModel: scheduleModel);
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
          if (canLoadMore)
            Padding(
              padding: AppPadding.all24,
              child: CustomButton(
                text: AppLocalizations.of(context)!.loadMore,
                buttonType: ButtonType.TEXT,
                onPressed: onLoadMore,
              ),
            ),
          AppSpacer.height24,
        ],
      ),
    );
  }
}
