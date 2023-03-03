
// to convert the response into a non nullable object (model)


import 'package:project_1/app/extensions.dart';

import '../../domain/model/model.dart';
import '../responses/responses.dart';

const EMPTY = "";
const ZERO = 0;

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
        this?.id?.orEmpty() ?? EMPTY,
        this?.name?.orEmpty() ?? EMPTY,
        this?.numOfNotifications?.orZero() ?? ZERO);
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(this?.email?.orEmpty() ?? EMPTY,
        this?.phone?.orEmpty() ?? EMPTY, this?.link?.orEmpty() ?? EMPTY);
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
        this?.customer?.toDomain(), this?.contacts?.toDomain());
  }
}

extension ForgotPasswordResponseMapper on ForgotPasswordResponse? {
  String toDomain() {
    return this?.support?.orEmpty() ?? EMPTY;
  }
}

extension ServiceResponseMapper on ServiceResponse? {
  Service toDomain() {
    return Service(this?.id?.orZero() ?? ZERO, this?.title?.orEmpty() ?? EMPTY,
        this?.image?.orEmpty() ?? EMPTY);
  }
}

extension StoreResponseMapper on StoreResponse? {
  Store toDomain() {
    return Store(this?.id?.orZero() ?? ZERO, this?.title?.orEmpty() ?? EMPTY,
        this?.image?.orEmpty() ?? EMPTY);
  }
}

extension BannerResponseMapper on BannerResponse? {
  BannerAd toDomain() {
    return BannerAd(this?.id?.orZero() ?? ZERO, this?.title?.orEmpty() ?? EMPTY,
        this?.image?.orEmpty() ?? EMPTY, this?.link?.orEmpty() ?? EMPTY);
  }
}

extension HomeResponseMapper on HomeResponse?{

  HomeObject toDomain(){
    List<Service> mappedServices = (this?.data?.services?.map((services) => services.toDomain()) ??
        Iterable.empty()).cast<Service>().toList();
    List<Store> mappedStore = (this?.data?.stores?.map((store) => store.toDomain()) ??
        Iterable.empty()).cast<Store>().toList();
    List<BannerAd> mappedBannerAd = (this?.data?.banners?.map((banners) => banners.toDomain()) ??
        Iterable.empty()).cast<BannerAd>().toList();

    var data = HomeData(mappedServices, mappedStore, mappedBannerAd);
    return HomeObject(data);
  }
}