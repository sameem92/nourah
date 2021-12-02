class StatisticsModal {
 late Todaystatistics? todaystatistics;
 late Statistics statistics;


  StatisticsModal.fromJson(Map<String, dynamic> json) {
    todaystatistics = (json['todaystatistics'] != null
        ? new Todaystatistics.fromJson(json['todaystatistics'])
        : null);
    statistics = (json['statistics'] != null
        ? new Statistics.fromJson(json['statistics'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.todaystatistics != null) {
      data['todaystatistics'] = this.todaystatistics!.toJson();
    }
    if (this.statistics != null) {
      data['statistics'] = this.statistics.toJson();
    }
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['completed_orders'] = this.completedOrders;
    data['required_orders_count'] = this.requiredOrdersCount;
    data['bouns_orders'] = this.bounsOrders;
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
        data.add(new statis.fromJson(v));
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['completed_orders'] = this.completedOrders;
    data['bouns_orders'] = this.bounsOrders;
    data['pendding_orders'] = this.penddingOrders;
    data['cancel_orders'] = this.cancelOrders;
    data['offers'] = this.offers;
    data['sales'] = this.sales;
    data['products'] = this.products;
    data['total'] = this.total;
    data['commission'] = this.commission;
    data['profit'] = this.profit;
    data['created_at'] = this.createdAt;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['completed_orders'] = this.completedOrders;
    data['bouns_orders'] = this.bounsOrders;
    data['pendding_orders'] = this.penddingOrders;
    data['cancel_orders'] = this.cancelOrders;
    data['offers'] = this.offers;
    data['sales'] = this.sales;
    data['products'] = this.products;
    data['total'] = this.total;
    data['commission'] = this.commission;
    data['profit'] = this.profit;
    data['created_at'] = this.createdAt;
    return data;
  }
}