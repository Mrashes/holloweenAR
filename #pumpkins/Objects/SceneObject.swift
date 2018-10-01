//
//  File.swift
//  #pumpkins
//
//  Created by Max Rashes on 9/30/18.
//  Copyright © 2018 Rashco. All rights reserved.
//

import Foundation
import SceneKit

class SceneObject: SCNNode {
    
    init(from file: String) {
        super.init()
        
        let nodesInFile = SCNNode.allNodes(from: file)
        nodesInFile.forEach { (node) in
            self.addChildNode(node)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class Pumpkin: SceneObject {
    init() {
        super.init(from: "halloween.dae")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var animating: Bool = false
    let patrolDistance: Float = 4.85
    
    func animate() {
        if animating { return }
        
        animating = true
        let rotateOne = SCNAction.rotateBy(x: 0, y: CGFloat(Float.random(min: -Float.pi, max: Float.pi)), z: 0, duration: 5.0)
        let hoverUp = SCNAction.moveBy(x: 0, y: 0.2, z: 0, duration: 2.5)
        let hoverDown = SCNAction.moveBy(x: 0, y: -0.2, z: 0, duration: 2.5)
        let hoverSequence = SCNAction.sequence([hoverUp, hoverDown])
        let rotateAndHover = SCNAction.group([rotateOne, hoverSequence])
        let repeatForever = SCNAction.repeatForever(rotateAndHover)
        
        runAction(repeatForever)
    }
    
    func patrol(targetPos: SCNVector3) {
        let distanceToTarget = targetPos.distance(receiver: self.position)
        
        if distanceToTarget < patrolDistance {
            removeAllActions()
            animating = false
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.20
            look(at: targetPos)
            SCNTransaction.commit()
        } else {
            if !animating {
                animate()
            }
        }
    }

}
