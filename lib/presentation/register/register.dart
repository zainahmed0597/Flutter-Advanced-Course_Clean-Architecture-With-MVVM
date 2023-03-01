import 'dart:io';

// import 'package:country_code_picker/country_code_picker.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_1/app/di.dart';
import 'package:project_1/presentation/register/register_viewmodel.dart';
import '../common/state_renderer/state_render_impl.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/values_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  RegisterViewModel _viewModel = instance<RegisterViewModel>();
  ImagePicker picker = instance<ImagePicker>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _userNameTextEditingController =
      TextEditingController();
  TextEditingController _mobileNumberTextEditingController =
      TextEditingController();
  TextEditingController _emailEditingController = TextEditingController();
  TextEditingController _PasswordTextEditingController =
      TextEditingController();

  final countryPicker = const FlCountryCodePicker();
  CountryCode? countryCodeSelected;

  @override
  void initState() {
    _bind();
    super.initState();
  }

  _bind() {
    _viewModel.start();
    _userNameTextEditingController.addListener(() {
      _viewModel.setUserName(_userNameTextEditingController.text);
    });
    _mobileNumberTextEditingController.addListener(() {
      _viewModel.setMobileNumber(_mobileNumberTextEditingController.text);
    });
    _emailEditingController.addListener(() {
      _viewModel.setEmail(_emailEditingController.text);
    });
    _PasswordTextEditingController.addListener(() {
      _viewModel.setPassword(_PasswordTextEditingController.text);
    });
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        elevation: AppSize.s0,
        iconTheme: IconThemeData(color: ColorManager.primary),
        backgroundColor: ColorManager.white,
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return Center(
            child: snapshot.data?.getScreenWidget(context, _getContentWidget(),
                    () {
                  _viewModel.register();
                }) ??
                _getContentWidget(),
          );
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Container(
      padding: EdgeInsets.only(top: AppPadding.p0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image(image: AssetImage(ImageAssets.splashLogo)),
              SizedBox(height: AppSize.s12),
              // Name TextEditField
              Padding(
                padding: EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<String?>(
                  stream: _viewModel.outputErrorUserName,
                  builder: (context, snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _userNameTextEditingController,
                      decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(AppSize.s12),
                            ),
                            borderSide: BorderSide(
                                color: ColorManager.error, width: AppSize.s1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(AppSize.s12),
                            ),
                            borderSide: BorderSide(
                                color: ColorManager.primary, width: AppSize.s1),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(AppSize.s12),
                            ),
                            borderSide: BorderSide(
                                color: ColorManager.primary, width: AppSize.s1),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(AppSize.s12),
                            ),
                            borderSide: BorderSide(
                                color: ColorManager.error, width: AppSize.s1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(AppSize.s12),
                            ),
                            borderSide: BorderSide(
                                color: ColorManager.grey, width: AppSize.s1),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(AppSize.s12),
                            ),
                            borderSide: BorderSide(
                                color: ColorManager.grey, width: AppSize.s1),
                          ),
                          hintText: AppStrings.name,
                          labelText: AppStrings.name,
                          errorText: (snapshot.data)),
                    );
                  },
                ),
              ),
              SizedBox(height: AppSize.s12),
              // CountryCode and Mobile Number
              Padding(
                padding: EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<String?>(
                    stream: _viewModel.outputErrorMobileNumber,
                    builder: (context, snapshot) {
                      return TextFormField(
                        controller: _mobileNumberTextEditingController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        maxLines: 1,
                        decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(AppSize.s12),
                            ),
                            borderSide: BorderSide(
                                color: ColorManager.error, width: AppSize.s1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(AppSize.s12),
                            ),
                            borderSide: BorderSide(
                                color: ColorManager.primary, width: AppSize.s1),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(AppSize.s12),
                            ),
                            borderSide: BorderSide(
                                color: ColorManager.primary, width: AppSize.s1),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(AppSize.s12),
                            ),
                            borderSide: BorderSide(
                                color: ColorManager.error, width: AppSize.s1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(AppSize.s12),
                            ),
                            borderSide: BorderSide(
                                color: ColorManager.grey, width: AppSize.s1),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(AppSize.s12),
                            ),
                            borderSide: BorderSide(
                                color: ColorManager.grey, width: AppSize.s1),
                          ),
                          hintText: AppStrings.mobile_number,
                          labelText: AppStrings.mobile_number,
                          errorText: (snapshot.data),
                          prefixIcon: Container(
                            padding: const EdgeInsets.all(AppSize.s6),
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    final code = await countryPicker.showPicker(
                                        context: context);
                                    setState(() {
                                      countryCodeSelected = code;
                                      // update view model with selected code
                                      _viewModel.setCountryCode(
                                          countryCodeSelected.toString());
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        child: countryCodeSelected != null
                                            ? countryCodeSelected!.flagImage()
                                            : null,
                                      ),
                                      _sizeBox(),
                                      Text(
                                        countryCodeSelected?.dialCode ?? "+1",
                                        style:
                                            TextStyle(color: ColorManager.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(height: AppSize.s12),
              // Email TextEditField
              Padding(
                padding: EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<String?>(
                  stream: _viewModel.outputErrorEmail,
                  builder: (context, snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailEditingController,
                      decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(AppSize.s12),
                            ),
                            borderSide: BorderSide(
                                color: ColorManager.error, width: AppSize.s1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(AppSize.s12),
                            ),
                            borderSide: BorderSide(
                                color: ColorManager.primary, width: AppSize.s1),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(AppSize.s12),
                            ),
                            borderSide: BorderSide(
                                color: ColorManager.primary, width: AppSize.s1),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(AppSize.s12),
                            ),
                            borderSide: BorderSide(
                                color: ColorManager.error, width: AppSize.s1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(AppSize.s12),
                            ),
                            borderSide: BorderSide(
                                color: ColorManager.grey, width: AppSize.s1),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(AppSize.s12),
                            ),
                            borderSide: BorderSide(
                                color: ColorManager.grey, width: AppSize.s1),
                          ),
                          hintText: AppStrings.emailHint,
                          labelText: AppStrings.emailHint,
                          errorText: (snapshot.data)),
                    );
                  },
                ),
              ),
              SizedBox(height: AppSize.s12),
              // Password TextEditField
              Padding(
                padding: EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<String?>(
                  stream: _viewModel.outputErrorPassword,
                  builder: (context, snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: _PasswordTextEditingController,
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(AppSize.s12),
                          ),
                          borderSide: BorderSide(
                              color: ColorManager.error, width: AppSize.s1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(AppSize.s12),
                          ),
                          borderSide: BorderSide(
                              color: ColorManager.primary, width: AppSize.s1),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(AppSize.s12),
                          ),
                          borderSide: BorderSide(
                              color: ColorManager.primary, width: AppSize.s1),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(AppSize.s12),
                          ),
                          borderSide: BorderSide(
                              color: ColorManager.error, width: AppSize.s1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(AppSize.s12),
                          ),
                          borderSide: BorderSide(
                              color: ColorManager.grey, width: AppSize.s1),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(AppSize.s12),
                          ),
                          borderSide: BorderSide(
                              color: ColorManager.grey, width: AppSize.s1),
                        ),
                        hintText: AppStrings.password,
                        labelText: AppStrings.password,
                        errorText: (snapshot.data),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: AppSize.s12),
              // Profile Picture TextEditField
              Padding(
                padding: EdgeInsets.only(
                  left: AppPadding.p28,
                  right: AppPadding.p28,
                ),
                child: Container(
                  height: AppSize.s45,
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorManager.lightGrey),
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppSize.s12),
                    ),
                  ),
                  child: GestureDetector(
                    child: _getMediaWidget(),
                    onTap: () {
                      _showPicker(context);
                    },
                  ),
                ),
              ),
              SizedBox(height: AppSize.s12),
              // Register Button
              Padding(
                padding: EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<bool>(
                  stream: _viewModel.outputIsAllInputsValid,
                  builder: (context, snapshot) {
                    return SizedBox(
                      width: double.infinity,
                      height: AppSize.s40,
                      child: ElevatedButton(
                          onPressed: (snapshot.data ?? false)
                              ? () {
                                  _viewModel.register();
                                }
                              : null,
                          child: Text(AppStrings.register)),
                    );
                  },
                ),
              ),
              //  Login Button Already have an account?
              Padding(
                padding: EdgeInsets.only(
                  top: AppPadding.p8,
                  left: AppPadding.p28,
                  right: AppPadding.p28,
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    AppStrings.haveAccount,
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imagePickedByUser(File? image) {
    if (image != null && image.path.isNotEmpty) {
      return Image.file(image);
    } else {
      return Container();
    }
  }

  Widget _sizeBox() {
    if (countryCodeSelected != null) {
      return const SizedBox(
        width: AppSize.s14,
      );
    } else {
      return const SizedBox(
        width: AppSize.s0,
      );
    }
  }

  _showPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  trailing: Icon(Icons.arrow_forward),
                  leading: Icon(Icons.camera),
                  title: Text(AppStrings.photoGallery),
                  onTap: () {
                    _imageFromGallery();
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  trailing: Icon(Icons.arrow_forward),
                  leading: Icon(Icons.camera_alt_rounded),
                  title: Text(AppStrings.photoCamera),
                  onTap: () {
                    _imageFromCamera();
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          );
        });
  }

  _imageFromGallery() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    _viewModel.setProfilePicture(File(image?.path ?? ""));
  }

  _imageFromCamera() async {
    var image = await picker.pickImage(source: ImageSource.camera);
    _viewModel.setProfilePicture(File(image?.path ?? ""));
  }

  Widget _getMediaWidget() {
    return Padding(
      padding: EdgeInsets.only(left: AppPadding.p8, right: AppPadding.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Text(AppStrings.profilePicture)),
          Flexible(
            child: StreamBuilder<File>(
              stream: _viewModel.outputProfilePicture,
              builder: (context, snapshot) {
                return _imagePickedByUser(snapshot.data);
              },
            ),
          ),
          Flexible(child: SvgPicture.asset(ImageAssets.photoCameraIc)),
        ],
      ),
    );
  }
}
