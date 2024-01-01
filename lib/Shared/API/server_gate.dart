import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import '../globals.dart';


class ServerGate {
// ignore: constant_identifier_names, non_constant_identifier_names
  // String? BASE_URL;
  final _dio = Dio();
  static final i = ServerGate._();
  ServerGate._() {
    addInterceptors();
  }
  // final firebaseCrashlytics = KiwiContainer().resolve<FirebaseCrashlyticsConfig>();

  CancelToken cancelToken = CancelToken();

  Map<String, dynamic> _header() {
    return {
      // if (User.i.isAuth) "Authorization": "Bearer ${User.i.token}",
      "Accept": "application/json",
      // "Accept-Language": LocaleKeys.lang.tr(),
    };
  }

  void addInterceptors() {
    _dio.interceptors.add(CustomApiInterceptor(logger));
  }

  // [][][][][][][][][][][][][] POST DATA TO SERVER [][][][][][][][][][][][][] //
  StreamController<double> onSingleReceive = StreamController.broadcast();

  Future<CustomResponse<T>> sendToServer<T>(
      {required String url,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? body,
      Map<String, dynamic>? params,
      T Function(dynamic)? callback,
      bool withoutHeader = false,
      String attribute = "data"}) async {
    // await _getBeaseUrl();
    if (body != null) {
      body.removeWhere(
        (key, value) => body[key] == null || body[key] == "",
      );
      logger.w("------ body for this req. -----");
      Map<String, String> buildBody =
          body.map((key, value) => MapEntry(key, value.toString()));
      logger.w(jsonEncode(buildBody));
    }
    if (params != null) {
      params.removeWhere(
        (key, value) => params[key] == null || params[key] == "",
      );
    }
    if (headers != null) {
      if (!withoutHeader) headers.addAll(_header());
      headers.removeWhere(
          (key, value) => headers![key] == null || headers[key] == "");
    } else {
      if (!withoutHeader) headers = _header();
    }

    try {
      Response response = await _dio.post(
        url.startsWith("http") ? url : "$BASE_URL/$url",
        data: withoutHeader ? body : FormData.fromMap(body ?? {}),
        onSendProgress: (received, total) {
          onSingleReceive.add((received / total) - 0.05);
          //  print((received / total * 100).toStringAsFixed(0) + "%");
        },
        queryParameters: params,
        options: Options(
          contentType: "application/json",
          headers: headers,
        ),
      );

      if (response.data is! Map) {
        response.data = {
          "message": kDebugMode
              ? response.data.toString()
              : "sorry_Something_went_wrong.tr()"
        };
        response.statusCode = 500;
        logger.e("\x1B[37m------ Current Error Response -----\x1B[0m");
        logger.e("\x1B[31m${response.data}\x1B[0m");
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        );
      }
      return CustomResponse<T>(
        success: true,
        statusCode: 200,
        errType: null,
        msg: response.data["message"] ?? "Your request completed succesfully",
        response: response,
        data: callback == null
            ? null
            : objectFromJson<T>(callback, response, attribute: attribute),
      );
    } on DioException catch (err) {
      return handleServerError(err);
    }
  }

  // ------- POST delete TO SERVER -------//
  Future<CustomResponse<T>> deleteFromServer<T>(
      {required String url,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? body,
      T Function(dynamic)? callback,
      Map<String, dynamic>? params,
      String attribute = "data"}) async {
    // await _getBeaseUrl();
    // remove nulls from body
    if (body != null) {
      body.removeWhere(
        (key, value) => body[key] == null || body[key] == "",
      );
    }
    if (params != null) {
      params.removeWhere(
        (key, value) => params[key] == null || params[key] == "",
      );
    }
    // add stander header
    if (headers != null) {
      headers.addAll(_header());
      headers.removeWhere(
          (key, value) => headers![key] == null || headers[key] == "");
    } else {
      headers = _header();
    }

    try {
      Response response = await _dio.delete(
        "$BASE_URL/$url",
        data: FormData.fromMap(body ?? {}),
        queryParameters: params,
        options: Options(
          headers: headers,
        ),
      );

      return CustomResponse<T>(
        success: true,
        statusCode: 200,
        errType: null,
        msg: response.data["message"] ?? "Your request completed succesfully",
        response: response,
        data: callback == null
            ? null
            : objectFromJson<T>(callback, response, attribute: attribute),
      );
    } on DioException catch (err) {
      return handleServerError(err);
    }
  }

  // ------- PUT DATA TO SERVER -------//
  Future<CustomResponse<T>> putToServer<T>({
    required String url,
    Map<String, dynamic>? headers,
    T Function(dynamic)? callback,
    Map<String, dynamic>? body,
  }) async {
    // await _getBeaseUrl();
    // remove nulls from body
    if (body != null) {
      body.removeWhere(
        (key, value) => body[key] == null || body[key] == "",
      );
    }
    // add stander header
    if (headers != null) {
      headers.addAll(_header());
      headers.removeWhere(
          (key, value) => headers![key] == null || headers[key] == "");
    } else {
      headers = _header();
    }

    try {
      Response response = await _dio.put(
        "$BASE_URL/$url",
        data: FormData.fromMap(body ?? {}),
        options: Options(
          headers: headers,
        ),
      );

      return CustomResponse<T>(
        success: true,
        statusCode: 200,
        errType: null,
        msg: response.data["message"] ?? "Your request completed succesfully",
        response: response,
        data: callback == null ? null : objectFromJson<T>(callback, response),
      );
    } on DioException catch (err) {
      return handleServerError(err);
    } catch (e) {
      final option = RequestOptions(path: "$BASE_URL/$url");
      return handleServerError(DioException(
        requestOptions: option,
        response: Response(
          requestOptions: option,
          data: {
            "message": " LocaleKeys.server_error_please_try_again_later.tr()"
          },
        ),
        type: DioExceptionType.badResponse,
      ));
    }
  }

  T objectFromJson<T>(T Function(dynamic) callback, Response response,
      {String? attribute}) {
    try {
      if (response.data != null) {
        if (attribute == "") return callback(response.data);
        if (response.data[attribute ?? "data"] != null) {
          return callback(response.data[attribute ?? "data"]);
        }
      }
      return callback(T is List ? <T>[] : <String, dynamic>{});
    } catch (e) {
      response.data = {
        "message": kDebugMode
            ? e.toString()
            : "LocaleKeys.sorry_Something_went_wrong.tr()"
      };
      response.statusCode = 500;
      logger.e("\x1B[37m------ Current Error Response -----\x1B[0m");
      logger.e("\x1B[31m${response.data}\x1B[0m");
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      );
    }
  }

  // ------ GET DATA FROM SERVER -------//
  Future<CustomResponse<T>> getFromServer<T>(
      {required String url,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? params,
      T Function(dynamic json)? callback,
      String? attribute,
      bool withoutHeader = false}) async {
    // await _getBeaseUrl();

    // add stander header
    if (!withoutHeader) {
      if (headers != null) {
        if (!withoutHeader) headers.addAll(_header());
        headers.removeWhere((key, value) => value == null || value == "");
      } else {
        if (!withoutHeader) headers = _header();
      }
    }
    // remove nulls from params
    if (params != null) {
      params.removeWhere(
          (key, value) => params[key] == null || params[key] == "");
    }

    try {
      Response response = await _dio.get(
        url.startsWith("http") ? url : "$BASE_URL/$url",
        options: Options(headers: headers),
        queryParameters: params,
      );
      if (response.data == null || response.data is! LinkedHashMap) {
        response.statusCode = 500;
        throw DioException(
            requestOptions: response.requestOptions, response: response);
      }
      return CustomResponse<T>(
        success: true,
        statusCode: 200,
        errType: null,
        msg: (response.data["message"] ?? "Your request completed succesfully")
            .toString(),
        response: response,
        data: callback == null
            ? null
            : objectFromJson<T>(callback, response, attribute: attribute),
      );
    } on DioException catch (err) {
      return handleServerError(err);
    } catch (e) {
      final option = RequestOptions(path: "$BASE_URL/$url");
      return handleServerError(DioException(
        requestOptions: option,
        response: Response(
          requestOptions: option,
          data: {
            "message": "LocaleKeys.server_error_please_try_again_later.tr()"
          },
        ),
        type: DioExceptionType.badResponse,
      ));
    }
  }

  // ------ Download DATA FROM SERVER -------//

  Future<CustomResponse> downloadFromServer({
    required String url,
    required String path,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
  }) async {
    // await _getBeaseUrl();
    // add stander header
    if (headers != null) {
      headers.addAll(_header());
      headers.removeWhere(
          (key, value) => headers![key] == null || headers[key] == "");
    } else {
      headers = _header();
    }

    try {
      Response response =
          await _dio.download(url, path, onReceiveProgress: (received, total) {
        onSingleReceive.add((received / total));
      });
      return CustomResponse(
        success: true,
        statusCode: 200,
        errType: null,
        msg: "Your request completed succesfully",
        response: response,
      );
    } on DioException catch (err) {
      return handleServerError(err);
    }
  }

  // -------- HANDLE ERROR ---------//
  CustomResponse<T> handleServerError<T>(DioException err) {
    if (err.type == DioExceptionType.badResponse) {
      if (err.response!.data.toString().contains("DOCTYPE") ||
          err.response!.data.toString().contains("<script>") ||
          err.response!.data["exception"] != null) {
        // firebaseCrashlytics.apiRecordError(
        //   err.response?.data,
        //   err.stackTrace ?? StackTrace.empty,
        //   "${err.requestOptions.path} (${err.requestOptions.method})",
        // );
        // if (kDebugMode) FlashHelper.errorBar(message: "${err.response!.data}");
        return CustomResponse(
          success: false,
          errType: 1,
          statusCode: err.response!.statusCode ?? 500,
          msg: kDebugMode
              ? "${err.response!.data}"
              : "LocaleKeys.server_error_please_try_again_later.tr()",
          response: null,
        );
      }
      if (err.response!.statusCode == 401) {
        // User.i.clear(false);
        return CustomResponse(
          success: false,
          statusCode: err.response?.statusCode ?? 401,
          errType: 3,
          msg: err.response?.data["message"] ?? '',
          response: err.response,
        );
      }
      try {
        return CustomResponse(
          success: false,
          statusCode: err.response?.statusCode ?? 500,
          errType: 2,
          msg: (err.response!.data["errors"] as Map).values.first.first,
          response: err.response,
        );
      } catch (e) {
        return CustomResponse(
          success: false,
          statusCode: err.response?.statusCode ?? 500,
          errType: 2,
          msg: err.response?.data["message"]?? err.response?.data['error'].toString()??'There are somethings errors',
          response: err.response,
        );
      }
    } else if (err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout) {
      return CustomResponse(
        success: false,
        statusCode: err.response?.statusCode ?? 500,
        errType: 0,
        msg:
            "LocaleKeys.poor_connection_check_the_quality_of_the_internet.tr()",
        response: null,
      );
    } /* else if (err.response!.statusCode == 400) {
      return CustomResponse(
          success: false,
          statusCode: 400,
          msg: err.response!.data['error'].toString(),
          response: err.response
          );
    } */ else {
      if (err.response == null) {
        return CustomResponse(
          success: false,
          statusCode: 402,
          errType: 0,
          msg:
              " LocaleKeys.no_connection_check_the_quality_of_the_internet.tr()",
          response: null,
        );
      }
      // firebaseCrashlytics.apiRecordError(
      //   err.response?.data,
      //   err.stackTrace ?? StackTrace.empty,
      //   "${err.requestOptions.path} (${err.requestOptions.method})",
      // );
      return CustomResponse(
        success: false,
        statusCode: 402,
        errType: 1,
        msg: " LocaleKeys.server_error_please_try_again_later.tr()",
        response: null,
      );
    }
  }

  final Map<String, String> _cashedImage = {};
  final _imageDio = Dio();
  Future<String?> imageBase64(String url) async {
    if (_cashedImage.length >= 70) {
      _cashedImage.clear();
    }
    if (_cashedImage.containsKey(url.split("/").last)) {
      return _cashedImage[url.split("/").last]!;
    }
    final result = await _imageDio.get(url,
        options: Options(responseType: ResponseType.bytes));
    if (result.statusCode == 200) {
      // final image = decodeImage(result.data);
      // if (image == null) return null;
      // final resizedImage = copyResize(image, height: height?.toInt() ?? 50, width: width?.toInt() ?? 50);
      // final imageEncoder = base64Encode(encodePng(resizedImage));
      final imageEncoder = base64Encode(result.data);
      _cashedImage
          .addAll({result.requestOptions.path.split("/").last: imageEncoder});
      return imageEncoder;
    } else {
      return null;
    }
  }

