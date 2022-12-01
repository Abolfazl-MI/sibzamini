abstract class DataState<T>{
  final T?data;
  final String ? error;
  DataState({this.data,this.error});
}

class DataSuccesState<T> extends DataState<T>{
  DataSuccesState(T?data):super(data: data,error: null);
}
class DataFailState<T> extends DataState<T>{
  DataFailState(String error):super(error: error,data: null);
}