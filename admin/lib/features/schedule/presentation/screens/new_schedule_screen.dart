import 'package:admin/features/schedule/application/controller/new_schedule_controller.dart';
import 'package:admin/features/schedule/application/state/new_schedule_state.dart';
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
class NewScheduleScreen extends ConsumerStatefulWidget {
  static const routeName = '/new-schedule';

  const NewScheduleScreen({super.key});

  @override
  ConsumerState<NewScheduleScreen> createState() => _NewScheduleScreenState();
}

class _NewScheduleScreenState extends ConsumerState<NewScheduleScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<NewScheduleState>>(newScheduleControllerProvider,
        (previous, next) {
      next.when(
          data: (data) {
            if (data.status == FormzSubmissionStatus.success) {
              CustomSnackbar.show(
                  context: context,
                  type: ToastType.SUCCESS,
                  text: AppLocalizations.of(context)!.newScheduleAdded);
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

    final title = ref.watch(newScheduleControllerProvider).value?.title;
    final notifier = ref.read(newScheduleControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          AppLocalizations.of(context)!.newSchedule,
          textType: TextType.H1,
        ),
      ),
      body: Stack(
        children: [
          FormSchedule(
            titleController: _titleController,
            descController: _descController,
            onChangedTitle: (value) => notifier.updateTitle(value),
            titleValidator: (value) => title?.error?.getMessage(),
            enabledButton: notifier.isValidForm(),
            onConfirm: (date, time) {
              notifier.createSchedule(
                description: _descController.text,
                date: date,
                time: time,
              );
            },
          ),
          Consumer(
            builder: (context, ref, child) {
              final state = ref.watch(newScheduleControllerProvider);

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
