import 'package:flutter/material.dart';
import 'package:my_profile/values/app_colors.dart';

class SkillExperienceItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool isEditable;
  final Function()? onEdit;
  const SkillExperienceItem(
      {Key? key,
        required this.title,
        required this.subTitle,
        this.isEditable = false,
        this.onEdit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 6.0,
        color: AppColors.colorPrimary,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 10),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(20),
              )),


        child: Padding(
          padding: const EdgeInsets.only(right: 8.0, top:8.0, bottom:8.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style:
                       const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    isEditable
                        ? GestureDetector(
                        onTap: onEdit, child:  Icon(Icons.edit, color: AppColors.colorPrimary,))
                        : Container()
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  subTitle,
                  style: const TextStyle(fontSize: 16, height: 1.4),
                ),
              ],
            ),
          ),
        ),
      ),
      )
    );
  }
}