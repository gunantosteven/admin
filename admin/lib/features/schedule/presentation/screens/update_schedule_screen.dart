import 'package:admin/features/schedule/application/controller/update_schedule_controller.dart';
import 'package:admin/features/schedule/application/state/update_schedule_state.dart';
import 'package:admin/features/schedule/domain/models/schedule_model.dart';
import 'package:admin/features/schedule/presentation/widgets/form_schedule.dart';
import 'package:admin/shared/widgets/custom_loading.dart';
import 'package:admin/shared/widgets/custom_snackbar.dart';
import 'package:admin/shared/widgets/custom_text.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

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

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   ref
    //       .read(updateScheduleControllerProvider(widget.scheduleModel).notifier)
    //       .updateTitle(widget.scheduleModel.title);
    // });

    _titleController.text = widget.scheduleModel.title;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final provider = UpdateScheduleControllerProvider(widget.scheduleModel);
    final watch = ref.watch(provider);
    final notifier = ref.read(provider.notifier);

    ref.listen<AsyncValue<UpdateScheduleState>>(provider, (previous, next) {
      next.when(
          data: (data) {
            if (data.status == FormzSubmissionStatus.success) {
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
            onChangedTitle: (value) => notifier.updateTitle(value),
            titleValidator: (value) => watch.value?.title.error?.getMessage(),
            enabledButton: notifier.isValidForm(),
            scheduleModel: widget.scheduleModel,
            onConfirm: (date, time) {
              notifier.updateSchedule(
                currentSchedule: widget.scheduleModel,
                newDate: date,
                newTime: time,
              );
            },
          ),
          Consumer(
            builder: (context, ref, child) {
              return watch.maybeWhen(
                  loading: () => const CustomLoading(),
                  orElse: () => Container());
            },
          ),
        ],
      ),
    );
  }
}
