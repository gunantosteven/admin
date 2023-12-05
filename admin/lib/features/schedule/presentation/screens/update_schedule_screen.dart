import 'package:admin/features/schedule/application/update_schedule_controller.dart';
import 'package:admin/features/schedule/domain/models/schedule_model.dart';
import 'package:admin/features/schedule/presentation/widgets/form_schedule.dart';
import 'package:admin/shared/widgets/custom_loading.dart';
import 'package:admin/shared/widgets/custom_snackbar.dart';
import 'package:admin/shared/widgets/custom_text.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class UpdateScheduleScreen extends ConsumerStatefulWidget {
  static const routeName = '/update-schedule';

  const UpdateScheduleScreen({super.key, required this.scheduleModel});

  final ScheduleModel scheduleModel;

  @override
  ConsumerState<UpdateScheduleScreen> createState() =>
      _NewScheduleScreenState();
}

class _NewScheduleScreenState extends ConsumerState<UpdateScheduleScreen> {
  final TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _titleController.text = widget.scheduleModel.title;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<ScheduleModel?>>(updateScheduleControllerProvider,
        (previous, next) {
      next.when(
          data: (data) {
            if (data != null) {
              CustomSnackbar.show(
                  context: context,
                  type: ToastType.SUCCESS,
                  text: AppLocalizations.of(context)!.scheduleUpdated);
              AutoRouter.of(context).back();
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
        title: CustomText(
          AppLocalizations.of(context)!.updateSchedule,
          textType: TextType.H1,
        ),
      ),
      body: Stack(
        children: [
          FormSchedule(
            titleController: _titleController,
            scheduleModel: widget.scheduleModel,
            onConfirm: (date, time) {
              ref
                  .read(updateScheduleControllerProvider.notifier)
                  .updateSchedule(
                    currentSchedule: widget.scheduleModel,
                    newTitle: _titleController.text,
                    newDate: date,
                    newTime: time,
                  );
            },
          ),
          Consumer(
            builder: (context, ref, child) {
              final state = ref.watch(updateScheduleControllerProvider);

              return state.maybeWhen(
                  loading: () => const CustomLoading(),
                  orElse: () => Container());
            },
          ),
        ],
      ),
    );
  }
}
