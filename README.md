# Core

### Send Notification with Category

```swift
func send() {

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in
            let content = UNMutableNotificationContent()
            content.title = "Message"
            content.body = "New Tutorial From Paige Software!!!"

            // MARK: SET ACTIONS AND CATEGORY
            let open = UNNotificationAction(identifier: "open", title: "Open", options: .foreground)
            let cancel = UNNotificationAction(identifier: "cancel", title: "Cancel", options: .destructive)
            let categories = UNNotificationCategory(identifier: "action", actions: [open, cancel], intentIdentifiers: [])
            UNUserNotificationCenter.current().setNotificationCategories([categories])
            content.categoryIdentifier = "action"

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let req = UNNotificationRequest(identifier: "req", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(req, withCompletionHandler: nil)
        }

    }
```

### Post & Receive Events

```swift
// Post
NotificationCenter.default.post(name: NSNotification.Name("Detail"), object: nil)
```

```swift
// Receive
NotificationCenter.default.addObserver(forName: NSNotification.Name("Detail"), object: nil, queue: .main) { _ in
                        self.show = true
                    }
```

### Setup notification `action` receiver

```swift
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        if response.actionIdentifier == "open" {
            NotificationCenter.default.post(name: NSNotification.Name("Detail"), object: nil)
        }

    }

}

@main
struct NotificationUserActionSwiftUIApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

# App

```swift
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        if response.actionIdentifier == "open" {
            NotificationCenter.default.post(name: NSNotification.Name("Detail"), object: nil)
        }

    }

}

@main
struct NotificationUserActionSwiftUIApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

# View

```swift
import SwiftUI
import UserNotifications

struct ContentView: View {

    @State var show = false

    var body: some View {

        NavigationView {
            ZStack {

                NavigationLink(destination: DetailView(show: $show), isActive: $show) {
                    Text("")
                }

                Button {
                    send()
                } label: {
                    Text("Send Notification")
                }
                .navigationBarTitle("Send Notification")
                .onAppear {
                    NotificationCenter.default.addObserver(forName: NSNotification.Name("Detail"), object: nil, queue: .main) { _ in
                        self.show = true
                    }
                }

            }
        }

    }

    func send() {

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in
            let content = UNMutableNotificationContent()
            content.title = "Message"
            content.body = "New Tutorial From Paige Software!!!"

            // MARK: SET ACTIONS AND CATEGORY
            let open = UNNotificationAction(identifier: "open", title: "Open", options: .foreground)
            let cancel = UNNotificationAction(identifier: "cancel", title: "Cancel", options: .destructive)
            let categories = UNNotificationCategory(identifier: "action", actions: [open, cancel], intentIdentifiers: [])
            UNUserNotificationCenter.current().setNotificationCategories([categories])
            content.categoryIdentifier = "action"

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let req = UNNotificationRequest(identifier: "req", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(req, withCompletionHandler: nil)
        }

    }

}

struct DetailView: View {

    @Binding var show: Bool

    var body: some View {

        VStack {
            Button {
                show = false
            } label: {
                Image(systemName: "arrow.left")
                    .font(.title)
            }
        }


    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
```
