import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        MovieAPI().requestGenres{ _ in }
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        MovieAPI().localGenresArray = []
        MovieAPI().requestGenres{ _ in }
        }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        MovieAPI().localGenresArray = []
        MovieAPI().requestGenres{ _ in }
        }
}
