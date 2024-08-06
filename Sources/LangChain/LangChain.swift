//
//  File.swift
//
//
//  Created by 顾艳华 on 2023/6/11.
//

import Foundation
import CryptoSwift

enum LangChainError: Error {
	case LoaderError(String)
	case ChainError
	case ToolError
}

extension Data{
	public func sha256() -> String{
		return hexStringFromData(input: digest(input: self as NSData))
	}

	private func digest(input : NSData) -> NSData {
		let data = [UInt8](input)
		var hash: [UInt8] = SHA3(variant: .sha256).calculate(for: data)
		return NSData(bytes: hash, length: hash.count )
	}

	private  func hexStringFromData(input: NSData) -> String {
				var bytes = [UInt8](repeating: 0, count: input.length)
				input.getBytes(&bytes, length: input.length)

				var hexString = ""
				for byte in bytes {
					hexString += String(format:"%02x", UInt8(byte))
				}

				return hexString
			}
	}

	public extension String {
				func sha256() -> String{
					if let stringData = self.data(using: String.Encoding.utf8) {
						return stringData.sha256()
					}
					return ""
				}
			}
