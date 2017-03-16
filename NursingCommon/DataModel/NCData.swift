//
//  NCData.swift
//  Nursing
//
//  Created by Markus Svensson on 2017-03-10.
//  Copyright © 2017 Markus Svensson. All rights reserved.
//

import Foundation

/**
 Protocol for the data providers providing storage of the data model.
 */
protocol NCDataProvider {
    
    /**
     Perform the required setup of the data provider such as creating files,
     listen to notifications, register on a cloud service etc.
     */
    func setup()
    
    /**
     Inform the data provider that the application received a remote notification.
     
     - parameter userInfo: The userInfo from the notification.
     - parameter executeIfNonQuery: Will be called if the notification is not applicable to the provider.
     - parameter completed: Executed when all notifications are processed.
     */
    func didReceiveRemoteNotification(_ userInfo: [AnyHashable: Any], executeIfNonQuery: () -> Void, completed: @escaping () -> Void)
    
    /**
     Inform the data provider that the application did enter background
     */
    func applicationDidEnterBackground(application: UIApplication)
    
    /**
     Connect and start the data provider.
     
     -parameter dataChangedHandler: Will be called when the data in the model has been changed in any way.
     */
    func connect(dataChangedHandler: (() -> Void))
    
    /**
     Disconnect the data provider.
     */
    func disconnect()
}

/**
 Abstract singleton class used as an interface against a data provider.
 */
public class NCData {
    private static let sharedInstance = NCData()
    private var provider: NCDataProvider?
    
    private init() {
        // Private initialization to ensure just one instance is created.
        provider = nil
    }
    
    private func setup() {
        guard let prov = self.provider else {
            KDLog("WARNING: Provider hasn't been set.")
            return
        }
        prov.setup()
    }
    
    private func didReceiveRemoteNotification(_ userInfo: [AnyHashable: Any], executeIfNonQuery: () -> Void, completed: @escaping () -> Void) {
        guard let prov = self.provider else {
            KDLog("WARNING: Provider hasn't been set.")
            return
        }
        
        prov.didReceiveRemoteNotification(userInfo, executeIfNonQuery: { 
            executeIfNonQuery()
        }) { 
            completed()
        }
    }
    
    private func applicationDidEnterBackground(application: UIApplication) {
        guard let prov = self.provider else {
            KDLog("WARNING: Provider hasn't been set.")
            return
        }
        prov.applicationDidEnterBackground(application: application)
    }
    
    private func connect(dataChangedHandler: (() -> Void)) {
        guard let prov = self.provider else {
            KDLog("WARNING: Provider hasn't been set.")
            return
        }
        prov.connect {
            dataChangedHandler()
        }
    }
    
    private func disconnect() {
        guard let prov = self.provider else {
            KDLog("WARNING: Provider hasn't been set.")
            return
        }
        prov.disconnect()
    }
    
    /**
     Set the provider and perform the required setup such as creating files,
     listen to notifications, register on a cloud service etc.
     
     - parameter provider: The data provider to be used.
     */
    class func setup(provider: NCDataProvider) {
        self.sharedInstance.provider = provider
        self.sharedInstance.setup()
    }
    
    /**
     Inform the data provider that the application received a remote notification.
     If the provider hasn't been set this method will do nothing.
     
     - parameter userInfo: The userInfo from the notification.
     - parameter executeIfNonQuery: Will be called if the notification is not applicable to the provider.
     - parameter completed: Executed when all notifications are processed.
     */
    class func didReceiveRemoteNotification(_ userInfo: [AnyHashable: Any], executeIfNonQuery: () -> Void, completed: @escaping () -> Void) {
        self.sharedInstance.didReceiveRemoteNotification(userInfo, executeIfNonQuery: { 
            executeIfNonQuery()
        }) { 
            completed()
        }
    }
    
    /**
     Inform the data provider that the application did enter background.
     If the provider hasn't been set this method will do nothing.
     */
    class func applicationDidEnterBackground(application: UIApplication) {
        self.sharedInstance.applicationDidEnterBackground(application: application)
    }
    
    /**
     Connect and start the data provider.
     If the provider hasn't been set this method will do nothing.
     
     -parameter dataChangedHandler: Will be called when the data in the model has been changed in any way.
     */
    class func connect(dataChangedHandler: (() -> Void)) {
        self.sharedInstance.connect {
            dataChangedHandler()
        }
    }
    
    /**
     Disconnect the data provider.
     
     If the provider hasn't been set this method will do nothing.
     */
    class func disconnect() {
        self.sharedInstance.disconnect()
    }
    
}
