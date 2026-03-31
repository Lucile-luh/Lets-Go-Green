# My App (Lets-Go-Green)
Community Clean-Up and Tree Planting  Planner


## Description
Let’s Go Green is a SwiftUI-based community sustainability app that helps users discover, create, and join local environmental events such as cleanups and tree-planting activities.

The app includes secure user authentication, allowing people to sign up, log in, and manage their session. Once signed in, users can browse upcoming events, create their own events, and join activities they want to participate in. Each event includes key details such as the title, description, location, date, and time.

To improve engagement and usability, the app provides a calendar view for tracking event dates, a map view for locating event venues, participant tracking for each event, and a profile page where users can review their joined events and activity summary. It also supports sharing event details with others through the system share feature.

From a technical perspective, the app is built with SwiftUI for the interface, SwiftData for local event and participant storage, Supabase for authentication, and MapKit/UIKit for location and calendar functionality.

### Notable technologies or Frameworks
- Swift​UI: Main UI framework for screens and navigation.
- Swift​Data: Local persistence for events and participants.
- Supabase: Backend/authentication for sign up, login, session handling, and logout.
- Map​Kit: Event location display and geocoding.
-  UIKit: Used for the embedded calendar view with UICalendar​View.
-  Swift concurrency: async​/await is used for auth and geocoding flows.


## Requirements
- Xcode 15.0 or later
- iOS 17.0+ / macOS 14.0+ (adjust based on your deployment target)
- Swift 5.9+

## Set up instructions
1. **Clone the Repository**
 ```bash
   git clone https://github.com/Lucile-luh/Lets-Go-Green.git
   cd your-project
   ```
2. **Open the project**
   - Open `YourProject.xcodeproj` or `YourProject.xcworkspace` in Xcode

3. **Install dependencies** (if using SPM, CocoaPods, or Carthage)
   - For Swift Package Manager: Dependencies should resolve automatically
   - For CocoaPods: Run `pod install`
   - For Carthage: Run `carthage update`

4. **Configure signing**
   - Select your development team in the project settings
   - Update the bundle identifier if needed

5. **Build and run**
   - Select your target device or simulator
   - Press `Cmd + R` to build and run the project

## Project Structure

```
LetsGoGreen
├── LetsGoGreen
│   ├── App Services
│   │   └── EventStore.swift
│   │
│   ├── Models
│   │   ├── AuthViewModel.swift
│   │   ├── eventViewModel.swift
│   │   └── JoinModel.swift
│   │
│   ├── Views
│   │   ├── Authentication
│   │   │   ├── logInPage.swift
│   │   │   ├── signUpPage.swift
│   │   │   └── Supabase.swift
│   │   │
│   │   ├── creating and joining
│   │   │   ├── BottomNavBar.swift
│   │   │   ├── createEventPage.swift
│   │   │   ├── EventlistPage.swift
│   │   │   ├── joinEventPage.swift
│   │   │   └── ProfilePage.swift
│   │   │
│   │   └── onboarding pages
│   │       ├── HomePage.swift
│   │       ├── LetsGoGreenApp.swift
│   │       └── welcomePage.swift
│   │
│   ├── Assets.xcassets
│   ├── Config.xcconfig
│   └── ContentView.swift
│
└── Products
    └── LetsGoGreen.app
```

## Features
- User sign up and login: Users can create an account and sign in securely.
- Home dashboard: Shows the app intro, community images, and a calendar with event dates highlighted.
- Event creation: Users can add new cleanup or tree-planting events with a title, location, description, date, and time.
- Event list: Displays upcoming events in one place and lets users open each event’s details.
- Join events: Users can register for an event and optionally add their contact details.
- Event map view: Each event includes a map that tries to locate the event address.
- Share/invite feature: Users can share event details with others through the system share sheet.
- Participant tracking: Each event shows how many people joined and lists participants.
- Profile page: Users can track joined events, see upcoming/completed counts, and sign out.

## Notes

- **Known Issues**: N\A

- **Future Improvements**:
  - be able to use maps to look and assign clean-up zones, show where volunteers are working, or allow volunteers to report problem areas.
  - be able to keep records of individuals who attended the event
  - be able to  be able to collect donations of equipment to help them out
  - be able to get badges for participating in the  event
  - be able to provide feedback on past events to improve future planning.
  - be able to upload pictures from the event onto the platform.
  - be able to keep records of all past events and whether they were successful.
  - Users should receive reminders and notifications about upcoming events.

  
- **Architecture**: It follows a MVVM-style SwiftUI structure.
  
- **Testing**: There no test files as of yet


## Contact

Your Name - [@Lucile-luh](https://twitter.com/yourhandle) - lucilemuchemwa374@gmail.com

Project Link: [https://github.com/Lucile-luh/Lets-Go-Green](https://github.com/yourusername/your-project)





