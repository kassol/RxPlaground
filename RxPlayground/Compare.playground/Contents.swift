//: Playground - noun: a place where people can play

import UIKit
import RxSwift

example("immutable") {
    var array = [1, 2, 3]
    for num in array {
        print(num)
        array = [4, 5, 6]
    }
    print(array)
}


example("just, of, from") {

    let disposeBag = DisposeBag()

    let one = 1
    let two = 2
    let three = 3

    let observable = Observable.just(one)
    let observable2 = Observable.of(one, two, three)
    let observable3 = Observable.of([one, two, three])
    let observable4 = Observable.from([one, two, three])

    observable.subscribe(onNext: { value in
        print(value)
    }).addDisposableTo(disposeBag)
//    observable2.subscribe(onNext: { value in
//        print(value)
//    }).addDisposableTo(disposeBag)
//    observable3.subscribe(onNext: { value in
//        print(value)
//    }).addDisposableTo(disposeBag)
//    observable4.subscribe(onNext: { value in
//        print(value)
//    }).addDisposableTo(disposeBag)
}

example("observable") {
    let disposeBag = DisposeBag()

    Observable<String>.create{ observer in
        observer.onNext("1")
        observer.onCompleted()
        observer.onNext("2")
        return Disposables.create()
        }.subscribe{
            print($0)
        }.addDisposableTo(disposeBag)
}

example("deffered") {
    let disposeBag = DisposeBag()

    var flip = false

    let factory: Observable<Int> = Observable.deferred {
        flip = !flip
        if flip {
            return Observable.of(1, 2, 3)
        } else {
            return Observable.of(4, 5, 6)
        }
    }

    for _ in 0...3 {
        factory.debug().subscribe(onNext: {
            print($0, terminator: "")
        }).addDisposableTo(disposeBag)
        print()
    }
}


example("PublishSubject") {
    let disposeBag = DisposeBag()

    let subject = PublishSubject<String>()

    subject.onNext("Before")

    subject.debug().subscribe{
        print($0)
    }.addDisposableTo(disposeBag)

    subject.on(.next("After"))
    subject.onCompleted()
    subject.onNext("testcomplete")
}


example("BehaviorSubject") {
    let disposeBag = DisposeBag()

    let subject = BehaviorSubject<String>(value: "Initial")

    subject.onNext("1")
    subject.onNext("2")

    subject.subscribe{
        print($0)
    }.addDisposableTo(disposeBag)

    subject.onNext("3")

}

example("ReplaySubject") {
    let disposeBag = DisposeBag()

    let subject = ReplaySubject<Int>.create(bufferSize: 3)
    subject.onNext(1)
    subject.onNext(2)
    subject.onNext(3)
    subject.onNext(4)

    subject.subscribe {
        print($0)
    }.addDisposableTo(disposeBag)

    subject.onNext(5)
}

example("Variable") {
    let disposeBag = DisposeBag()

    let subject = Variable<String>("")

    //subject.value = "1"

    subject.asObservable().subscribe {
        print($0)
    }.addDisposableTo(disposeBag)

    subject.value = "2"
}















