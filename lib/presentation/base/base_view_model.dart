import 'dart:async';

import 'package:tutapp/presentation/common/stateRender/satate_render_impl.dart';

abstract class BaseViewModel extends BaseViewModelInput
    with BaseViewModelOutput {
  //shared variable and function that will be used through any view model.
  final StreamController _inputStreamController=StreamController<FlowState>.broadcast();

  @override
  void dispose() {
    _inputStreamController.close();
  }

  @override
  Stream<FlowState> get outputState => _inputStreamController.stream.map((flow) => flow);

  @override
  Sink get inputState => _inputStreamController.sink;
}

abstract class BaseViewModelInput {
  void start(); //start view model job
  
  void dispose(); //dies view model job

Sink get inputState;
}

abstract class BaseViewModelOutput {
  //will be implement later
  Stream<FlowState> get outputState;
}
