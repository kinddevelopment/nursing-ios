//
//  KDLog.swift
//  Nursing
//
//  Created by Markus Svensson on 2017-03-10.
//  Copyright © 2017 Markus Svensson. All rights reserved.
//

import Foundation

/**
 Replacement function for print that will also output the filename, linenumber and function name.
 Inspired by EVLog.
 
 - parameter object: What you want to log
 - parameter filename: Will be auto populated by the name of the file from where this function is called
 - parameter line: Will be auto populated by the line number in the file from where this function is called
 - parameter funcname: Will be auto populated by the function name from where this function is called
 */
public func KDLog<T>(_ object: T, filename: String = #file, line: Int = #line, funcname: String = #function) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss:SSS"
    let process = ProcessInfo.processInfo
    let threadId = "."
    print("\(dateFormatter.string(from: Date())) \(process.processName))[\(process.processIdentifier):\(threadId)] \((filename as NSString).lastPathComponent)(\(line)) \(funcname):\r\t\(object)\n")
}
