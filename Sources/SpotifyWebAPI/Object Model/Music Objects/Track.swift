import Foundation

/// A Spotify [track][1].
///
/// [1]: https://developer.spotify.com/documentation/web-api/reference/#object-trackobject
public struct Track: Hashable {

    /// The name of the track.
    public let name: String
    
    /**
     The album on which the track appears.
     
     The simplified version will be returned.
     
     Only available for the full track object.
     */
    public let album: Album?

    /**
     The artists who performed the track. The simplified versions will be
     returned.
    
     Each artist object includes a link in href to more detailed information
     about the artist.
     */
    public let artists: [Artist]?
    
    /// The [Spotify URI][1] for the track.
    ///
    /// [1]: https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids
    public let uri: String?
    
    /// The [Spotify ID][1] for the track.
    ///
    /// [1]: https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids
    public let id: String?
    
    /// Whether or not the track is from a [local file][1].
    ///
    /// When this is `true`, expect many of the other properties to be `nil`.
    ///
    /// [1]: https://developer.spotify.com/documentation/general/guides/working-with-playlists/#local-files
    public let isLocal: Bool
    
    /**
     The popularity of the track.
     
     The value will be between 0 and 100, with 100 being the most popular. The
     popularity is calculated by algorithm and is based, in the most part, on
     the total number of plays the track has had and how recent those plays are.
     Generally speaking, songs that are being played a lot now will have a
     higher popularity than songs that were played a lot in the past. Duplicate
     tracks (e.g. the same track from a single and an album) are rated
     independently. Artist and album popularity is derived mathematically from
     track popularity. Note that the popularity value may lag actual popularity
     by a few days: the value is not updated in real time.
     
     Only available for the full track object.
     */
    public let popularity: Int?
    
    /// The track length in milliseconds.
    public let durationMS: Int?

    /// The number of the track.
    ///
    /// If an album has several discs, the track number is the number on the
    /// specified disc.
    public let trackNumber: Int?
    
    /// Whether or not the track has explicit lyrics. `false` if unknown.
    public let isExplicit: Bool
    
    /**
     Part of the response when [Track Relinking][1] is applied. Else, `nil`. If
     `true`, the track is playable in the given market. Otherwise, `false`.
    
     See also `restrictions`.
     
     [1]: https://developer.spotify.com/documentation/general/guides/track-relinking-guide/
     */
    public let isPlayable: Bool?

    /**
     A link to the Spotify web API endpoint providing the full track object.
     
     Use `SpotifyAPI.getFromHref(_:responseType:)`, passing in `Track` as the
     response type to retrieve the results.
     */
    public let href: URL?

    /// A link to a 30 second preview of the track in MP3 format.
    ///
    /// Will probably be `nil` if this track was retrieved while using the
    /// client credentials flow manager.
    public let previewURL: URL?
    
    /**
     Known [external urls][1] for this track.

     - key: The type of the URL, for example: "spotify" - The [Spotify URL][2]
            for the object.
     - value: An external, public URL to the object.

     [1]: https://developer.spotify.com/documentation/web-api/reference/#object-externalurlobject
     [2]: https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids
     */
    public let externalURLs: [String: URL]?
    
    /// Known external IDs for the track.
    ///
    /// Only available for the full track object.
    public let externalIds: [String: String]?
    
    /**
     A list of the countries in which the track can be played, identified by
     their [ISO 3166-1 alpha-2 code][1].
    
     If a market parameter was supplied in the request that returned this track,
     then this property will be `nil` and `isPlayable` will be non-`nil`.
    
     See also `restrictions` and the [Track Relinking Guide][2].
     
     [1]: https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
     [2]: https://developer.spotify.com/documentation/general/guides/track-relinking-guide/
     */
    public let availableMarkets: [String]?

    /**
     Part of the response when [Track Relinking][1] is applied, and the
     requested track has been replaced with different track. The track link
     contains information about the originally requested track.
    
     [1]: https://developer.spotify.com/documentation/general/guides/track-relinking-guide/
     */
    public let linkedFrom: TrackLink?
    
    /**
     Part of the response when a content restriction, such as [Track
     Relinking][1], is applied.
     
     The key will be "reason", and the value will be one of the
     following:
     * "market" - The content item is not available in the given market.
     * "product" - The content item is not available for the user’s
       subscription type.
     * "explicit" - The content item is explicit and the user’s account is
       set to not play explicit content.
     
     Additional reasons and additional keys may be added in the future.
     
     See [TrackRestrictionObject][2], which this property is decoded from.
     
     [1]: https://developer.spotify.com/documentation/general/guides/track-relinking-guide/
     [2]: https://developer.spotify.com/documentation/web-api/reference/#object-trackrestrictionobject
     */
    public let restrictions: [String: String]?
    
    /// The disc number (usually 1 unless the album consists of more than one
    /// disc).
    public let discNumber: Int?

    /**
     The object type. Usually `track`, but may be `episode` if this was
     retrieved from a playlist.
     
     See also `SpotifyAPI.playlistTracks(_:limit:offset:market:)`.
     */
    public let type: IDCategory
    
