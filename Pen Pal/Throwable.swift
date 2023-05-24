//
//  Throwable.swift
//  Pen Pal
//
//https://medium.com/@michaeldouglascs/how-to-safely-decode-arrays-using-decodable-result-type-in-swift-5b975ea11ff5
//

public struct Throwable<T: Decodable>: Decodable {
    
    public let result: Result<T, Error>

    public init(from decoder: Decoder) throws {
        let catching = { try T(from: decoder) }
        result = Result(catching: catching )
    }
}
