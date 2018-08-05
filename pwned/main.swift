//
//  main.swift
//  pwned
//
//  Created by Rafael Leandro on 02/08/18.
//  Copyright © 2018 Rafael Leandro. All rights reserved.
//

import Foundation

print("';--have i been pwned?\n".AnsiString(color: .green, style: .none))
print("Email address: ")
guard let email = readLine(strippingNewline: true) else { fatalError("insert a valid email.") }

let verifier = PwnedVerifier(email: email)
verifier.verify() { result in
    switch result {
    case .pwned(let value):
        print("⚠️ Oh no — pwned! ⚠️ \n")
        print("Pwned on \(value.count) breached sites")
        for item in value {
            print("[\(item.beachDate)] - \(item.name): \(item.domain)".AnsiString(color: .red, style: .bold))
            print("\(item.detail)".withoutHtmlTags.AnsiString(color: .white, style: .none))
        }
        exit(0)
    case .safe:
        print("Good news — no pwnage found!".AnsiString(color: .green, style: .bold))
        exit(0)
    case .error(let error):
        print("Error: \(error)")
        exit(1)
    }
}

RunLoop.main.run()
