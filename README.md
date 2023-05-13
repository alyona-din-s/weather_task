# iOS Weather app

- Language  - Swift 5
- Architecture - MVVM
- Min Deployment iOS version - 14.0
- Orientation view - Portrait
- Supported Devices - iPhone, iPad

What is it for

- Display a list of cities
- Show weather info of the chosen city
- Be available in offline mode (displayed saved info)

Additional
- search of cities (online search with openweathermap.org API)
- an icon of weather (loading from openweathermap.org API)
- date of last update (to help check the offline mode)


UI

0. WeatherNavigation.swift - navigate View Controllers of the app
 - inits all dependency injections
 - Started with CitiesListVC
 - Shows WeatherOfCityVC as modal view
1. CitiesListVC.swift - View Controller of List with cities and search bar line: 
 - SearchBar(in CitiesSearchBar.swift)
 - List(Tableview) of cities (in CitiesListView.swift)
 - Loader View (UIActivityIndicatorView)
2. WeatherOfCityVC.swift - Modal View Controller with Weather info
 - Title with the City name and Country code
 - Icon with current weather (loaded from OpenWeatherMap)
 - Text view (info about the weather of chosen city)
 - Date of last update


API

3 GET requests: (in NetworkManagerProtocol.swift)
- city list  = "http://api.openweathermap.org/geo/1.0/direct"
- weather info of the city = "https://api.openweathermap.org/data/2.5/weather"
- weather icon = "https://openweathermap.org/img/w/"


Network connection. 

- NetworkManagerImpl with URLSession
- NetworkManagerMock with Local Mock data


Local Storage for offline mode

LocalStorage.swift (in LocalSourceProtocol.swift)
- LocalStorageImpl with UserDefaults


Tests

WeatherAppTests.swift

- test of loading cities
- test of loading weather info
