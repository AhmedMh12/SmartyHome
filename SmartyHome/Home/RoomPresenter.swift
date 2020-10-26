//
//  RoomPresenter.swift
//  SmartyHome
//
//  Created by Ahmed MAHOUCHI on 10/25/20.
//

import Foundation

struct RoomViewData{
    
    let name: String
    let devicesNumber: String
    let image: String
}

protocol RoomView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setRooms(_ rooms: [RoomViewData])
    func setEmptyRooms()
}

class RoomPresenter {
    fileprivate let roomService:RoomService
    weak fileprivate var roomView : RoomView?
    
    init(roomService:RoomService){
        self.roomService = roomService
    }
    
    func attachView(_ view:RoomView){
        roomView = view
    }
    
    func detachView() {
        roomView = nil
    }
    
    func getRooms(){
        self.roomView?.startLoading()
        roomService.getRooms{ [weak self] rooms in
            self?.roomView?.finishLoading()
            if(rooms.count == 0){
                self?.roomView?.setEmptyRooms()
            }else{
                let mappedRooms = rooms.map{
                    return RoomViewData(name: "\($0.name)", devicesNumber: "\($0.devicesNumber) Devices", image:  "\($0.image)")
                }
                self?.roomView?.setRooms(mappedRooms)
            }
            
        }
    }
}

