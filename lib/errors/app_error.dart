abstract class AppError {}
class AuthExpiredError extends AppError{}
class ServerError extends AppError{}
class NoInternetError extends AppError{}
class ParsingError extends AppError{}
class BusinessLogicError extends AppError{
  final String message;
  BusinessLogicError(this.message);
}