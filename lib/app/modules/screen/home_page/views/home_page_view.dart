import '../../../../data/res/app.export.dart';

class HomePageView extends GetView<HomePageController> {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
      init: HomePageController(),
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: SafeArea(
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(defaultPadding * 2),
                child: Column(
                  children: [
                    CustomTextField(
                      controller: controller.searchController,
                      enabled: true,
                      hintText: "Search",
                      onChanged: (value) {
                        if (value.trim().isEmpty) {
                          controller.searchController
                              .clear(); // Clear textfield
                          controller.fetchJobs(
                              isRefresh: true); // Reload total jobs
                        } else {
                          controller.fetchJobs(
                              isRefresh: true); // Search filter
                        }
                      },
                      //validator: AppValidations.validatePassword,
                      keyboardType: TextInputType.text,
                    ),
                    2.ph,
                    Obx(() {
                      if (controller.isLoading.value &&
                          controller.jobs.isEmpty) {
                        // Show loader on first load
                        return const Expanded(
                          child: Center(
                              child: CircularProgressIndicator(
                            color: AppColors.appColor,
                          )),
                        );
                      }

                      if (controller.jobs.isEmpty) {
                        // Show "No data found" when search result or job list is empty
                        return Expanded(
                          child: Center(
                            child: Text(
                              "No data found",
                              style: inter.medium.get10
                                  .copyWith(color: AppColors.grey),
                            ),
                          ),
                        );
                      }

                      return Expanded(
                        child: NotificationListener<ScrollNotification>(
                          onNotification: (scrollInfo) {
                            if (!controller.isLoading.value &&
                                scrollInfo.metrics.pixels ==
                                    scrollInfo.metrics.maxScrollExtent) {
                              controller.fetchJobs();
                            }
                            return true;
                          },
                          child: ListView.separated(
                            itemCount: controller.jobs.length + 1,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 10),
                            itemBuilder: (context, index) {
                              if (index == controller.jobs.length) {
                                return controller.isLoading.value
                                    ? const Padding(
                                        padding: EdgeInsets.all(16),
                                        child: Center(
                                            child: CircularProgressIndicator(
                                          color: AppColors.appColor,
                                        )),
                                      )
                                    : const SizedBox();
                              }

                              final job = controller.jobs[index];
                              return Container(
                                decoration: BoxDecoration(
                                  color: index.isOdd
                                      ? AppColors.colorPurpul
                                      : AppColors.colorPista,
                                  borderRadius: BorderRadius.circular(
                                      8), // Match Card shape if needed
                                  border: Border.all(
                                      color: Colors.white70, width: 1),
                                ),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: ListTile(
                                    title: Text(
                                      job.jobName,
                                      style: inter.bold.get12.black,
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        JobDetailText(label: "Type", value: job.jobType),
                                        JobDetailText(label: "Location", value: job.location),
                                        JobDetailText(label: "Salary", value: job.salary),
                                        JobDetailText(label: "State", value: job.stateName),
                                        JobDetailText(label: "Posted", value: formatDate(job.createdAt)),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(backgroundColor: AppColors.white,onPressed: () async {
                await prefs.clear();
                NavigationService.replaceAll(Routes.login);
              },child: Icon(Icons.logout,color: AppColors.red,),),
            ),
          ),
        );
      },
    );
  }
}