import 'dart:convert';

import 'package:objectbox/objectbox.dart';

class ProductResponse  {
  String? sTypename;
  Products? products;

  ProductResponse({this.sTypename, this.products});

  ProductResponse.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    products = json['products'] != null
        ? new Products.fromJson(json['products'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    if (this.products != null) {
      data['products'] = this.products!.toJson();
    }
    return data;
  }

  @override
  List<Object?> get props => [sTypename, products];
}

@Entity()
@Sync()
class Products  {
  String? sTypename;
  List<Items>? items;
  int? totalCount;
  @Id()
  int? id;

  Products({
    this.id = 0,
    this.sTypename,
    this.items,
    this.totalCount,
  });

  Products.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    totalCount = json['total_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['total_count'] = this.totalCount;

    return data;
  }

  @override
  List<Object?> get props => [items, totalCount];
}

@Entity()
@Sync()
class PriceRange {

  @Id()
  int? id;
  String? sTypename;
  MinimumPrice? minimumPrice;
  MinimumPrice? maximumPrice;

  PriceRange({this.sTypename, this.minimumPrice, this.maximumPrice,this.id=0});

  PriceRange.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    minimumPrice = json['minimum_price'] != null
        ? new MinimumPrice.fromJson(json['minimum_price'])
        : null;
    maximumPrice = json['maximum_price'] != null
        ? new MinimumPrice.fromJson(json['maximum_price'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    if (this.minimumPrice != null) {
      data['minimum_price'] = this.minimumPrice!.toJson();
    }
    if (this.maximumPrice != null) {
      data['maximum_price'] = this.maximumPrice!.toJson();
    }
    return data;
  }
}
@Entity()
@Sync()
class MinimumPrice {
  @Id()
  int? id;
  String? sTypename;
  RegularPrice? regularPrice;
  RegularPrice? finalPrice;
  Discount? discount;

  MinimumPrice(
      {this.sTypename, this.regularPrice, this.finalPrice, this.discount,this.id=0});

  MinimumPrice.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    regularPrice = json['regular_price'] != null
        ? new RegularPrice.fromJson(json['regular_price'])
        : null;
    finalPrice = json['final_price'] != null
        ? new RegularPrice.fromJson(json['final_price'])
        : null;
    discount = json['discount'] != null
        ? new Discount.fromJson(json['discount'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    if (this.regularPrice != null) {
      data['regular_price'] = this.regularPrice!.toJson();
    }
    if (this.finalPrice != null) {
      data['final_price'] = this.finalPrice!.toJson();
    }
    if (this.discount != null) {
      data['discount'] = this.discount!.toJson();
    }
    return data;
  }
}
@Entity()
@Sync()
class RegularPrice {
  String? sTypename;
  int? value;
  String? currency;
  @Id()
  int? id;
  RegularPrice({this.sTypename, this.value, this.currency,this.id=0});

  RegularPrice.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    value = json['value'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    data['value'] = this.value;
    data['currency'] = this.currency;
    return data;
  }
}
@Entity()
@Sync()
class Discount {
  String? sTypename;
  num? amountOff;
  num? percentOff;
  @Id()
  int? id;
  Discount({this.sTypename, this.amountOff, this.percentOff,this.id=0});

  Discount.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    amountOff = json['amount_off'];
    percentOff = json['percent_off'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    data['amount_off'] = this.amountOff;
    data['percent_off'] = this.percentOff;
    return data;
  }
}
@Entity()
@Sync()
class Items {
  @Id(assignable: true)
  int? id;
  @Unique(onConflict: ConflictStrategy.replace)
  String? sku;
  String? name;
  String? urlKey;
  String? stockStatus;
  String? sTypename;
  @Transient()
  Image? thumbnail;
  @Transient()
  PriceRange? priceRange;

  List<String>? priceTiers;

  Items(
      {
        this.id,
        this.sku,
        this.name,
        this.urlKey,
        this.stockStatus,
        this.sTypename,
        this.thumbnail,
        this.priceRange,
        this.priceTiers});


  String? get priceObject => priceRange == null ? null : json.encode(priceRange);

  set priceObject(String? value) {
    if (value == null) {
      priceRange = null;
    } else {
      priceRange = PriceRange.fromJson(jsonDecode(value));
    }
  }


  String? get dbImage => thumbnail == null ? null : json.encode(thumbnail);


  set dbImage(String? value) {
    if (value == null) {
      thumbnail = null;
    } else {
      thumbnail = Image.fromJson(jsonDecode(value));
    }
  }

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    priceRange = json['price_range'] != null
        ? new PriceRange.fromJson(json['price_range'])
        : null;
    sku = json['sku'];
    name = json['name'];
    urlKey = json['url_key'];
    stockStatus = json['stock_status'];
    sTypename = json['__typename'];
    thumbnail = json['thumbnail'] != null
        ? new Image.fromJson(json['thumbnail'])
        : null;

    if (json['price_tiers'] != null) {
      priceTiers = <String>[];
      json['price_tiers'].forEach((v) {
        priceTiers!.add("new String.fromJson(v)");
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sku'] = this.sku;
    data['name'] = this.name;
    data['url_key'] = this.urlKey;
    data['stock_status'] = this.stockStatus;
    data['__typename'] = this.sTypename;
    if (this.priceRange != null) {
      data['price_range'] = this.priceRange?.toJson();
    }
    if (this.thumbnail != null) {
      data['thumbnail'] = this.thumbnail!.toJson();
    }

    if (this.priceTiers != null) {
      data['price_tiers'] = this.priceTiers!.map((v) => "v.toJson()").toList();
    }
    return data;
  }
}
@Entity()
@Sync()
class Image {
  @Id()
  int? id;
  String? sTypename;
  String? url;
  String? label;
  String? position;


  Image({this.sTypename, this.url, this.label, this.position, this.id = 0});

  Image.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    url = json['url'];
    label = json['label'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    data['url'] = this.url;
    data['label'] = this.label;
    data['position'] = this.position;
    return data;
  }
}

class ProductImage {
  String? url;

  ProductImage({this.url});

  ProductImage.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}
