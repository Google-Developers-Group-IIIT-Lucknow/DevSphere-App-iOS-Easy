// ─────────────────────────────────────────────────────────────
//  main.swift
//  DevSphere — Tax Calculator Task
//
//  swiftc entry point. Top-level executable code must live here.
//  Do NOT modify this file — it is protected by .readonly-files.
// ─────────────────────────────────────────────────────────────
import Foundation
runAllTests()

print("")
print("Total: \(totalPass) passed, \(totalFail) failed")
exit(totalFail > 0 ? 1 : 0)