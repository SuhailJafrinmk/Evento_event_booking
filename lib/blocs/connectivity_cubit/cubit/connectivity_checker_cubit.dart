import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
part 'connectivity_checker_state.dart';

class ConnectivityCheckerCubit extends Cubit<InternetStatus> {
  ConnectivityCheckerCubit() : super(const InternetStatus(ConnectivityStatus.disconnected)){
    checkConnectivity();
  }
  
void checkConnectivity()async{
  var connectivityResult=await Connectivity().checkConnectivity();
  updateConnectivityStatus(connectivityResult);
}
void updateConnectivityStatus(List<ConnectivityResult> results)async{
if(results.contains(ConnectivityResult.mobile)||results.contains(ConnectivityResult.wifi)){
  emit(const InternetStatus(ConnectivityStatus.connected));
}else{
  emit(const InternetStatus(ConnectivityStatus.disconnected));
}
}

late StreamSubscription <List<ConnectivityResult?>> subscription;

void trackConnectivityChange(){
  subscription=Connectivity().onConnectivityChanged.listen((result){
    updateConnectivityStatus(result);
  });
}

@override
  Future<void> close() {
    subscription.cancel();
    return super.close();
  }

}

