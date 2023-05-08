class Product {
  String? productType;
  String? productName;
  String? brandName;
  String? color;
  String? description;
  List<String>? imagesUrl;
  ShippingInfo? shippingInfo;
  SellerInfo? sellerInfo;
  Rating? rating;
  String? amount;
  int? totalSold;
  bool liked = false;

  Product(
      {this.productType,
      this.productName,
      this.brandName,
      this.color,
      this.description,
      this.imagesUrl,
      this.shippingInfo,
      this.sellerInfo,
      this.rating,
      this.amount,
      this.totalSold});

  Product.fromJson(Map<String, dynamic> json) {
    productType = json['productType'];
    productName = json['productName'];
    brandName = json['brandName'];
    color = json['color'];
    description = json['description'];
    imagesUrl = json['imagesUrl'].cast<String>();
    shippingInfo = json['shippingInfo'] != null
        ? ShippingInfo.fromJson(json['shippingInfo'])
        : null;
    sellerInfo = json['sellerInfo'] != null
        ? SellerInfo.fromJson(json['sellerInfo'])
        : null;
    rating = json['rating'] != null ? Rating.fromJson(json['rating']) : null;
    amount = json['amount'];
    totalSold = json['totalSold'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['productType'] = productType;
    data['productName'] = productName;
    data['brandName'] = brandName;
    data['color'] = color;
    data['description'] = description;
    data['imagesUrl'] = imagesUrl;
    if (shippingInfo != null) {
      data['shippingInfo'] = shippingInfo!.toJson();
    }
    if (sellerInfo != null) {
      data['sellerInfo'] = sellerInfo!.toJson();
    }
    if (rating != null) {
      data['rating'] = rating!.toJson();
    }
    data['amount'] = amount;
    data['totalSold'] = totalSold;
    return data;
  }
}

class ShippingInfo {
  String? delivery;
  String? shipping;
  String? arrive;

  ShippingInfo({this.delivery, this.shipping, this.arrive});

  ShippingInfo.fromJson(Map<String, dynamic> json) {
    delivery = json['delivery'];
    shipping = json['shipping'];
    arrive = json['arrive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['delivery'] = delivery;
    data['shipping'] = shipping;
    data['arrive'] = arrive;
    return data;
  }
}

class SellerInfo {
  SellerInfo();

  SellerInfo.fromJson(Map<String, dynamic> json) {
    //do nothing
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    return data;
  }
}

class Rating {
  double? averageRating;
  int? totalReviews;
  int? fiveStar;
  int? fourStar;
  int? threeStar;
  int? twoStar;
  int? oneStar;

  Rating(
      {this.averageRating,
      this.totalReviews,
      this.fiveStar,
      this.fourStar,
      this.threeStar,
      this.twoStar,
      this.oneStar});

  Rating.fromJson(Map<String, dynamic> json) {
    averageRating = json['averageRating'];
    totalReviews = json['totalReviews'];
    fiveStar = json['fiveStar'];
    fourStar = json['fourStar'];
    threeStar = json['threeStar'];
    twoStar = json['twoStar'];
    oneStar = json['oneStar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['averageRating'] = averageRating;
    data['totalReviews'] = totalReviews;
    data['fiveStar'] = fiveStar;
    data['fourStar'] = fourStar;
    data['threeStar'] = threeStar;
    data['twoStar'] = twoStar;
    data['oneStar'] = oneStar;
    return data;
  }
}
