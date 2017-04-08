//: Playground - noun: a place where people can play

import RxSwift

example("prime") {
	let disposeBag = DisposeBag()
	let numbers = Observable.generate(initialState: 1, condition: { $0 < 1000 }, iterate: { $0 + 1 })


	numbers.filter{ number -> Bool in
		guard number > 1 else { return false }
		var isPrime = true
		for i in 2..<number {
			if number % i == 0 {
				isPrime = false
			}
		}
		return isPrime
		}.toArray().subscribe(onNext: { print($0) }, onError: nil, onCompleted: nil).addDisposableTo(disposeBag)

}


example("distinctUntilChange") {
	let disposeBag = DisposeBag()
	let lowerCaseString = Variable("")
	lowerCaseString.asObservable()
		.map{ $0.lowercased() }
		.distinctUntilChanged()
		.subscribe(onNext: { print($0) }, onError: nil, onCompleted: nil)
		.addDisposableTo(disposeBag)

	lowerCaseString.value = "HELLO"
	lowerCaseString.value = "Hello"
	lowerCaseString.value = "Happy"
	lowerCaseString.value = "happy"
}

example("startWith") {
	let disposeBag = DisposeBag()

	Observable.of("1", "2", "3")
		.startWith("A")
		.startWith("B")
		.startWith("C", "D")
		.subscribe(onNext: { print($0) }, onError: nil, onCompleted: nil)
		.addDisposableTo(disposeBag)
}

example("merge") {
	let disposeBag = DisposeBag()

	let subject1 = PublishSubject<String>()
	let subject2 = PublishSubject<String>()

	Observable.of(subject1, subject2)
		.merge()
		.subscribe(onNext: { print($0) }, onError: nil, onCompleted: nil)
		.addDisposableTo(disposeBag)

	subject1.onNext("A1")
	subject1.onNext("B1")
	subject2.onNext("A2")
	subject2.onNext("B2")
}

example("zip") {
	let disposeBag = DisposeBag()

	let subject1 = PublishSubject<String>()
	let subject2 = PublishSubject<Int>()

	Observable.zip(subject1, subject2){ stringElement, intElement in
		"\(stringElement)-\(intElement)"
		}
		.subscribe(onNext: { print($0) }, onError: nil, onCompleted: nil)
		.addDisposableTo(disposeBag)

	subject1.onNext("A")
	subject2.onNext(1)
}

example("array") {
	let disposeBag = DisposeBag()

	let array = Variable<[Int]>([])
	let arrayObservable = array.asObservable()

	arrayObservable.subscribe(onNext: { value in print(value) }).addDisposableTo(disposeBag)

	for i in 0..<20 {
		array.value.append(i)
	}

}






