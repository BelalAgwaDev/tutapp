abstract class BaseViewModel extends BaseViewModelInput
    with BaseViewModelOutput {
  //shared variable and function that will be used through any view model.
}

abstract class BaseViewModelInput {
  void start(); //start view model job
  
  void dispose(); //dies view model job
}

abstract class BaseViewModelOutput {
  //will be implement later
}
