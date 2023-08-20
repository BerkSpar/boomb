//
//  ArrayExtensions.swift
//  boomb
//
//  Created by Felipe Passos on 04/08/23.
//

import Foundation

extension Array {
    func find(at index: Int) -> Element? {
        guard index >= 0 && index < count else {
            return nil
        }

        return self[index]
    }
}