/*   Future<String?> _getBeaseUrl() async {
    // BASE_URL = "https://neqaty.phpv8.aait-d.com/api";

    // return BASE_URL;

    const String url = "http://fatoura.valuwitapps.co/api";
    try {
      return BASE_URL;
      final result = await _dio.get(url);
      if (result.data != null) {
        BASE_URL = result.data;
        logger.e("\x1B[37m------Base url -----\x1B[0m");
        logger.e("\x1B[31m$BASE_URL\x1B[0m");
        return BASE_URL;
      } else {
        final option = RequestOptions(path: "$BASE_URL/$url");
        throw handleServerError(DioException(
          requestOptions: option,
          response: Response(
            requestOptions: option,
            data: {
              "message": "LocaleKeys.server_error_please_try_again_later.tr()"
            },
          ),
          type: DioExceptionType.badResponse,
        ));
      }
    } catch (e) {
      final requestOptions = RequestOptions(path: url);
      throw DioException(
        requestOptions: requestOptions,
        response: Response(
          requestOptions: requestOptions,
          data: {"message": "حدث خطآ عند الاتصال بالسيرفر"},
        ),
        type: DioExceptionType.badResponse,
      );
    }
  }
 */}

class CustomApiInterceptor extends Interceptor {
  Logger log;
  CustomApiInterceptor(this.log);
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log.f("\x1B[37m------ Current Error Response -----\x1B[0m");
    log.f("\x1B[31m${err.response?.data}\x1B[0m");
    return super.onError(err, handler);
  }

  @override
  Future<void> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    log.i("------ Current Response ------");
    if (kDebugMode) {
      print(response.data.runtimeType);
    }

    log.i(jsonEncode(response.data));
    return super.onResponse(response, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log.d("------ Current Request Parameters Data -----");
    log.d("${options.queryParameters}");
    log.w("------ Current Request Headers -----");
    log.w("${options.headers}");
    log.i("------ Current Request Path -----");
    log.i("${options.path} API METHOD : (${options.method})");
    return super.onRequest(options, handler);
  }
}

