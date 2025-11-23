import 'package:bandora_app/notifications/data/model/mark_read_response.dart';
import '../../../../core/error/api_error_handler.dart';
import '../../../core/networking/api/api_service.dart';

class MarkReadDataSource {
  final ApiService _apiService;

  MarkReadDataSource(this._apiService);

  // markRead
  Future<MarkReadResponse> markRead() async {
    try {
      final response = await _apiService.markRead('application/json');
      return response;
    } catch (e) {
      throw ErrorHandler.handle(e).apiErrorModel;
    }
  }
} 