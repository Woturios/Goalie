//
//  Sequence.swift
//  CashRefill
//
//  Created by Jan Antonowicz on 20/05/2022.
//

import Foundation

extension Sequence  {
    func sum<T: AdditiveArithmetic>(_ predicate: (Element) -> T) -> T { reduce(.zero) { $0 + predicate($1) } }
}
