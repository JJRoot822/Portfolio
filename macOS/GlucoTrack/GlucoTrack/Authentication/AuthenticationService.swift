//
//  AuthenticationService.swift
//  GlucoTrack
//
//  Created by Joshua Root on 8/7/24.
//

import LocalAuthentication

class AuthenticationService {
    let context = LAContext()
    
    enum AuthenticationError {
        case cantEvaluatePolicy, failedToAuthenticate
    }
    
    func authenticate(using policy: LAPolicy, for reason: String) async -> Bool {
        var error: NSError?
        
        guard context.canEvaluatePolicy(policy, error: &error) else {
            print(error?.localizedDescription ?? "Something went wrong, but error is nil.")
            return false
        }
        
        do {
            try await context.evaluatePolicy(policy, localizedReason: reason)
            return true
        } catch {
            print("\(error.localizedDescription)")
            return false
        }
    }
}
