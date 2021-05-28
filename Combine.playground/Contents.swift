/*
 Combine -> iOS 13이상부터 지원, 13 미만은 rx사용
https://developer.apple.com/documentation/combine
 Publisher: rx의 Obserable, 제네릭 형태로 데이터와 에러타입을 보냄
            Never -> 에러발생X (옵션)
 Subscriber: Publisher에서 보낸 이벤트를 받음
*/

import UIKit
import Combine

// Publisher 선언
// Publishers.Sequence< output(데이터), error(failure 타입) >
var intArrayPub: Publishers.Sequence<[Int], Never> = [1,2,3].publisher

// 데이터 받기: sink, assign
intArrayPub.sink(receiveCompletion: { completion in
  switch completion {
    case .finished: print("완료")
    case .failure(let error): print("Error: \(error)")
  }
}, receiveValue: {receiveValue in
  print("Value: \(receiveValue)")
})

//==================================================================================
// Notification 이벤트
var myNoti = Notification.Name("어플 이름")
var myPub = NotificationCenter.default.publisher(for: myNoti) // publisher
var mySub: AnyCancellable? // 받기
var myCancel = Set<AnyCancellable>()

// 이벤트 발생
NotificationCenter.default.post(Notification(name: myNoti))
NotificationCenter.default.post(Notification(name: myNoti))

// 이벤트 받기
mySub = myPub.sink(receiveCompletion: { completion in
  switch completion {
    case .finished: print("완료")
    case .failure(let error): print("Error: \(error)")
  }
}, receiveValue: {receiveValue in
  print("Value: \(receiveValue)")
})

// 메모리 해제
// mySub?.cancel()
mySub?.store(in: &myCancel)

//==================================================================================
// KVO - Key Value Observing
class MyFriend {
  var name = "Name1" {
    didSet{
      print("did Set Name: \(name)")
    }
  }
}
var myFriend = MyFriend()
var myFriendSub: AnyCancellable = ["Name2"].publisher.assign(to: \.name, on: myFriend)
