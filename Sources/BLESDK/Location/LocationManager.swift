//
//  LocationManager.swift
//  BLESDK
//
//  Created by Jefin Abdul Jaleel on 21/11/25.
//


import Foundation
import CoreLocation

/// Manages location services for the BLE SDK.
///
/// `LocationManager` wraps CoreLocation functionality to provide GPS location data
/// for discovered BLE devices. It handles location permission requests, updates,
/// and authorization state changes.
public class LocationManager: NSObject {
    private let locationManager: CLLocationManager
    private let logger: Logger
    private var isEnabled: Bool
    
    public var currentLocation: CLLocation? {
        locationManager.location
    }
    
    public init(enabled: Bool = true, logger: Logger = Logger(category: Constants.loggerCategoryLocation)) {
        self.isEnabled = enabled
        self.logger = logger
        self.locationManager = CLLocationManager()
        super.init()
        
        if enabled {
            setupLocationManager()
        }
    }
    
    /// Configures the CoreLocation manager with optimal settings.
    ///
    /// Sets up the location manager delegate, accuracy level, and distance filter,
    /// then checks the current authorization status.
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        
        checkAuthorizationStatus()
    }
    
    /// Checks the current location authorization status and takes appropriate action.
    ///
    /// This method evaluates the app's location permission status and either requests
    /// permission, starts location updates, or logs an error.
    private func checkAuthorizationStatus() {
        #if os(iOS)
        let status: CLAuthorizationStatus
        if #available(iOS 14.0, *) {
            status = locationManager.authorizationStatus
        } else {
            status = CLLocationManager.authorizationStatus()
        }
        
        switch status {
        case .notDetermined:
            logger.info(Constants.requestingLocationAuth)
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            logger.info(Constants.locationAuthorized)
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            logger.error(Constants.locationDeniedOrRestricted)
        @unknown default:
            logger.error(Constants.unknownLocationAuthStatus)
        }
        #endif
    }
    
    // MARK: - Public Methods
       
    /// Starts receiving location updates.
    ///
    /// Begins the flow of location updates from CoreLocation. Does nothing if
    /// location tracking is disabled.
    public func startUpdating() {
        guard isEnabled else { return }
        locationManager.startUpdatingLocation()
        logger.debug(Constants.startedLocationUpdates)
    }
    
    /// Stops receiving location updates.
    ///
    /// Halts the flow of location updates from CoreLocation. Does nothing if
    /// location tracking is disabled.
    public func stopUpdating() {
        guard isEnabled else { return }
        locationManager.stopUpdatingLocation()
        logger.debug(Constants.stoppedLocationUpdates)
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    /// Called when new location data is available.
    ///
    /// This delegate method receives location updates from CoreLocation and logs
    /// the new coordinates.
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        logger.debug(Constants.locationUpdated + "\(location.coordinate.latitude), \(location.coordinate.longitude)")
    }
    
    /// Called when the location manager encounters an error.
    ///
    /// This delegate method handles location errors such as denied permissions,
    /// location services disabled, or network failures.
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        logger.error(Constants.locationManagerFailed + error.localizedDescription)
    }
    
    /// Called when the app's authorization status for location services changes.
    ///
    /// This delegate method monitors changes to location permission status and
    /// re-evaluates whether to start or stop location updates.
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAuthorizationStatus()
    }
}
