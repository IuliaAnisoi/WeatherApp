# WeatherApp

Weather app built for iOS using the MVVM architecture, the Repository pattern and RxSwift. The REST API used is OpenWeatherMap.

After getting the user's permission, CoreLocation is used to get the user's current location and display it on the screen.

The first screen displays a list of favourite locations. This list is editable, meaning that one can add new cities by searching for them. I implemented the search functionality using MKLocalSearchCompleter from MapKit. The list is saved in UserDefaults.
