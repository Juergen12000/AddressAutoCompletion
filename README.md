Swift-Sample for Autocompletion of Address using MapKit and Google Places API for iOS-Versions lower than 9.3.
In this Sample I'm using a UISearchBar for input and UITableView for presenting the results of AddressAutoCompletion.

The reason why i created this sample, is that you only get 1000 or 150000 free requests per day from Google Places API (source: https://developers.google.com/places/web-service/usage). The autocompletion based on MapKit-Framework is only working for iOS-Devices with an minimum iOS-Version of 9.3.


You need the following in your podfile:
```ruby
pod 'HNKGooglePlacesAutocomplete', '~> 1.2'
```
  
and this in your AppDelegate:
```swift
func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        if #available(iOS 9.3, *){}
        else
        {
            HNKGooglePlacesAutocompleteQuery.setupSharedQueryWithAPIKey("YOUR GOOGLE PLACES API WEB SERVICE KEY")
        }
        
        return true
}
```

Help for API-Key-Creation: https://developers.google.com/places/android-api/signup

#### IMPORTANT: Use an API-Key for "Google Places API Web Service". A key for "Google Places API for iOS" won't work!
