//
//  Array.swift
//  RadioApp
//
//  Created by Dmitriy Eliseev on 02.08.2024.
//

import Foundation
import SwiftUI

extension Array {
    func find(includedElement: T -> Bool) -> Int? {
        for (idx, element) in enumerate(self) {
            if includedElement(element) {
                return idx
            }
        }
        return nil
    }
}
