//
//  ContentView.swift
//  NotificationUserActionSwiftUI
//
//  Created by paige on 2022/01/15.
//

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

