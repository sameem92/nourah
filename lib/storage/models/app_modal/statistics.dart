class StatisticsModal {
 late Todaystatistics? todaystatistics;
 late Statistics statistics;


  StatisticsModal.fromJson(Map<String, dynamic> json) {
    todaystatistics = (json['todaystatistics'] != null
        ? Todaystatistics.fromJson(json['todaystatistics'])
        : null);
    statistics = (json['statistics'] != null
        ? Statistics.fromJson(json['statistics'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (todaystatistics != null) {
      data['todaystatistics'] = todaystatistics!.toJson();
    }
    data['statistics'] = statistics.toJson();
    return data;
  }
}

class Todaystatistics {
 late int completedOrders;
 late int requiredOrdersCount;
 late int bounsOrders;


  Todaystatistics.fromJson(Map<String, dynamic> json) {
    completedOrders = json['completed_orders'];
    requiredOrdersCount = json['required_orders_count'];
    bounsOrders = json['bouns_orders'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['completed_orders'] = completedOrders;
    data['required_orders_count'] = requiredOrdersCount;
    data['bouns_orders'] = bounsOrders;
    return data;
  }
}

class Statistics {
 late int currentPage;
 late List<statis> data;
 late String firstPageUrl;
 late int from;
 late int lastPage;
 late String? lastPageUrl;
 late String? nextPageUrl;
 late String path;
 late int perPage;
 late String? prevPageUrl;
 late int to;
 late int total;



  Statistics.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <statis>[];
      json['data'].forEach((v) {
        data.add(statis.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['data'] = this.data.map((v) => v.toJson()).toList();
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class statis {
 late int id;
 late int userId;
 late String startDate;
 late String? endDate;
 late int completedOrders;
 late int bounsOrders;
 late int penddingOrders;
 late int cancelOrders;
 late int offers;
 late int sales;
 late int products;
 late int total;
 late int commission;
 late int profit;
 late String createdAt;


  statis.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    completedOrders = json['completed_orders'];
    bounsOrders = json['bouns_orders'];
    penddingOrders = json['pendding_orders'];
    cancelOrders = json['cancel_orders'];
    offers = json['offers'];
    sales = json['sales'];
    products = json['products'];
    total = json['total'];
    commission = json['commission'];
    profit = json['profit'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['completed_orders'] = completedOrders;
    data['bouns_orders'] = bounsOrders;
    data['pendding_orders'] = penddingOrders;
    data['cancel_orders'] = cancelOrders;
    data['offers'] = offers;
    data['sales'] = sales;
    data['products'] = products;
    data['total'] = total;
    data['commission'] = commission;
    data['profit'] = profit;
    data['created_at'] = createdAt;
    return data;
  }
}
class StatisticssModal {
 late int id;
 late int userId;
 late String startDate;
 late String? endDate;
 late int completedOrders;
 late int bounsOrders;
 late int penddingOrders;
 late int cancelOrders;
 late int offers;
 late int sales;
 late int products;
 late int total;
 late int commission;
 late int profit;
  late String createdAt;



  StatisticssModal.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    userId = json['user_id']??0;
    startDate = json['start_date'];
    endDate = json['end_date'];
    completedOrders = json['completed_orders']??0;
    bounsOrders = json['bouns_orders']??0;
    penddingOrders = json['pendding_orders']??0;
    cancelOrders = json['cancel_orders']??0;
    offers = json['offers']??0;
    sales = json['sales']??0;
    products = json['products']??0;
    total = json['total']??0;
    commission = json['commission']??0;
    profit = json['profit']??0;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['completed_orders'] = completedOrders;
    data['bouns_orders'] = bounsOrders;
    data['pendding_orders'] = penddingOrders;
    data['cancel_orders'] = cancelOrders;
    data['offers'] = offers;
    data['sales'] = sales;
    data['products'] = products;
    data['total'] = total;
    data['commission'] = commission;
    data['profit'] = profit;
    data['created_at'] = createdAt;
    return data;
  }
}