

import 'package:myapp/core/data/model/rest_api_error_model.dart';
import 'package:myapp/core/domain/app_error/app_error.dart';

extension ErrorConverter on List<RestApiValidationErrorModel> {
  Iterable<ValidationError> get asAppErrors sync* {
    for (final restApiError in this) {
      for (final errorDescription in restApiError.errorList) {
        yield ValidationError(errorDescription.code, restApiError.fieldName);
      }
    }
  }
}