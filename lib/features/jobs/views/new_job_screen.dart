import 'package:dihadi/core/utils/extensions/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../../constants/app_constant.dart';
import '../../../constants/campus_data.dart';
import '../../../constants/ui_constants.dart';
import '../../../core/common/dropdown_button.dart';
import '../../../core/common/form_input_heading.dart';
import '../../../core/common/loader.dart';
import '../../../core/common/rounded_button.dart';
import '../../../core/common/text_input_field.dart';
import '../../../core/enums/enums.dart';
import '../../../core/utils/form_validation.dart';
import '../../../routes/route_utils.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_style.dart';
import '../controller/job_controller.dart';

class NewJobFormScreen extends ConsumerStatefulWidget {
  const NewJobFormScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NewJobFormScreenState();
}

class _NewJobFormScreenState extends ConsumerState<NewJobFormScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController responsibilityController =
      TextEditingController();
  final TextEditingController contactDetailsController =
      TextEditingController();
  List<String> selectedSkills = [];

  DateTime selectedDate = DateTime.now();

  void saveJobToDatabase() {
    ref.read(jobControllerProvider.notifier).saveJobToDatabase(
          title: titleController.text,
          contact: contactDetailsController.text,
          context: context,
          responsibility: responsibilityController.text,
          skills: [],
          startDate: selectedDate,
          ref: ref,
        );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(
          days: 100000,
        ),
      ),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    responsibilityController.dispose();
    contactDetailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final validationService = ref.watch(validationServiceProvider);
    final loading = ref.watch(jobControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Job',
          style: AppTextStyle.displayBlack.copyWith(
            color: AppColors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: AppColors.black,
            size: 30,
          ),
          onPressed: () => Navigation.navigateToBack(context),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                TextInputFieldWithToolTip(
                  controller: titleController,
                  toolTipMessage: 'Enter the Title of Job (Required)',
                  tipText: 'Job Title',
                  hintText: 'Job The Title',
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter a Title'
                      : null,
                  maxLines: 2,
                  maxLength: 80,
                ),
                const SizedBox(height: 16.0),
                TextInputFieldWithToolTip(
                  controller: responsibilityController,
                  toolTipMessage: 'please enter the responsibility of the Job',
                  tipText: 'Responsibility',
                  hintText: 'Enter Responsibility',
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter the responsibility of Job'
                      : null,
                  maxLines: 5,
                  maxLength: 1000,
                ),
                const SizedBox(height: 16.0),
                TextInputFieldWithToolTip(
                  controller: contactDetailsController,
                  toolTipMessage: 'Enter the Contact',
                  tipText: 'Contact',
                  hintText: 'Enter Contact',
                  validator: (value) =>
                      validationService.validateRegistrationLink(value!),
                  maxLines: 2,
                  maxLength: 1000,
                ),
                const SizedBox(height: 16.0),
                Column(
                  children: [
                    const FormInputHeading(
                      tipMessage: 'Select Skills',
                      heading: 'Select Skills',
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    MultiSelectDropDown(
                      showClearIcon: true,
                      onOptionSelected: (options) {
                        debugPrint(options.toString());
                        setState(() {
                          selectedSkills = options
                              .map((item) => item.value.toString())
                              .toList();
                        });
                      },
                      options: ['Others', ...skills]
                          .map(
                            (e) => ValueItem(
                              label: e,
                              value: e,
                            ),
                          )
                          .toList(),
                      selectionType: SelectionType.multi,
                      chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                      dropdownHeight: 300,
                      optionTextStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.6),
                      ),
                      selectedOptionIcon: const Icon(Icons.check_circle),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Column(
                  children: [
                    const FormInputHeading(
                      tipMessage: 'Please choose the start date for this Job',
                      heading: 'Start Date',
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () => _selectDate(context),
                          child: Text('Select Date'),
                        ),
                        Text('Selected Date: ${selectedDate.toLocal()}'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                loading
                    ? const Loader()
                    : RoundedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            saveJobToDatabase();
                          }
                        },
                        text: 'Submit',
                        linearGradient: AppColors.roundedButtonGradient,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
