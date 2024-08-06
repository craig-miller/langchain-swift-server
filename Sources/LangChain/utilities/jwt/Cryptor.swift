import Foundation
//import CommonCrypto
//import Crypto
import CryptoSwift

class Cryptor {

	static func hmac(string: String, algorithm: Algorithm, key: String) -> String? {
		//		        guard let key = key.data(using: .utf8) else { return nil }
		//		        guard let string = string.data(using: .utf8) else { return nil }
		//
		//		        let context = UnsafeMutablePointer<CCHmacContext>.allocate(capacity: 1)
		//		        defer { context.deallocate() }
		//
		//		        key.withUnsafeBytes { (buffer: UnsafePointer<UInt8>) in
		//		            CCHmacInit(context, algorithm.HMACAlgorithm, buffer, size_t(key.count))
		//		        }
		//
		//		        string.withUnsafeBytes { (buffer: UnsafePointer<UInt8>) in
		//		          CCHmacUpdate(context, buffer, size_t(string.count))
		//		        }

		//		        var hmac = Array<UInt8>(repeating: 0, count: Int(algorithm.digestLength))
		//		        CCHmacFinal(context, &hmac)

		do {
			let key: Array<UInt8> = try Array<UInt8>(hex: key)
			let msg: Array<UInt8> = try Array<UInt8>(hex:string)
			let hmac: Array<UInt8> = try HMAC(key: key, variant: algorithm.HMACAlgorithm).authenticate(msg)
			return Data(hmac).base64URLEncodedString()
		} catch {
		}
		return nil
	}

	enum Algorithm {
		case MD5, SHA1, SHA224, SHA256, SHA384, SHA512

		var HMACAlgorithm: HMAC.Variant {
			var result: HMAC.Variant = .md5
			switch self {
				case .MD5:      result = .md5
				case .SHA1:     result = .sha1
				case .SHA224:   result = .sha2(.sha224)
				case .SHA256:   result = .sha2(.sha256)
				case .SHA384:   result = .sha2(.sha384)
				case .SHA512:   result = .sha2(.sha512)
			}
			return result
		}
	}
}


