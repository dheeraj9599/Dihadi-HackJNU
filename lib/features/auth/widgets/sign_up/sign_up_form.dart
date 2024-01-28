import 'dart:developer';

import 'package:dihadi/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../../../constants/ui_constants.dart';
import '../../../../core/common/loader.dart';
import '../../../../core/common/logo_text.dart';
import '../../../../core/common/rounded_button.dart';
import '../../../../constants/app_constant.dart';
import '../../../../constants/campus_data.dart';
import '../../../../core/common/dropdown_button.dart';
import '../../../../core/utils/color_utility.dart';
import '../../../../core/utils/form_validation.dart';
import '../../../../core/utils/snackbar.dart';
import '../form_text_field.dart';

class SignUpForm extends ConsumerStatefulWidget {
  final Size size;
  final TextTheme textTheme;

  const SignUpForm({
    super.key,
    required this.size,
    required this.textTheme,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpFormState();
}

class _SignUpFormState extends ConsumerState<SignUpForm> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  
  final nameController = TextEditingController();
  String? role;
  List<String> selectedSkills = [];
  final dobController = TextEditingController();
  final phoneController = TextEditingController();
  final aboutController = TextEditingController();
  final experienceController = TextEditingController();
  final serviceController = TextEditingController();
  final portfolioUrlController = TextEditingController();

  void registerWithEmailAndPassword() {
    ref.read(authControllerProvider.notifier).registerWithEmailAndPassword(
         email: emailController.text.trim(),
          password: passwordController.text,
          name: nameController.text.trim(),
          dob: dobController.text.trim(),
          phone: phoneController.text.trim(),
          about: aboutController.text.trim(),
          experience: experienceController.text.trim(),
          skills: selectedSkills,
          service: serviceController.text.trim(),
          portfolioUrl: portfolioUrlController.text.trim(),
          role: role!,
          context: context,
        );
  }

  @override
  void dispose() {
    super.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();

  }

  @override
  Widget build(BuildContext context) {
    final validationService = ref.watch(validationServiceProvider);
    final loading = ref.watch(authControllerProvider);
    return Padding(
      padding:
          EdgeInsets.only(top: widget.size.height * 0.15, left: 18, right: 18),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: widget.size.width * 0.1),
                child: LogoText(),
              ),
              const SizedBox(
                height: 48,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: widget.size.width * 0.1),
                child: CustomFormTextField(
                  controller: emailController,
                  textTheme: widget.textTheme,
                  validator: (value) => validationService.validateEmail(value!),
                  hint: EMAIL_AUTH_HINT,
                  suffixIcon: Icons.person,
                  isPassword: false,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.size.width * 0.1,
                ),
                child: CustomFormTextField(
                  controller: nameController,
                  textTheme: widget.textTheme,
                  validator: (val) => validationService.validateName(val!),
                  hint: NAME_AUTH_HINT,
                  suffixIcon: Icons.person,
                  isPassword: false,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              ////////////////////////////////////////////////////////////
              ///
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.size.width * 0.1,
                ),
                child: CustomFormTextField(
                  controller: experienceController,
                  textTheme: widget.textTheme,
                  validator: (val) => validationService.validateRollNumber(val!),
                  hint: 'Experience in years',
                  suffixIcon: Icons.school,
                  isPassword: false,
                ),
              ),
              const SizedBox(
                height: 24,
              ),Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.size.width * 0.1,
                ),
                child: CustomFormTextField(
                  controller: serviceController,
                  textTheme: widget.textTheme,
                  validator: (val) => validationService.validateName(val!),
                  hint: 'Service',
                  suffixIcon: Icons.work,
                  isPassword: false,
                ),
              ),
              const SizedBox(
                height: 24,
              ),Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.size.width * 0.1,
                ),
                child: CustomFormTextField(
                  controller: portfolioUrlController,
                  textTheme: widget.textTheme,
                  validator: (val) => validationService.validateName(val!),
                  hint: 'Portfolio Url',
                  suffixIcon: Icons.person,
                  isPassword: false,
                ),
              ),
              
              const SizedBox(
                height: 24,
              ),Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.size.width * 0.1,
                ),
                child: CustomFormTextField(
                  controller: aboutController,
                  textTheme: widget.textTheme,
                  validator: (val) => validationService.validateName(val!),
                  hint: 'About you',
                  suffixIcon: Icons.person,
                  isPassword: false,
                ),
              ),
               const SizedBox(
                height: 24,
              ),Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.size.width * 0.1,
                ),
                child: CustomFormTextField(
                  controller: dobController,
                  textTheme: widget.textTheme,
                  validator: (val) => validationService.validateName(val!),
                  hint: 'Dob',
                  suffixIcon: Icons.person,
                  isPassword: false,
                ),
              ),
              const SizedBox(
                height: 24,
              ),///////////////////////////////////
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.size.width * 0.1,
                ),
                child: CustomFormTextField(
                  controller: phoneController,
                  textTheme: widget.textTheme,
                  validator: (val) =>
                      validationService.validateRollNumber(val!),
                  hint: 'Phone No',
                  suffixIcon: Icons.person,
                  isPassword: false,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                 padding: EdgeInsets.symmetric(
                  horizontal: widget.size.width * 0.1,
                ),
                child: MultiSelectDropDown(
                  
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
              ),
                      const SizedBox(
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.size.width * 0.1,
                ),
                child: SizedBox(
                  height: 63,
                  child: CustomDropdown<String>(
                    labelText: '',
                    items: UiConstants.userRoles,
                    value: role,
                    onChanged: (newRole) {
                      setState(() {
                        role = newRole;
                      });
                    },
                    hintText: 'Select Role',
                    validator: (value) =>
                        validationService.validateSelectCampus(value),
                  ),
                ),
              ),
            
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.size.width * 0.1,
                ),
                child: CustomFormTextField(
                  controller: passwordController,
                  textTheme: widget.textTheme,
                  validator: (val) => validationService.validatePassword(val!),
                  hint: PASSWORD_AUTH_HINT,
                  suffixIcon: Icons.lock,
                  isPassword: true,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: widget.size.width * 0.1),
                child: CustomFormTextField(
                  controller: confirmPasswordController,
                  textTheme: widget.textTheme,
                  validator: (val) => validationService.validateConfirmPassword(
                    val!,
                    passwordController.text,
                  ),
                  hint: CONFIRM_PASSWORD_AUTH_HINT,
                  suffixIcon: Icons.lock,
                  isPassword: true,
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              Align(
                alignment: FractionalOffset.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(right: widget.size.width * 0.05),
                  child: SizedBox(
                    width: 200,
                    child: loading
                        ? const Loader()
                        : RoundedButton(
                            text: BUTTON_SIGNUP,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                FocusScope.of(context).unfocus();
                                registerWithEmailAndPassword();
                              }
                            },
                            linearGradient: LinearGradient(
                              begin: FractionalOffset.bottomLeft,
                              end: FractionalOffset.topRight,
                              colors: [
                                Color(
                                  getColorHexFromStr(
                                    "#FF7539",
                                  ),
                                ),
                                Color(
                                  getColorHexFromStr(
                                    "#FE6763",
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
