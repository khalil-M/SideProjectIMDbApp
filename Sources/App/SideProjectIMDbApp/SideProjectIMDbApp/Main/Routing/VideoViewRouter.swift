//
//  VideoViewRouter.swift
//  SideProjectIMDbApp
//
//  Created by Christian Slanzi on 27.09.21.
//

import UIKit
import IMDbApiModule

class VideoViewRouter: VideoViewRouting {
    
    var navigationController: UINavigationController?

    // route to video details screen
    func routeToVideoDetails() {
        let vc = IMDbAppDependencies.shared.makeVideoDetailsViewController()
        navigationController?.show(vc, sender: self)
    }
    
}
