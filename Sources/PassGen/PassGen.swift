//
//  PassGen.swift
//  PassGen
//
//  Created by Xiao Jin on 2024/1/9.
//  Copyright © 2024 debugeek. All rights reserved.
//

import Foundation

public class PassGen {
    public init(characters: [Character], indexes: [Int]) {
        assert(characters.count > 0)
        assert(indexes.count > 0)
        self.characters = characters
        self.indexes = indexes
    }

    public convenience init(characters: [Character], sequence: Int) {
        assert(sequence >= 0)
        var indexes = [Int]()
        var sequence = sequence
        repeat {
            indexes.insert(sequence%characters.count, at: 0)
            sequence /= characters.count
            sequence -= 1
        } while sequence >= 0
        self.init(characters: characters, indexes: indexes)
    }

    public convenience init(characters: [Character], length: Int) {
        assert(length > 0)
        self.init(characters: characters, indexes: [Int](repeating: 0, count: length))
    }

    private let characters: [Character]

    private(set) public var indexes: [Int]

    public func generate() -> String {
        return String(self.indexes.map { self.characters[$0] })
    }

    @discardableResult
    public func shuffle() -> Self {
        for n in (0..<self.indexes.count) {
            self.indexes[n] = Int.random(in: 0..<characters.count)
        }
        return self
    }

    @discardableResult
    public func advance() -> Self {
        self.indexes[self.indexes.count - 1] += 1
        for n in (0..<self.indexes.count).reversed() {
            if self.indexes[n] == self.characters.count {
                self.indexes[n] = 0

                if n == 0 {
                    self.indexes.insert(0, at: 0)
                } else {
                    self.indexes[n - 1] += 1
                }
            } else {
                break
            }
        }
        return self
    }

    public func sequence() -> Int {
        var sequence = 0
        for n in (0..<self.indexes.count) {
            sequence += self.indexes[n]
            if n < self.indexes.count - 1 {
                sequence += 1
                sequence *= self.characters.count
            }
        }
        return sequence
    }
}
