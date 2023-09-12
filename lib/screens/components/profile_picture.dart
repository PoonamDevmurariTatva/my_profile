import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../bloc/profile/profile_cubit.dart';
import '../../values/app_colors.dart';
import '../../values/app_strings.dart';

class ProfilePicture extends StatelessWidget {
  final bool isEditable;

  const ProfilePicture({Key? key, this.isEditable = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) => current is! ProfileError,
      builder: (context, state) {
        var cubit = context.read<ProfileCubit>();
        return Center(
          child: Stack(
            children: [
              Container(
                width: 128,
                height: 128,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: cubit.getProfilePicture(), fit: BoxFit.cover),
                    shape: BoxShape.circle,
                    border:
                    Border.all(color: AppColors.colorBlack, width: 2.0)),
              ),
              Visibility(
                visible: isEditable,
                child: Positioned(
                  bottom: 0,
                  right: 17,
                  child: GestureDetector(
                    onTap: () {
                      _showImageDialog(context);
                    },
                    child: ClipOval(
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        color: AppColors.colorWhite,
                        child: ClipOval(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            color: AppColors.colorPrimary,
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  _showImageDialog(BuildContext context) {
    final ImagePicker picker = ImagePicker();
    OverlayEntry? overlayEntry;
    var overlayState = Overlay.of(context);
    var cubit = context.read<ProfileCubit>();
    overlayEntry = OverlayEntry(builder: (context) {
      return Stack(
        children: [
          Opacity(
            opacity: 0.4,
            child: Container(
              color: Colors.black,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 600,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 1),
                // decoration: ,
                child: ElevatedButton(
                  style: ButtonStyle(
                      padding:
                      MaterialStateProperty.all(const EdgeInsets.all(16.0)),
                      shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15.0),
                                topRight: Radius.circular(15.0)),
                          )),
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () async {
                    overlayEntry?.remove();
                    FocusManager.instance.primaryFocus?.unfocus();
                    final pickedFile = await picker.pickImage(source: ImageSource.camera);
                    if (pickedFile != null) {
                      File? file = File(pickedFile.path);
                      cubit.changeProfileData("avatar", file.path);
                    }
                  },
                  child: Text(
                    AppStrings.camera,
                    style: TextStyle(color: AppColors.colorBlack),
                  ),
                ),
              ),
              Container(
                width: 600,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                // decoration: ,
                child: ElevatedButton(
                  style: ButtonStyle(
                      padding:
                      MaterialStateProperty.all(const EdgeInsets.all(16.0)),
                      shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15.0),
                                bottomRight: Radius.circular(15.0)),
                          )),
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () async {
                    overlayEntry?.remove();

                    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      File? file = File(pickedFile.path);
                      cubit.changeProfileData("avatar", file.path);
                    }
                  },
                  child: Text(
                    AppStrings.gallery,
                    style: TextStyle(color: AppColors.colorBlack),
                  ),
                ),
              ),
              Container(
                width: 600,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                // decoration: ,
                child: ElevatedButton(
                  style: ButtonStyle(
                      padding:
                      MaterialStateProperty.all(const EdgeInsets.all(16.0)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      )),
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () {
                    overlayEntry?.remove();
                  },
                  child: Text(
                    AppStrings.cancel,
                    style: TextStyle(color: AppColors.colorBlack),
                  ),
                ),
              ),
            ],
          )
        ],
      );
    });

    overlayState.insert(overlayEntry);
  }
}