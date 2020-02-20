//
//  AppDelegate.swift
//  OutOfKiosk
//
//  Created by a1111 on 2019/12/31.
//  Copyright © 2019 OOK. All rights reserved.
//

import UIKit
/* Push Notification 을 받기 위한 모듈*/
import UserNotifications
/*Push Notification 권환 받을 때 달라지는 토큰값을 pushNotificatio.php에 저장해야 한다.*/
import Alamofire
 
/*
 모든 View 컨트롤러에서 접근이 가능하며 앱이 종료되지 않는 이상 데이터가 유지가 될 수 있다.
 */
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    /*ORIGINAL*/
    
    var numOfProducts : Int = 0
    var menuNameArray: Array<String> = []
    var menuSizeArray: Array<String> = []
    var menuCountArray: Array<Int> = []
    var menuEachPriceArray: Array<Int> = []
    var menuSugarContent : Array<String> = []
    var menuIsWhippedCream : Array<String> = []
    var menuStoreName : String = ""
        
    var badgeCount : Int = 0
    //    var orderState : String = nil
    //    /*TEST*/
    //
    //    var numOfProducts : Int = 1
    //    var menuNameArray: Array<String> = ["초콜렛스무디"]
    //    var menuSizeArray: Array<String> = ["스몰"]
    //    var menuCountArray: Array<Int> = [1]
    //    var menuEachPriceArray: Array<Int> = [5000]
    //    var menuSugarContent : Array<String> = ["30"]
    //    var menuIsWhippedCream : Array<String> = ["NULL"]
    
    /* 즐겨찾기된 menu를 저장하는 배열.*/
    //    var menuFavoriteArray: Array<String> = []
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Thread.sleep(forTimeInterval: 2.0)
        
        /* 최초에 사용자로부터 pushNotification의 권환을 받기 위한 코드*/
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.badge, .alert, .sound]) {
            (granted, error) in
            // Enable or disable features based on authorization.
            if(granted){
                print("사용자가 푸시를 허용했습니다")
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                    
                }
            } else {
                print("사용자가 푸시를 거절했습니다")
            }
        }
        
        
        return true
    }
    
    /* ======================================================================================================================== */
    
    /* Push Notification에 관련된 protocol */
    
    
    // 토큰 정상 등록(registerForRemoteNotifications()을 호출한 결과가 성공일 때)
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        
        print("등록된 토큰은 \(deviceTokenString) 입니다.")
        
        
        UserDefaults.standard.set(deviceTokenString , forKey: "token")
    }
    
    // 토큰 등록 실패 (registerForRemoteNotifications()을 호출한 결과가 실패)
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("에러 발생 : \(error)")
    }
    
    
    
    /* 이 프로토콜은 push notification을 알람으로 받는다.*/
    func application(_ application: UIApplication, didReceiveRemoteNotification data: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        
        
        if (application.applicationState == .active){ //포그라운드에서 pushNotification 받음.
            print("포그라운드!")
            
        }else if (application.applicationState == .background){
            print("백그라운드!")
            
            /* Background 에서 push notification 받으면 badgeNumber 숫자가 1씩 증가한다.*/
            //self.badgeCount += 1
            //UIApplication.shared.applicationIconBadgeNumber += self.badgeCount
            
        }
        
        UIApplication.shared.applicationIconBadgeNumber += 1
        print(UIApplication.shared.applicationIconBadgeNumber)
        
        let aps = data[AnyHashable("aps")] as? NSDictionary
        let alert = aps!["alert"] as! NSMutableString
        print("메시지 내용 찾기 : ", alert)        
        
        UserDefaults.standard.set(alert, forKey: "pushMSG")
        /* 후에 특정 메시지가 오게 되면 여기서 pushMSG의 값을 nil로 초기화 하는 작업을 할 듯.*/
                
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if KOSession.handleOpen(url) {
            return true
        }
        return false
    }
    internal func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        if KOSession.handleOpen(url) {
            return true
        }
        return false
    }
    
    
    
    
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        KOSession.handleDidEnterBackground()
        print("background entered")
        
    }
    
    /*
     현재 이 메소드가 안 불러지는 상황
     applicationWillEnterForeground(_ application: UIApplication)
     applicationDidBecomeActive(_ application: UIApplication)
     
     iOS 13 has a new way of sending app lifecycle events
     Instead of coming through the UIApplicationDelegate they come through the UIWindowSceneDelegate which is a UISceneDelegate sub-protocol
     
     https://stackoverflow.com/questions/56508764/app-delegate-methods-arent-being-called-in-ios-13
     */
    
    
    //    func applicationWillEnterForeground(_ application: UIApplication) {
    //
    //        print("foreground will enter")
    //        /* 앱이 실행되면 뱃지에 있는 숫자를 0으로 바꾼다.*/
    //
    ////        UIApplication.shared.applicationIconBadgeNumber = 0
    ////        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    ////
    //    }
    //    @objc func willEnterForeground() {
    //        print("will enter foreground")
    //        UIApplication.shared.applicationIconBadgeNumber = 0
    //        print(UserDefaults.standard.string(forKey: "pushMSG"))
    //
    //    }
    
    
    //
    //    func applicationDidBecomeActive(_ application: UIApplication) {
    //        KOSession.handleDidBecomeActive()
    //        print("I'm foreground")
    //    }
    //
    
    
}

/*
 extension AppDelegate : UNUserNotificationCenterDelegate {
 @available(iOS 10.0, *)
 func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
 // 앱이 구동되어 있으면 호출됨
 //        processPayload(notification.request.content.userInfo, background: false)
 
 completionHandler(.alert) // 푸시가 오면 어떻게 표현이 되는지에 대해서 정의
 }
 
 @available(iOS 10.0, *)
 func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
 // 앱이 백그라운드 상태면 호출됨
 //        processPayload(response.notification.request.content.userInfo, background: true)
 completionHandler()
 }
 
 func application(_ application: UIApplication, didReceiveRemoteNotification data: [AnyHashable : Any]) {
 let state = application.applicationState
 switch state {
 case .background, .inactive:
 print("백그라운드 모드")
 break
 //            processPayload(userInfo, background: true)
 case .active:
 print("포그라운드 모드")
 print("메시지 수신 : \(data)")
 print(type(of: data))
 //        let dict = data.values
 let aps = data[AnyHashable("aps")] as? NSDictionary
 let alert = aps!["alert"] as! NSMutableString
 print("메시지 내용 찾기 : ", alert)
 UIApplication.shared.applicationIconBadgeNumber += 0
 
 UserDefaults.standard.set(alert, forKey: "pushMSG")
 break
 //            processPayload(userInfo, background: false)
 @unknown default:
 break
 // 상태가 존재하지는 않음
 //            processPayload(userInfo, background: true)
 }
 }
 }
 */
