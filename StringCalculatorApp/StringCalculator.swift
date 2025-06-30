import Foundation

enum StringCalculatorError: Error, LocalizedError {
    case negativeNumbersNotAllowed([Int])

    var errorDescription: String? {
        switch self {
        case .negativeNumbersNotAllowed(let negatives):
            return "negative numbers not allowed: " + negatives.map(String.init).joined(separator: ",")
        }
    }
}

struct StringCalculator {
    func add(_ input: String) throws -> Int {
        guard !input.isEmpty else { return 0 }

        var delimiter = ","
        var numbersString = input

        if input.hasPrefix("//") {
            let parts = input.components(separatedBy: "\n")
            delimiter = String(parts[0].dropFirst(2))
            numbersString = parts[1]
        }

        let separators = CharacterSet(charactersIn: delimiter + "\n")
        let numberStrings = numbersString.components(separatedBy: separators)

        let numbers = numberStrings.compactMap { Int($0) }
        let negatives = numbers.filter { $0 < 0 }

        if !negatives.isEmpty {
            throw StringCalculatorError.negativeNumbersNotAllowed(negatives)
        }

        return numbers.reduce(0, +)
    }
}
