import UIKit
import Flutter
import MusicKit

typealias Genres = MusicItemCollection<Genre>

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        
    let pingChannel = FlutterMethodChannel(name: "playlister", binaryMessenger: controller.binaryMessenger)
        
    pingChannel.setMethodCallHandler({
        [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        
        if(self?.getAuth() == false) {
            result("Not authorized to access Apple Music")
        }
        else{
            switch(call.method){
            case "ping":
                self?.ping(result: result)
            case "getPlaylist":
                guard let args = call.arguments else{
                    result("not playlist found")
                    return
                }
                guard let argStr = args as? [String: Any] else {
                    result("invalid type")
                    return
                }

                guard let playlistId = argStr["playlistId"] as? String else {
                    result("invalid type")
                    return
                }
                
                self?.getPlaylist(playlistId: playlistId, result: result)
            case "getGenre":
                guard let args = call.arguments else{
                    result("not playlist found")
                    return
                }
                guard let argStr = args as? [String: Any] else {
                    result("invalid type")
                    return
                }

                guard let test = argStr["test"] as? String else {
                    result("invalid type")
                    return
                }
                self?.getGenre(testStr: test, result: result)
            default:
                result(FlutterMethodNotImplemented)
            }
        }
      })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func ping(result: FlutterResult) {
        result("pong")
    }
    
    private func getPlaylist(playlistId: String, result: @escaping FlutterResult){
        Task{

            do {
//                let playlistUrl = "https://api.music.apple.com/v1/me/library/playlists/\(playlistId)"
                let playlistUrl = "https://api.music.apple.com/v1/catalog/us/playlists/pl.u-d2KlT4EZazo?include=tracks"
                print("url: " + playlistUrl)

                guard let url = URL(string: playlistUrl) else {
                    throw URLError(.badURL)
                }

                let request = MusicDataRequest(urlRequest: URLRequest(url: url))
                let response = try await request.response()

                print(response.data)
                result(String(data: response.data, encoding: .utf8)!)


            } catch {
                result("failed to request data")
                print(error)
            }
        }
        // https://music.apple.com/us/playlist/test-playlist/pl.u-d2KlT4EZazo
//        Task {
////            let playlistRequest = MusicCatalogResourceRequest<Playlist>(matching: \.id, equalTo: "pl.ba2404fbc4464b8ba2d60399189cf24e")
//            let playlistRequest = MusicCatalogResourceRequest<Playlist>(matching: \.id, equalTo: "pl.u-9yJIaY8lE5")
//            let playlistResponse = try await playlistRequest.response()
//
//            let encoder = JSONEncoder()
//            encoder.outputFormatting = .prettyPrinted
//
//            let data = try encoder.encode(playlistResponse)
//            print(String(data: data, encoding: .utf8)!)
//
//            result(String(data: data, encoding: .utf8)!)
//
//            if let playlist = playlistResponse.items.first {
//                print("\(playlist)")
//            } else {
//                print("Couldn't find playlist.")
//            }
//        }

    }
    
    private func getGenre(testStr: String, result: @escaping FlutterResult) {
        print("test str: " + testStr)
        
        Task{
        
            do {
//                let countryCode = try await MusicDataRequest.currentCountryCode
                let genreURL = "https://api.music.apple.com/v1/catalog/US/genres?limit=5"
                
                guard let url = URL(string: genreURL) else {
                    throw URLError(.badURL)
                }
                
                let request = MusicDataRequest(urlRequest: URLRequest(url: url))
                let response = try await request.response()
                
                let genre = try JSONDecoder().decode(Genres.self, from: response.data)
                print(genre)
                
                result(String(data: response.data, encoding: .utf8)!)
                
            } catch {
                result("failed to request data")
                print(error)
            }
        }
    }
    
    private func getAuth() -> Bool {
        if(MusicAuthorization.currentStatus == .authorized){
            return true
        }
        else if(MusicAuthorization.currentStatus == .notDetermined){
            let isAuth = true;
            Task{
                let _ = await MusicAuthorization.request()
            }
            return isAuth
        }
        return false
    }
    

    
}


