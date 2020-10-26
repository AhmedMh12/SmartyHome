//
//  RoomService.swift
//  SmartyHome
//
//  Created by Ahmed MAHOUCHI on 10/25/20.
//

import Foundation
class RoomService {

    //the service delivers mocked data with a delay
    func getRooms(_ callBack:@escaping ([Room]) -> Void){
        let rooms = [Room(name: "Living Room", devicesNumber: 4, image: "livingroom"),
                     Room(name: "Media Room", devicesNumber: 6, image: "mediaroom"),
                     Room(name: "Bathroom", devicesNumber: 1, image: "bathroom"),
                     Room(name: "Bedroom", devicesNumber: 3, image: "bedroom")
        ]
        let delayTime = DispatchTime.now() + Double(Int64(2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            callBack(rooms)
        }
    }
}
