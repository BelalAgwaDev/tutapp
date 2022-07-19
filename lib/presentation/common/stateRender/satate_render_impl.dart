import 'package:flutter/material.dart';
import 'package:tutapp/application/constants.dart';
import 'package:tutapp/presentation/common/stateRender/state_render_enum.dart';
import 'package:tutapp/presentation/common/stateRender/state_render_widget.dart';
import 'package:tutapp/presentation/resources/strings_manger.dart';

abstract class FlowState {
  StateRenderType getStateRenderType();
  String getMessage();
}

//loading state (popUp ,full screen)

class LoadingState extends FlowState {
  StateRenderType stateRenderType;
  String message;
  LoadingState(
      {required this.stateRenderType, this.message = AppStringsManger.loading});

  @override
  String getMessage() => message;

  @override
  StateRenderType getStateRenderType() => stateRenderType;
}

//error state (popUp ,full screen)

class ErrorState extends FlowState {
  StateRenderType stateRenderType;
  String message;
  ErrorState({required this.stateRenderType, required this.message});

  @override
  String getMessage() => message;

  @override
  StateRenderType getStateRenderType() => stateRenderType;
}


//error state (popUp ,full screen)

class SuccessState extends FlowState {
  StateRenderType stateRenderType;
  String message;
  SuccessState(
      {required this.stateRenderType, this.message = AppStringsManger.loading});

  @override
  String getMessage() => message;

  @override
  StateRenderType getStateRenderType() => stateRenderType;
}


//content state
class ContentState extends FlowState {
  ContentState();

  @override
  String getMessage() => Constant.empty;

  @override
  StateRenderType getStateRenderType() => StateRenderType.contentState;
}

//empty state
class EmptyState extends FlowState {
  String message;
  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRenderType getStateRenderType() => StateRenderType.fullScreenEmptyState;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (runtimeType) {
      case LoadingState:
        {
          if (getStateRenderType() == StateRenderType.popupLoadingState) {
            //show popup loading
            showPopUp(context, getStateRenderType(), getMessage());
            // show content ui of screen
            return contentScreenWidget;
          } else {
            //full screen state loading state
            return StateRenderScreen(
              message: getMessage(),
              retryActionFunction: retryActionFunction,
              stateRenderType: getStateRenderType(),
            );
          }
        }
      case SuccessState:
        {
          dismissDialog(context);
          if (getStateRenderType() == StateRenderType.popupSuccess) {
            //show popup loading
            showPopUp(context, getStateRenderType(), getMessage());
            // show content ui of screen
            return contentScreenWidget;
          } else {
            //full screen state loading state
            return StateRenderScreen(
              message: getMessage(),
              retryActionFunction: retryActionFunction,
              stateRenderType: getStateRenderType(),
            );
          }
        }


      case ErrorState:
        {
          dismissDialog(context);
          if (getStateRenderType() == StateRenderType.popupErrorState) {
            //show popup error
            showPopUp(context, getStateRenderType(), getMessage());
            // show content ui of screen
            return contentScreenWidget;
          } else {
            //full screen state error state
            return StateRenderScreen(
              message: getMessage(),
              retryActionFunction: retryActionFunction,
              stateRenderType: getStateRenderType(),
            );
          }
        }



      case ContentState:
        {
          dismissDialog(context);
          return contentScreenWidget;
        }

      case EmptyState:
        {
          return StateRenderScreen(
              stateRenderType: getStateRenderType(),
              message: getMessage(),
              retryActionFunction: () {});
        }

      default:
        {
          dismissDialog(context);
          return contentScreenWidget;
        }
    }
  }

  _isCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;
  dismissDialog(BuildContext context) {
    if (_isCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  showPopUp(
      BuildContext context, StateRenderType stateRenderType, String message) {
    WidgetsBinding.instance?.addPostFrameCallback((_) => showDialog(
        context: context,
        builder: (BuildContext context) => StateRenderScreen(
          stateRenderType: stateRenderType, retryActionFunction: () {}, message:message ,)));
  }
}