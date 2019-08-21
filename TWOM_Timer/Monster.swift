//
//  Monster.swift
//  TWOM_Timer
//
//  Created by Young Kim on 6/25/19.
//  Copyright © 2019 Young Jin Kim. All rights reserved.
//

import Foundation
import UIKit

class Monster {
    
    var image: UIImage?
    var name: String?
    var respawn: Int
    var color: UIColor
    
    init(image: UIImage, name: String, respawn: Int, color: UIColor) {
        self.image = image
        self.name = name
        self.respawn = respawn
        self.color = color
    }
    
    class func createMonsterArray() -> [Monster] {
        var monsters: [Monster] = []
        
        let redGhost = Monster(image: #imageLiteral(resourceName: "Red-Ghost"), name: "Red", respawn: 3990, color:UIColor.red)
        let blueGhost = Monster(image: #imageLiteral(resourceName: "Blue-Ghost"), name: "Blue", respawn: 3900, color:UIColor.blue)
        let greenGhost = Monster(image: #imageLiteral(resourceName: "Green-Ghost"), name: "Green", respawn: 4080, color:UIColor(red: 0, green: 0.8784, blue: 0.3922, alpha: 1.0))
        let awakenKooi = Monster(image: #imageLiteral(resourceName: "Awaken-Kooii"), name: "Awaken Kooi", respawn: 3780, color: UIColor(red: 0, green: 0.6157, blue: 0.6275, alpha: 1.0) )
        let guardianImp = Monster(image: #imageLiteral(resourceName: "Guardian-Imp"), name: "Guardian Imp", respawn: 3780, color: UIColor.orange)
        
        monsters.append(redGhost)
        monsters.append(blueGhost)
        monsters.append(greenGhost)
        monsters.append(awakenKooi)
        monsters.append(guardianImp)
        return monsters
    }
}
