//
//  RoomPresenterTests.swift
//  SmartyHomeTests
//
//  Created by Ahmed MAHOUCHI on 10/25/20.
//

import XCTest
@testable import SmartyHome

class RoomServiceMock: RoomService {
    fileprivate let Rooms: [Room]
    init(Rooms: [Room]) {
        self.Rooms = Rooms
    }
    override func getRooms(_ callBack: @escaping ([Room]) -> Void) {
        callBack(Rooms)
    }

}

class RoomViewMock : NSObject, RoomView{
    
    
    var setRoomsCalled = false
    var setEmptyRoomsCalled = false

    func setRooms(_ Rooms: [RoomViewData]) {
        setRoomsCalled = true
    }

    func setEmptyRooms() {
        setEmptyRoomsCalled = true
    }

    func startLoading() {
    }

    func finishLoading() {
    }

}
class RoomPresenterTest: XCTestCase {

    let emptyRoomsServiceMock = RoomServiceMock(Rooms:[Room]())

    let towRoomsServiceMock = RoomServiceMock(Rooms:[Room(name: "Room1", devicesNumber: 7, image: "livingroom"),
                                                     Room(name: "Room2", devicesNumber: 6, image: "mediaroom")])
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testShouldSetEmptyIfNoRoomAvailable() {
        //given
        let roomViewMock = RoomViewMock()
        let RoomPresenterUnderTest = RoomPresenter(roomService: emptyRoomsServiceMock)
        RoomPresenterUnderTest.attachView(roomViewMock)

        //when
        RoomPresenterUnderTest.getRooms()

        //verify
        XCTAssertTrue(roomViewMock.setEmptyRoomsCalled)
    }

    func testShouldSetRooms() {
        //given
        let roomViewMock = RoomViewMock()
        let RoomPresenterUnderTest = RoomPresenter(roomService: towRoomsServiceMock)
        RoomPresenterUnderTest.attachView(roomViewMock)

        //when
        RoomPresenterUnderTest.getRooms()

        //verify
        XCTAssertTrue(roomViewMock.setRoomsCalled)
    }

}
