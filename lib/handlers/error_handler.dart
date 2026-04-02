import 'package:complite/errors/app_error.dart';

void errorHandler(AppError error) {
  if (error is NoInternetError) {
    print('erro');
  }else if (error is AuthExpiredError) {
    print("Auth expired");
  } else if (error is ServerError) {
    print("server error");
  } else if (error is ParsingError) {
    print("parsing error");
  } else {
    print('unhandle error');
  }
}