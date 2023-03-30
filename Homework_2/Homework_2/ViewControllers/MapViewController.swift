//
//  MapViewController.swift
//  Homework_2
//
//  Created by Андрей Байдаченко on 24.03.2023.
//

import Foundation
import MapKit
import UIKit
import CoreLocation

final class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    
    private lazy var mapView = MKMapView(frame: .zero)
    private lazy var locationManager = CLLocationManager()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        userLocationPermission()
        setupView()
        configMap()
        addPins()
        addRoute()
        tapGesture()
    }

    
    private func userLocationPermission(){
        locationManager.requestWhenInUseAuthorization()
        print(locationManager.authorizationStatus.rawValue)
        locationManager.delegate = self
        
    }
    
    private func setupView(){
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    //настройка вида карты
    private func configMap(){
        mapView.showsScale = true
        mapView.showsUserLocation = true
        mapView.mapType = .standard
        mapView.showsCompass = true
        guard let location = locationManager.location?.coordinate else { return }
        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    //добавление пина на карту
    private func addPins(){
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 55.7499, longitude: 37.6290)
        annotation.title = "Москва"
        mapView.addAnnotation(annotation)
    }
    //прокладка маршрута
    private func addRoute(){
        let request = MKDirections.Request()
        //начальная точка
        let sourceCoordinate = CLLocationCoordinate2D(latitude: 38.1034, longitude: 13.4121)
        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinate)
        request.source = MKMapItem(placemark: sourcePlacemark)
        //конечная точка
        let destinationCoordinate = CLLocationCoordinate2D(latitude: 53.5125, longitude: 10.0004)
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate)
        request.destination = MKMapItem(placemark: destinationPlacemark)
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate { [weak self] response, error in
            
            guard let response else {
                return
            }
            let routes = response.routes[0]
            self?.mapView.delegate = self
            self?.mapView.addOverlay(routes.polyline, level: .aboveRoads)
            let rect = routes.polyline.boundingMapRect
            self?.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 5.0
        return renderer
    }
    //обработка долгого нажатия на карту
    private func tapGesture(){
        let longTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap))
            mapView.addGestureRecognizer(longTapGesture)
    }
    
    @objc func longTap(sender: UIGestureRecognizer){
        print("long tap")
           if sender.state == .began {
               let locationInView = sender.location(in: mapView)
               let locationOnMap = mapView.convert(locationInView, toCoordinateFrom: mapView)
               addAnnotation(location: locationOnMap)
               addRouteToGesture(by: locationOnMap)
           }
    }
    //добавляем пин на карту, без сохранения
    func addAnnotation(location: CLLocationCoordinate2D){
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = "Pin"
            self.mapView.addAnnotation(annotation)
    }
    
    private func addRouteToGesture(by destination: CLLocationCoordinate2D){
        let request = MKDirections.Request()
        //начальная точка
        guard let userCoordinate = locationManager.location?.coordinate else { return }
        let sourcePlacemark = MKPlacemark(coordinate: userCoordinate)
        request.source = MKMapItem(placemark: sourcePlacemark)
        //конечная точка
        let destinationCoordinate = destination
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate)
        request.destination = MKMapItem(placemark: destinationPlacemark)
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate { [weak self] response, error in
            guard let response else {
                return
            }
            let routes = response.routes[0]
            self?.mapView.delegate = self
            self?.mapView.addOverlay(routes.polyline, level: .aboveRoads)
            let rect = routes.polyline.boundingMapRect
            self?.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
    }
}