    /**
     Creates a [Spotify track][1].
     
     - Parameters:
       - name: The name of the track.
       - album: The album on which the track appears.
       - artists: The artists who performed the track.
       - uri: The [Spotify URI][2] for the track.
       - id: The [Spotify ID][2] for the track.
       - isLocal: Whether or not the track is from a [local file][3].
       - popularity: The popularity of the track. Should be between 0 and 100,
             inclusive.
       - durationMS: The track length in milliseconds.
       - trackNumber: The number of the track. If an album has several discs,
             the track number is the number on the specified disc.
       - isExplicit: Whether or not the track has explicit lyrics.
       - isPlayable: Part of the response when [Track Relinking][4] is applied.
             Else, `nil`. If `true`, the track is playable in the given market.
             Otherwise, `false`.
       - href: A link to the Spotify web API endpoint providing the full track
             object.
       - previewURL: A link to a 30 second preview (MP3 format) of the track.
       - externalURLs: Known external IDs for the album.
             - key: The identifier type, for example:
               - "isrc": [International Standard Recording Code][5]
               - "ean": [International Article Number][6]
               - "upc": [Universal Product Code][7]
             - value: An external identifier for the object.
       - externalIds: Known external IDs for the track.
       - availableMarkets: A list of the countries in which the track can be
             played, identified by their [ISO 3166-1 alpha-2 code][8].
       - linkedFrom: Part of the response when [Track Relinking][4] is applied,
             and the requested track has been replaced with different track.
             The track link contains information about the originally requested
             track.
       - restrictions: Part of the response when a content restriction, such as
             [Track Relinking][4], is applied. Else, `nil`. The key will be
             "reason", and the value will be one of the following:
             * "market" - The content item is not available in the given
               market.
             * "product" - The content item is not available for the user’s
             subscription type.
             * "explicit" - The content item is explicit and the user’s account
               is set to not play explicit content.
             Additional reasons and additional keys may be added in the future.
             See [TrackRestrictionObject][9], which this property is decoded
             from.
       - discNumber: The disc number (usually 1 unless the album consists of
             more than one disc).
       - type: The object type. Usually `track`, but may be `episode` if
             this was retrieved from a playlist. The default is `track`.
     
     [1]: https://developer.spotify.com/documentation/web-api/reference/#object-trackobject
     [2]: https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids
     [3]: https://developer.spotify.com/documentation/general/guides/working-with-playlists/#local-files
     [4]: https://developer.spotify.com/documentation/general/guides/track-relinking-guide/
     [5]: http://en.wikipedia.org/wiki/International_Standard_Recording_Code
     [6]: http://en.wikipedia.org/wiki/International_Article_Number_%28EAN%29
     [7]: http://en.wikipedia.org/wiki/Universal_Product_Code
     [8]: https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
     [9]: https://developer.spotify.com/documentation/web-api/reference/#object-trackrestrictionobject
     */
    public init(
        name: String,
        album: Album? = nil,
        artists: [Artist]? = nil,
        uri: String? = nil,
        id: String? = nil,
        isLocal: Bool,
        popularity: Int? = nil,
        durationMS: Int? = nil,
        trackNumber: Int? = nil,
        isExplicit: Bool,
        isPlayable: Bool? = nil,
        href: URL? = nil,
        previewURL: URL? = nil,
        externalURLs: [String: URL]? = nil,
        externalIds: [String: String]? = nil,
        availableMarkets: [String]? = nil,
        linkedFrom: TrackLink? = nil,
        restrictions: [String: String]? = nil,
        discNumber: Int? = nil,
        type: IDCategory = .track
    ) {
        self.name = name
        self.album = album
        self.artists = artists
        self.uri = uri
        self.id = id
        self.isLocal = isLocal
        self.popularity = popularity
        self.durationMS = durationMS
        self.trackNumber = trackNumber
        self.isExplicit = isExplicit
        self.isPlayable = isPlayable
        self.href = href
        self.previewURL = previewURL
        self.externalURLs = externalURLs
        self.externalIds = externalIds
        self.availableMarkets = availableMarkets
        self.linkedFrom = linkedFrom
        self.restrictions = restrictions
        self.discNumber = discNumber
        self.type = type
    }
    
}

extension Track: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case name
        case album
        case artists
        case uri
        case id
        case isLocal = "is_local"
        case popularity
        case durationMS = "duration_ms"
        case trackNumber = "track_number"
        case isExplicit = "explicit"
        case isPlayable = "is_playable"
        case href
        case previewURL = "preview_url"
        case externalURLs = "external_urls"
        case externalIds = "external_ids"
        case availableMarkets = "available_markets"
        case linkedFrom = "linked_from"
        case restrictions
        case discNumber = "disc_number"
        case type

    }
    
}

extension Track: ApproximatelyEquatable {
    
    /**
     Returns `true` if all the `FloatingPoint` properties of `self` are
     approximately equal to those of `other` within an absolute tolerance of
     0.001 and all other properties are equal by the `==` operator. Else,
     returns `false`.
     
     Dates are compared using `timeIntervalSince1970`, so they are considered
     floating point properties for the purposes of this method.
     
     - Parameter other: Another instance of `Self`.
     */
    public func isApproximatelyEqual(to other: Self) -> Bool {
        
        return self.name == other.name &&
                self.artists == other.artists &&
                self.uri == other.uri &&
                self.id == other.id &&
                self.isLocal == other.isLocal &&
                self.popularity == other.popularity &&
                self.durationMS == other.durationMS &&
                self.trackNumber == other.trackNumber &&
                self.isExplicit == other.isExplicit &&
                self.isPlayable == other.isPlayable &&
                self.href == other.href &&
                self.previewURL == other.previewURL &&
                self.externalURLs == other.externalURLs &&
                self.externalIds == other.externalIds &&
                self.availableMarkets == other.availableMarkets &&
                self.linkedFrom == other.linkedFrom &&
                self.restrictions == other.restrictions &&
                self.discNumber == other.discNumber &&
                self.type == other.type &&
                self.album.isApproximatelyEqual(to: other.album)
        
    }
    
}
