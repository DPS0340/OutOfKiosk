//
//  AppDelegate.swift
//  OutOfKiosk
//
//  Created by a1111 on 2019/12/31.
//  Copyright © 2019 OOK. All rights reserved.
//

import UIKit
import UserNotifications
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
    
    /*TEST*/
    
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
        
        /*ApiAi를 사용하여, 구글 다이얼로그플로우의 토큰을 받는 과정이다. 초기설정.*/
        /*let configuration = AIDefaultConfiguration()
        configuration.clientAccessToken = "d94411c80a7e46b7bcac2efb46698353"
        */
        
        /*PUSH NOTIFICATION의 권환을 설정해 주는 코드*/
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.badge, .alert, .sound]) {
            (granted, error) in
            // Enable or disable features based on authorization.
            if(granted){
                print("사용자가 푸시를 허용했습니다")
                DispatchQueue.main.async {
//                    UIApplication.shared.unregisterForRemoteNotifications()
                    application.registerForRemoteNotifications()
                }
            } else {
                print("사용자가 푸시를 거절했습니다")
            }
        }
        return true

    }
    
    /* PUSH NOTIFICATION 관련 Appdelegate Protocol*/
    /*=========================================================================================================*/
    
    // 토큰 정상 등록(registerForRemoteNotifications()을 호출한 결과가 성공일 때)
    // 토큰 정상 등록(registerForRemoteNotifications()을 호출한 결과가 성공일 때)
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})

        
        print("등록된 토큰은 \(deviceTokenString) 입니다.")
    }
    
    // 토큰 등록 실패 (registerForRemoteNotifications()을 호출한 결과가 실패)
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("에러 발생 : \(error)")
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification data: [AnyHashable : Any]) {
        print("메시지 수신2 : \(data)")
        UIApplication.shared.applicationIconBadgeNumber += 1
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        // 뱃지를 사용한다면 액티브 될 때마다 0으로 초기화 해줘야함
        // UIApplication.shared.applicationIconBadgeNumber = 0
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    /*=========================================================================================================*/
    

    // MARK: UISceneSession Lifecycle

    /*
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
        print("background entered")
    }*/

}

