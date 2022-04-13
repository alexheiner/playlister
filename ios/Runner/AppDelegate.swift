import UIKit
import Flutter
import MusicKit
import Foundation

struct LibraryPlaylistRequest: Codable {
        var attributes: Attributes
        var relationships: Relationships
        
        struct Attributes: Codable {
            var name: String
            var description: String?
        }
        
        struct Relationships: Codable {
            var tracks: LibraryPlaylistTracksRequest
            
            init(tracks: [LibraryPlaylistRequestTrack]) {
                self.tracks = LibraryPlaylistTracksRequest(data: tracks)
            }
        }
        
        init(name: String, description: String?, tracks: [LibraryPlaylistRequestTrack]) {
            self.attributes = Attributes(name: name, description: description)
            self.relationships = Relationships(tracks: tracks)
        }
    }

struct LibraryPlaylistTracksRequest: Codable {
        var data: [LibraryPlaylistRequestTrack]
    }

struct LibraryPlaylistRequestTrack: Codable {
        var id: String
        var type: String
        
        enum TrackType: String {
            case songs = "songs"
            case librarySongs = "library-songs"
        }
    }

enum ExportError: Error {
    case runtimeError(String)
}

struct ExportResult: Codable{
    var data: String
    var success: Bool
    var message: String
    
    init(data: String, success: Bool, message: String) {
        self.data = data
        self.success = success
        self.message = message
    }
    
}



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
            case "exportPlaylistFromApple":
                guard let args = call.arguments else{
                    result("not playlist found")
                    return
                }
                guard let argStr = args as? [String: Any] else {
                    result("invalid type")
                    return
                }

                guard let name = argStr["name"] as? String else {
                    result("invalid type")
                    return
                }
                guard let tracks = argStr["tracks"] as? String else {
                    result("invalid type")
                    return
                }
                
                self?.exportPlaylistFromApple(name: name, tracks: tracks, result: result)
            case "exportPlaylistFromSpotify":
                guard let args = call.arguments else{
                    result("not playlist found")
                    return
                }
                guard let argStr = args as? [String: Any] else {
                    result("invalid type")
                    return
                }

                guard let name = argStr["name"] as? String else {
                    result("invalid type")
                    return
                }
                guard let tracks = argStr["tracks"] as? String else {
                    result("invalid type")
                    return
                }

                self?.exportPlaylistFromSpotify(name: name, tracks: tracks, result: result)
            default:
                result(FlutterMethodNotImplemented)
            }
        }
      })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func exportPlaylistFromApple(name: String, tracks: String, result: @escaping FlutterResult){
        
        let data = tracks.data(using: .utf8)!
        Task {
            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>] {
                    var songs = [LibraryPlaylistRequestTrack]()
                    print(jsonArray) // use the json here
                    for value in jsonArray {
                        let id = value["id"] as! String?
                        let type = value["type"] as! String?
                        
                        let track = LibraryPlaylistRequestTrack(id: id ?? "", type: type ?? "songs")
                        print("working on track: \(track)")
                        songs.append(track)
                    }
                    
                    let requestBody = LibraryPlaylistRequest(name: name, description: nil, tracks: songs)
                    let _ = try await addPlaylistToLibrary( requestBody: requestBody)

                    result("success")
                    

                } else {
                    print("bad json")
                    result("fail")
                }
            } catch let error as NSError {
                
                print(error)
                result("fail")
            }
        }
    }

    
    private func exportPlaylistFromSpotify(name: String, tracks: String, result: @escaping FlutterResult){
        let data = tracks.data(using: .utf8)!
        Task {
            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>]
                {
                    var songs = [LibraryPlaylistRequestTrack]()
                    print(jsonArray) // use the json here
                    for value in jsonArray {
                        let trackName = value["name"] as! String
                        let artists = value["artists"] as! [Dictionary<String,Any>]
                        let artist = artists[0]["name"] as! String
                        
                        var trackNameFormat = trackName;
                        if let i = trackName.firstIndex(of: "("){
//                            let tr = String(trackName.prefix(i)) ?? ""
                            trackNameFormat = String(trackName[..<i])
                        }
                        
                            // encode strings
                        let trackNameEnc = trackNameFormat.replacingOccurrences(of: " ", with: "+")
                        let artistEnc = artist.replacingOccurrences(of: " ", with: "+")
                        
                        
                        
                        print("trackNameEnc: \(trackNameEnc)")
                        print("artistEnc: \(artistEnc)")
                        do{

                            var request = MusicCatalogSearchRequest(term: "\(artistEnc)+\(trackNameEnc)", types: [Song.self])
                            request.limit = 2

                            let searchResponse = try await request.response()
                            let retSong = searchResponse.songs[0];
                            print(retSong)
                            songs.append(LibraryPlaylistRequestTrack(id: retSong.id.rawValue, type: "songs"))
                            
                            

                        } catch {
                            print(error)

                            result("fail")
                        }
                    }
                    let requestBody = LibraryPlaylistRequest(name: name, description: nil, tracks: songs)
                    
                    let _ = try await addPlaylistToLibrary( requestBody: requestBody)

                    result("success")
                } else {
                    print("bad json")
                    result("fail")
                }
            } catch let error as NSError {
                print(error)
                result("fail")
            }
        }
    }
    
    private func addPlaylistToLibrary(requestBody: LibraryPlaylistRequest) async throws -> MusicDataResponse{

        let urlStr = "https://api.music.apple.com/v1/me/library/playlists"
        do{
            guard let url = URL(string: urlStr) else {
                throw URLError(.badURL)
            }

            var urlReq = URLRequest(url: url)

            urlReq.httpMethod = "POST"

            urlReq.httpBody = getRequestBody(body: requestBody);


            let request = MusicDataRequest(urlRequest: urlReq)

            let response = try await request.response()

            print(response.data)
            return response


        } catch {
            print(error)
            throw ExportError.runtimeError("Unable to export")
        }
        
    }
    
    private func ping(result: FlutterResult) {
        result("pong")
    }
    
    private func getPlaylist(playlistId: String, result: @escaping FlutterResult){
        Task{

            do {
                let playlistUrl = "https://api.music.apple.com/v1/catalog/us/playlists/\(playlistId)?include=tracks"
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
    
    private func getRequestBody<Body: Codable>(body: Body) -> Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(body)
    }
    

    
}


