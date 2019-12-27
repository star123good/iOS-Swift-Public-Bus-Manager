//
//  ArtworkViews.swift
//  Public Bus Manager
//
//  Created by Boss on 2019/12/23.
//  Copyright © 2019 Boss. All rights reserved.
//
// These two classes are not used now.

import Foundation
import MapKit

class ArtworkMarkerView: MKMarkerAnnotationView {
  override var annotation: MKAnnotation? {
    willSet {
      // 1
      guard let artwork = newValue as? Artwork else { return }
      canShowCallout = true
      calloutOffset = CGPoint(x: -5, y: 5)
      rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
      // 2
      markerTintColor = artwork.markerTintColor
//      glyphText = String(artwork.discipline.first!)
        if let imageName = artwork.imageName {
          glyphImage = UIImage(named: imageName)
        } else {
          glyphImage = nil
        }
    }
  }
}


class ArtworkView: MKAnnotationView {
  override var annotation: MKAnnotation? {
    willSet {
      guard let artwork = newValue as? Artwork else {return}
      canShowCallout = true
      calloutOffset = CGPoint(x: -5, y: 5)
//      rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero,
           size: CGSize(width: 30, height: 30)))
        mapsButton.setBackgroundImage(UIImage(named: "Map-Marker-Marker-Inside-Chartreuse-icon"), for: UIControl.State())
        rightCalloutAccessoryView = mapsButton

      if let imageName = artwork.imageName {
        image = UIImage(named: imageName)
      } else {
        image = nil
      }
    }
  }
}
