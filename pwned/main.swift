//
//  main.swift
//  pwned
//
//  Created by Rafael Leandro on 02/08/18.
//  Copyright © 2018 Rafael Leandro. All rights reserved.
//

import Foundation

print(TerminalUtils().AnsiString(value: "';--have i been pwned?\n", color: .green))
print("Email address: ")
guard let email = readLine(strippingNewline: true) else { fatalError("insert a valid email.") }

let verifier = PwnedVerifier(email: email)
verifier.verify() { data in
    print(data)
}

RunLoop.main.run()

