//
//  GlobalVariables.swift
//  HelloPharma
//
//  Created by Rohit sandhu on 1/4/21.
//

import Foundation
struct myGlobalVarialbe
{
  static var alertMessage = ""
}

struct Constants
{
  static var baseUrl = "http://15.206.100.247/helloapp/api/"
  static var login = "sign-in"
  static var forgotPassword = "forget_password"
  static var resetPassword = "reset_password"
  static var socialLogin = "social-sign-in"
  static var signUp = "sign-up"
  static var screenAdds = "screen_ads"
  static var getStores = "get-stores"
  static var getStoreDetails = "get_cat_store_detail"
  static var uploadPrescription = "upload-prescription"
  static var prescriptionDetail = "search-prescription"
  static var deletePrescription = "deletePrescription"
  static var refillPrescription = "refillPrescription"
  static var getsubcatstores = "get_subcat_stores"
  static var getPrescriptionList = "get_prescription_list"
  static var getCoupons = "getCoupons"
  static var getCategory = "searchCategories"
  static var searchProducts = "searchProducts"
  static var productDetail = "productDetail"
  static var getCart = "getCart"
  static var addToCart = "addTocart"
  static var deleteItem = "deleteItem"
  static var similarProducts = "similarProducts"
  static var getAddress = "getAddress"
  static var addAddress = "addAddress"
  static var placeOrder = "placeOrder"
  static var updateCart = "updateCart"
  static var orderPrescription = "orderPrescription"
  static var getCategories = "getCategories"
}

enum serviceType : String{
    case ManicurePedicure = "1"
    case HairMakeup = "2"
    case SpaMassage = "3"
    case Facial = "4"
}
