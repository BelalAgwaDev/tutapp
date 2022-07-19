import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:tutapp/presentation/common/stateRender/state_render_enum.dart';
import 'package:tutapp/presentation/resources/assest_manger.dart';
import 'package:tutapp/presentation/resources/color_manger.dart';
import 'package:tutapp/presentation/resources/fonts_manger.dart';
import 'package:tutapp/presentation/resources/strings_manger.dart';
import 'package:tutapp/presentation/resources/styles_manger.dart';
import 'package:tutapp/presentation/resources/values_manger.dart';

class StateRenderScreen extends StatelessWidget {
  final StateRenderType stateRenderType;
  final String message;
  final String title;
  final Function retryActionFunction;
  const StateRenderScreen(
      {Key? key,
     required this.message ,
      required this.retryActionFunction,
      required this.stateRenderType,
      this.title = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getData(context);
  }

  Widget _getData(context) {
    switch (stateRenderType) {
      case StateRenderType.popupLoadingState:
        return _getPopupDialog(context, [
          const SizedBox(height: AppSizeMange.s40,),
          _getAnimaImage(AppJson.loading),
          const SizedBox(height: AppSizeMange.s40,),
        ]);

      case StateRenderType.popupSuccess:
        return _getPopupDialog(context, [
          const SizedBox(height: AppSizeMange.s40,),
          _getAnimaImage(AppJson.success),
          const SizedBox(height: AppSizeMange.s40,),
        ]);


      case StateRenderType.popupErrorState:
        return _getPopupDialog(context, [
          const SizedBox(height: AppSizeMange.s40,),
          _getAnimaImage(AppJson.error),
          const SizedBox(height: AppSizeMange.s20,),
          _getMessage(message),
          _getRetryAgain(AppStringsManger.ok, context)
        ]);

      case StateRenderType.fullScreenLoadingState:
        return _getItemColumn([
          _getAnimaImage(AppJson.loading),
          _getMessage(message),
        ]);

      case StateRenderType.fullScreenErrorState:
        return _getItemColumn([
          _getAnimaImage(AppJson.error),
          _getMessage(message),
          _getRetryAgain(AppStringsManger.retryAgain, context),
        ]);

      case StateRenderType.fullScreenEmptyState:
        return _getItemColumn([
          _getAnimaImage(AppJson.empty),
          _getMessage(message),
        ]);
      case StateRenderType.contentState:
        return Container();

      default:
        return Container();
    }
  }

  Widget _getPopupDialog(BuildContext context, List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizeMange.s14),
      ),
      elevation: AppSizeMange.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: ColorManger.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(AppSizeMange.s14),
            boxShadow: const [BoxShadow(color: Colors.black26)]),
        child: _getDialogContent(context, children),
      ),
    );
  }

  Widget _getDialogContent(BuildContext context, List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getItemColumn(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getAnimaImage(String image) {
    return SizedBox(
      height: AppSizeMange.s96,
      width: AppSizeMange.s96,
      child: Lottie.asset(image),
    );
  }

  Widget _getMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPaddingSizeMange.p8),
        child: Text(
          message,
          style: getRegularStyle(
              fontSize: FontSizeManger.s16, color: ColorManger.black),
        ),
      ),
    );
  }

  Widget _getRetryAgain(String bottomTitle, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPaddingSizeMange.p18),
        child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  if (stateRenderType == StateRenderType.fullScreenErrorState) {
                    //call retry function
                    retryActionFunction.call();
                  } else {
                    // popup error state
                    Navigator.of(context).pop();
                  }
                },
                child: Text(bottomTitle))),
      ),
    );
  }
}
