class ErrorResponseModel{
  String _errorMsg;
  String _errorDescription;
  Map<String, dynamic>? _errorAction;

  ErrorResponseModel(this._errorMsg, this._errorDescription);

  ErrorResponseModel.action(this._errorMsg, this._errorDescription, this._errorAction);

  String get errorDescription => _errorDescription;

  set errorDescription(String value) {
    _errorDescription = value;
  }

  String get errorMsg => _errorMsg;

  set errorMsg(String value) {
    _errorMsg = value;
  }

  Map<String, dynamic>? get errorAction => _errorAction;

  set errorAction(Map<String, dynamic>? value) {
    _errorAction = value;
  }
}