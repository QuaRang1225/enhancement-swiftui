//
//  TwiterClone_EXApp.swift
//  TwiterClone_EX
//
//  Created by 유영웅 on 2022/11/08.
//

import SwiftUI
import Firebase

@main
struct TwiterClone_EXApp: App {
    @StateObject var vm = AuthViewModel()
    init(){
        FirebaseApp.configure() //firbase를 사용하는 앱이라는 것을 등록
    }
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
            }.environmentObject(vm)
        }
    }
}
//
//import SwiftUI
//import FirebaseCore
//
//
//class AppDelegate: NSObject, UIApplicationDelegate {
//  func application(_ application: UIApplication,
//                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//    FirebaseApp.configure()
//
//    return true
//  }
//}
//
//@main
//struct YourApp: App {
//  // register app delegate for Firebase setup
//  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//
//
//  var body: some Scene {
//    WindowGroup {
//      NavigationView {
//        ContentView()
//      }
//    }
//  }
//}