class CustomResponse<T> {
  bool success;
  int? errType;
  // 0 => network error
  // 1 => error from the server
  // 3 => unAuth
  // 2 => other error

  String msg;
  int statusCode;
  Response? response;
  T? data;

  CustomResponse({
    this.success = false,
    this.errType = 0,
    this.msg = "",
    this.statusCode = 0,
    this.response,
    this.data,
  });
}

class CustomError {
  int? type;
  String? msg;
  dynamic error;

  CustomError({
    this.type,
    this.msg,
    this.error,
  });
}

// import 'dart:convert';
// import 'dart:io';
//
// import 'package:dio/dio.dart';
//
// import '../globals.dart';
//
// String baseURL = "http://fatoura.valuwitapps.co/api";
// //  String baseURL = "https://60d8f4d6eec56d0017477557.mockapi.io/alqshaln/api";
// //  String baseURL = "https://newsapi.org/v2";
//
// class ServerGate {
//   Dio dio = Dio();
//
//
//   void addInterceptors() {
//     dio.interceptors.add(CustomApiInterceptor());
//   }
//
//
//
//   // ------- POST DATA TO SERVER -------//
//   Future<CustomResponse> sendToServer({
//     required String url,
//     Map<String, dynamic>? headers,
//     Map<String, dynamic>? body,
//     Map<String, dynamic>? params,
//   }) async {
//     // remove nulls from body
//     if (body != null) {
//       logger.d("${body.entries}________________________", error: ' post Entries ');
//       body.removeWhere(
//         (key, value) => body[key] == null || body[key] == "",
//       );
//       logger.d("${body.entries}________________________");
//     }
//
//     try {
//       logger.d(body);
//       logger.d('-----------------');
//
//       Response response = await dio.post("$baseURL/$url",
//           data: body,
//           options: Options(
//             headers: headers,
//           ),
//           queryParameters: params);
//
//       // print('=======================================');
//       // print(response.statusMessage);
//       // print(response);
//
//       // print('=======================================');
//
//       return CustomResponse(
//         success: true,
//         statusCode: 200,
//         errType: null,
//         msg: "Your request completed succesfully",
//         response: response,
//       );
//     } on DioException catch (err) {
//       logger.e("error message ${err.message}", error: 'Serve');
//       logger.e("__________${err}____________VEWWWW");
//
//       return handleServerError(err);
//     }
//   }
//
// /*   //-----------Put--------------
//   Future<CustomResponse> putToServer({
//     @required String url,
//     Map<String, dynamic> headers,
//     Map<String, dynamic> body,
//     Map<String, dynamic> params,
//   }) async {
//     // remove nulls from body
//     body.removeWhere(
//       (key, value) => body[key] == null || body[key] == "",
//     );
//
//     try {
//       Response response = await dio.put(
//         "$baseURL/$url",
//         data: body,
//         options: Options(
//           headers: headers,
//         ),
//         queryParameters: params,
//       );
//
//       return CustomResponse(
//         success: true,
//         statusCode: 200,
//         errType: null,
//         error: null,
//         msg: "Your request completed succesfully",
//         response: response,
//       );
//     } on DioError catch (err) {
//       print("__________${err}____________VEWWWW");
//
//       return handleServerError(err);
//     }
//   }
//
//   //-----------Delete--------------
//   Future<CustomResponse> deleteFromServer({
//     @required String url,
//     Map<String, dynamic> headers,
//     Map<String, dynamic> body,
//     Map<String, dynamic> params,
//   }) async {
//     // remove nulls from body
//     body.removeWhere(
//       (key, value) => body[key] == null || body[key] == "",
//     );
//
//     try {
//       Response response = await dio.delete(
//         "$baseURL/$url",
//         data: FormData.fromMap(body),
//         options: Options(
//           headers: headers,
//         ),
//         queryParameters: params,
//       );
//
//       return CustomResponse(
//         success: true,
//         statusCode: 200,
//         errType: null,
//         error: null,
//         msg: "Your request completed succesfully",
//         response: response,
//       );
//     } on DioError catch (err) {
//       print("__________${err}____________VEWWWW");
//
//       return handleServerError(err);
//     }
//   }
//
//  */ // ------ GET DATA FROM SERVER -------//
//   Future<CustomResponse> getFromServer({
//     required String url,
//     Map<String, dynamic>? headers,
//     Map<String, dynamic>? params,
//   }) async {
//     try {
//       logger.d(params);
//       if (params != null) {
//             params.removeWhere(
//         (key, value) => params[key] == null || params[key] == "",
//       );
//       }
//
//
//       Response response = await dio.get(
//         "$baseURL/$url",
//         options: Options(
//           headers: headers,
//         ),
//         queryParameters: params,
//       );
//
//       return CustomResponse(
//         success: true,
//         statusCode: 200,
//         errType: null,
//         msg: "Your request completed succesfully",
//         response: response,
//       );
//     } on DioException catch (err) {
//       return handleServerError(err);
//     }
//   }
//
// /* // ------ GET DATA FROM SERVER Pagination  -------//
//   Future<CustomResponse> getFromServerPagination({
//     required String url,
//     Map<String, dynamic>? headers,
//     Map<String, dynamic>? params,
//   }) async {
//     try {
//       print(params);
//       params.removeWhere(
//         (key, value) => params[key] == null || params[key] == "",
//       );
//
//       Response response = await dio.get(
//         url,
//         options: Options(
//           headers: headers,
//         ),
//         queryParameters: params,
//       );
//
//       return CustomResponse(
//         success: true,
//         statusCode: 200,
//         errType: null,
//         error: null,
//         msg: "Your request completed succesfully",
//         response: response,
//       );
//     } on DioError catch (err) {
//       return handleServerError(err);
//     }
//   }
//  */
//  /*  // ------ Download DATA FROM SERVER -------//
//   Future<CustomResponse> downloadFromServer({
//     @required String url,
//     @required String path,
//     Map<String, dynamic> headers,
//     Map<String, dynamic> params,
//   }) async {
//     try {
//       CancelToken cancelToken = CancelToken();
//       Response response = await dio.download(url, path,
//           cancelToken: cancelToken, onReceiveProgress: (received, total) {
//         print("${(received / total * 100).toStringAsFixed(0)}%");
//       });
//
//       print("response from download =-=-=> ${response.data.toString()}");
//
//       return CustomResponse(
//         success: true,
//         statusCode: 200,
//         errType: null,
//         error: null,
//         msg: "Your request completed succesfully",
//         response: response,
//       );
//     } on DioError catch (err) {
//       return handleServerError(err);
//     }
//   }
//  */
//   // -------- HANDLE ERROR ---------//
//   CustomResponse handleServerError(DioException err) {
//     if (err.type == DioExceptionType.badResponse) {
//       print("=-=-=-= ERROR FROM THE SERVER =-=-=-=-=");
//       logger.e(err.response!.data.toString());
//       // Get.snackbar("Register Error", err.response.data.toString());
//       // throw SocketException("");
//       return CustomResponse(
//         success: false,
//         statusCode: err.response!.statusCode??400,
//         errType: 1,
//         msg:err.response?.data['message']?? "Please check these errors and try again.",
//         response: Response(requestOptions: RequestOptions()),
//       );
//     } else if (err.type == DioExceptionType.unknown &&
//         err.error != null &&
//         err.error is SocketException) {
//       // PLEASE CHECK YOUR NETWORK CONNECTION .
//       return CustomResponse(
//         success: false,
//         statusCode: 0,
//         errType: 0,
//         msg: "Please Check Your network Connection.",
//         response:Response(requestOptions: RequestOptions()) ,
//       );
//     } else if (err.type == DioExceptionType.unknown) {
//       print("xcxcxcxcxcxcxcxcxcxcxcxcxcxcx");
//       print("print error =>>> ${err.error}");
//       print("print error =>>> ${err.message}");
//       return CustomResponse(
//         success: false,
//         statusCode: err.response!.statusCode ?? 500,
//         errType: 2,
//         msg: "Server Error, Please try again later.",
//         response: Response(requestOptions: RequestOptions()),
//       );
//     } else {
//       print("FromServerGate=================================???");
//       return CustomResponse(
//         success: false,
//         statusCode: err.response!.statusCode??500,
//         errType: 2,
//         msg: "Server Error, Please try again later.",
//         response:Response(requestOptions: RequestOptions()) ,
//       );
//     }
//   }
// }
//
// class CustomApiInterceptor extends Interceptor {
//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) {
//     logger.w("\x1B[37m------ Current Error Response -----\x1B[0m");
//     logger.w("\x1B[31m${err.response?.data}\x1B[0m");
//     return super.onError(err, handler);
//   }
//
//   @override
//   Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {
//     logger.i("------ Current Response ------");
//     // if (kDebugMode) {
//     //   print(response.data.runtimeType);
//     // }
//
//     logger.i(jsonEncode(response.data));
//     return super.onResponse(response, handler);
//   }
//
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     logger.t("------ Current Request Parameters Data -----");
//     logger.t("${options.queryParameters}");
//     logger.f("------ Current Request Headers -----");
//     logger.f("${options.headers}");
//     logger.i("------ Current Request Path -----");
//     logger.i("${options.path} API METHOD : (${options.method})");
//     return super.onRequest(options, handler);
//   }
// }
//
// class CustomResponse<T> {
//   bool success;
//   int? errType;
//   // 0 => network error
//   // 1 => error from the server
//   // 3 => unAuth
//   // 2 => other error
//
//   String msg;
//   int statusCode;
//   Response? response;
//   T? data;
//
//   CustomResponse({
//     this.success = false,
//     this.errType = 0,
//     this.msg = "",
//     this.statusCode = 0,
//     this.response,
//     this.data,
//   });
// }
//
// class CustomError {
//   int? type;
//   String? msg;
//   dynamic error;
//
//   CustomError({
//     this.type,
//     this.msg,
//     this.error,
//   });
// }
