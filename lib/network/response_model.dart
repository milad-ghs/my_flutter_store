class ResponseModel<T>{
  late Status status;
  late T data;
  late String message;


  ResponseModel.loading(this.message) : status = Status.loading;
  ResponseModel.completed(this.data) : status = Status.completed;
  ResponseModel.error(this.message) : status = Status.error;

}


enum Status {loading , completed , error}