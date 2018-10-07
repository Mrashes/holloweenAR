//
//  Plane.swift
//  #pumpkins
//
//  Created by Max Rashes on 10/7/18.
//  Copyright © 2018 Rashco. All rights reserved.
//

import Foundation
import SceneKit


class Plane: SCNNode {

//    var planeAnchor: ARPlaneAnchor
//
//    var planeGeometry: SCNPlane
//    var planeNode: SCNNode
//
//    init(_ anchor: ARPlaneAnchor) {
//
//        self.planeAnchor = anchor
//
//        let grid = UIImage(named: "plane_grid.png")
//        self.planeGeometry = SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z))
//        let material = SCNMaterial()
//        material.diffuse.contents = grid
//        self.planeGeometry.materials = [material]
//
//        self.planeGeometry.firstMaterial?.transparency = 0.5
//        self.planeNode = SCNNode(geometry: planeGeometry)
//        self.planeNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2.0, 1, 0, 0)
//
//        super.init()
//
//        self.addChildNode(planeNode)
//
//        self.position = SCNVector3(anchor.center.x, -0.002, anchor.center.z) // 2 mm below the origin of plane.
//    }
}
