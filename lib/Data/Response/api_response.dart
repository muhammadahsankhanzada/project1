// Enums for status
enum Status { LOADING, COMPLETED, ERROR }

// Class to check that api response is loading, completed or returned an error
class ApiResponse<DataType> {
  Status? status;
  DataType? data;
  String? message;

  ApiResponse([this.status, this.data, this.message]);

  ApiResponse.loading() : status = Status.LOADING;
  ApiResponse.completed() : status = Status.COMPLETED;
  ApiResponse.error() : status = Status.ERROR;

  @override
  String toString() {
    return 'Status: $status \nMessage: $message \nData: $data';
  }
}
