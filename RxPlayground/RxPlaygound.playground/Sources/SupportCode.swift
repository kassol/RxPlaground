import Foundation

public func example(_ name: String, action: (Void) -> Void) {
	printExampleHeader(name)
	action()
}

public func printExampleHeader(_ name: String) {
	print("\n--- \(name) example ---")
}

