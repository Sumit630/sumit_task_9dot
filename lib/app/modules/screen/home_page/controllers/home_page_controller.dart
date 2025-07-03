import '../../../../data/res/app.export.dart';

class HomePageController extends GetxController {
  final apiCall = ApiCall();
  String userId = "";
  final jobs = <JobModel>[].obs;
  final isLoading = false.obs;

  TextEditingController searchController = TextEditingController();
  int currentPage = 10;
  bool canLoadMore = true;
  int totalJobs = 0;

  @override
  void onInit() {
    super.onInit();
    userId = prefs.getString(LocalStorage.userId.toString()) ?? "";
    fetchJobs();
  }

  void fetchJobs({bool isRefresh = false}) async {
    print(
        "🔄 Fetching Jobs... isLoading: ${isLoading.value}, canLoadMore: $canLoadMore");

    if (isLoading.value || (!canLoadMore && !isRefresh)) return;

    if (isRefresh) {
      currentPage = 1;
      canLoadMore = true;
      jobs.clear();
    }

    final formData = {
      "user_id": userId,
      "page": currentPage.toString(),
      "search": searchController.text.trim(),
      "view_list": "0",
    };

    print("📦 Sending API request with: $formData");

    isLoading.value = true;

    await apiCall.fetchApiData(
      endPoint: ApiEndPoint.jobList,
      method: MethodType.post,
      requestData: formData,
      successCallback: (response, message) {
        print("API success: $response");
        final List dataList = response['data'];
        final total = response['total_jobs'];

        jobs.addAll(dataList.map((e) => JobModel.fromJson(e)).toList());

        currentPage++;
        totalJobs = total;

        if (dataList.isEmpty) canLoadMore = false;

        isLoading.value = false;
      },
      failureCallback: (message, statusCode) {
        print("API failure: $message");
        AppToast.toast(msg: message);
        isLoading.value = false;
      },
    );
  }
}

String formatDate(String rawDate) {
  try {
    final dateTime = DateTime.parse(rawDate);
    return DateFormat('dd-MM-yyyy').format(dateTime);
  } catch (_) {
    return rawDate; // fallback if parsing fails
  }
}
