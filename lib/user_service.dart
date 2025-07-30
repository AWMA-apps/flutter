import 'package:dio/dio.dart';
import 'package:user_input/user.dart';

class UserService{
    late Dio _dio ;
    final String url="https://jsonplaceholder.typicode.com";
    String? _authToken;

    UserService(){
        _dio=Dio(BaseOptions(
            baseUrl: url,
            connectTimeout: Duration(seconds: 5),
            headers: {
                "Content-Type":"application/json"
            }
        ));
       _dio.interceptors.add(QueuedInterceptorsWrapper(
          onRequest: (options, handler) {
            if(options.data !=null){
                //print("Options.data= ${options.data.toString()}");
                options.headers['Authentication']='Bearer $_authToken';
            }
            return handler.next(options);
          },
       ));
    }

    Future<List<User>> fetchUsers() async{
        try{
            final response = await _dio.get("/users");

            if (response.statusCode == 200) {
                List<dynamic> resData = response.data;
                return resData.map((e) => User.fromResponse(e)).toList();
            } else {
                throw Exception("Failed to load users: ${response.statusCode}");
            }
        }on DioException catch (e){
            if (e.response != null) {
                String error = "Dio Error!";
                error += "\nStatus: ${e.response?.statusCode}";
                error += "\nurl: ${e.response?.requestOptions.uri}";
                error += "\nHeaders: ${e.response?.headers}";
                //print(error);
                throw Exception("Server Error: ${e.response?.statusCode}\n\nError: $error}");
            } else {
                //print("Error Sending Request!");
               // print(e.message);
                throw Exception("Network Error; ${e.message}");
            }
        }catch (e){
           // print('An unexpected error occurred: $e');
            throw Exception('An unexpected error occurred: $e');
        }
    }

    void tryInterceptors() async{
        _dio.interceptors.add(
            InterceptorsWrapper(
                onRequest: (options, handler) {
                    return handler.resolve(
                        Response(requestOptions: options, data: 'fake data')
                    );
                }
            )
        );
        final response = await _dio.get('/users');
       // print(response.data); // 'fake data'
    }
}