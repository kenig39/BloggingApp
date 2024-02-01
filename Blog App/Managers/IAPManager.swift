

import Foundation
import Purchases
import StoreKit

final class IAPManager {
    static let shared = IAPManager()
    
    //9eb0501030a848b2bcd519ef0c3941c0
    
    private init() {}
    
    func isPremium() -> Bool{
        return UserDefaults.standard.bool(forKey: "premium")
        
    }
    
    
    public func getSubscriptionStatus(complition: ((Bool) -> Void)?) {
        
        Purchases.shared.purchaserInfo { info, error in
            guard let entitlement = info?.entitlements,
                  error == nil else {
                return
            }
            
          
            if entitlement.all["Premium"]?.isActive == true {
                UserDefaults.standard.set(true, forKey: "premium")
                complition?(true)
            } else {
                UserDefaults.standard.set(false, forKey: "premium")
                complition?(false)
            }
            
        }
    }
    
    public func subscribe(package: Purchases.Package,
                          complition: @escaping(Bool) -> Void) {
        guard !isPremium() else {
            complition(true)
            print("User already subsribeed")
            return
        }
        
        Purchases.shared.purchasePackage(package) {  transaction, info , error, userCancelled in
            guard let transaction = transaction,
                  let entitlement = info?.entitlements,
                  error == nil,
                  !userCancelled else {
                return
            }
            switch transaction.transactionState {
                
            case .purchasing:
                print("purchasing")
            case .purchased:
                  if entitlement.all["Premium"]?.isActive == true {
                      print("purchased!")
                      UserDefaults.standard.set(true, forKey: "premium")
                      complition(true)
                  } else {
                      print("Purchase failed")
                      UserDefaults.standard.set(false, forKey: "premium")
                      complition(false)
                  }
            case .failed:
                print("failed")
            case .restored:
                print("restore")
            case .deferred:
                print("defered")
            @unknown default:
                print("defalt case")
            }
        }
    }
    
    public func fetchPackages(complition: @escaping(Purchases.Package?) -> Void){
        Purchases.shared.offerings{ offering, error in
            guard let package = offering?.offering(identifier: "default")?.availablePackages.first,
                  error == nil else {
                return
            }
            
            complition(package)
        }
    }
    

    
    func restorePurchases(complition: @escaping(Bool) -> Void) {
        Purchases.shared.restoreTransactions  { info, error in
            guard let entitlement = info?.entitlements,
                  error == nil else {
                return
            }
                    if entitlement.all["Premium"]?.isActive == true {
                        UserDefaults.standard.set(true, forKey: "premium")
                        complition(true)
                    } else {
                        UserDefaults.standard.set(false, forKey: "premium")
                        complition(false)
                
            }
        }
    }
}
