//
//  LocationSearchViewModel.swift
//  BSDLink
//
//  Created by Azalia Amanda on 07/04/25.
//

import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject {
    @Published var results = [MKLocalSearchCompletion]()
//    @Published var selectedStartLocation: String = ""
//    @Published var selectedEndLocation: String = ""
    
    private let startLocactionSearchCompleter = MKLocalSearchCompleter()
    var startLocationQueryFragment: String = "" {
        didSet {
            startLocactionSearchCompleter.queryFragment = startLocationQueryFragment
        }
    }
    
    private let endLocactionSearchCompleter = MKLocalSearchCompleter()
    var endLocationQueryFragment: String = "" {
        didSet {
            endLocactionSearchCompleter.queryFragment = endLocationQueryFragment
        }
    }
    
    override init() {
        super.init()
        
        startLocactionSearchCompleter.delegate = self
        startLocactionSearchCompleter.queryFragment = startLocationQueryFragment
        
        endLocactionSearchCompleter.delegate = self
        endLocactionSearchCompleter.queryFragment = endLocationQueryFragment
    }
    
    func selectLocation(_ location: String, textField: String) {
        if (textField == "from") {
            self.startLocationQueryFragment = location
        } else {
            self.endLocationQueryFragment = location
        }
    }
}

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
