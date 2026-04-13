// ─────────────────────────────────────────────────────────────
//  TaxLogicTests.swift
//  DevSphere — Tax Calculator Task
//
//  Compiled together with Calculator/TaxLogic.swift by run_tests.sh.
//  Do NOT modify this file — it is protected by .readonly-files.
// ─────────────────────────────────────────────────────────────

import Foundation

// ── Assertion helper ─────────────────────────────────────────

private var totalPass = 0
private var totalFail = 0

func assertEqual(
    _ name: String,
    expected: Double,
    got: Double,
    tolerance: Double = 0.001
) {
    if abs(expected - got) <= tolerance {
        print("[PASS] \(name)")
        totalPass += 1
    } else {
        print("[FAIL] \(name) — expected \(expected), got \(got)")
        totalFail += 1
    }
}

func assertTuple(
    _ name: String,
    income: Double,
    taxRate: Double,
    expectedTax: Double,
    expectedNet: Double
) {
    let result = calculateTax(income: income, taxRate: taxRate)
    let taxLabel = "\(name) → taxAmount"
    let netLabel = "\(name) → netIncome"
    assertEqual(taxLabel,  expected: expectedTax, got: result.taxAmount)
    assertEqual(netLabel,  expected: expectedNet, got: result.netIncome)
}

// ── Test cases ───────────────────────────────────────────────

// 1. Basic calculation
assertTuple(
    "Basic 20% tax on ₹1,00,000",
    income: 100_000, taxRate: 20,
    expectedTax: 20_000, expectedNet: 80_000
)

// 2. Zero income
assertTuple(
    "Zero income",
    income: 0, taxRate: 30,
    expectedTax: 0, expectedNet: 0
)

// 3. Zero tax rate
assertTuple(
    "Zero tax rate",
    income: 50_000, taxRate: 0,
    expectedTax: 0, expectedNet: 50_000
)

// 4. 100% tax rate
assertTuple(
    "100% tax rate",
    income: 75_000, taxRate: 100,
    expectedTax: 75_000, expectedNet: 0
)

// 5. Decimal income
assertTuple(
    "Decimal income ₹12,345.67 at 18%",
    income: 12_345.67, taxRate: 18,
    expectedTax: 2_222.22, expectedNet: 10_123.45
)

// 6. Fractional tax rate (GST-style 18.5%)
assertTuple(
    "Fractional rate 18.5% on ₹2,00,000",
    income: 200_000, taxRate: 18.5,
    expectedTax: 37_000, expectedNet: 163_000
)

// 7. Small income
assertTuple(
    "Small income ₹1 at 10%",
    income: 1, taxRate: 10,
    expectedTax: 0.1, expectedNet: 0.9
)

// 8. Large income
assertTuple(
    "Large income ₹10,00,000 at 30%",
    income: 1_000_000, taxRate: 30,
    expectedTax: 300_000, expectedNet: 700_000
)

// 9. Standard Indian slab — 5%
assertTuple(
    "Indian slab 5% on ₹3,50,000",
    income: 350_000, taxRate: 5,
    expectedTax: 17_500, expectedNet: 332_500
)

// 10. netIncome = income - taxAmount (not independently computed)
let r = calculateTax(income: 80_000, taxRate: 25)
let consistent = abs((r.taxAmount + r.netIncome) - 80_000) < 0.001
if consistent {
    print("[PASS] taxAmount + netIncome == income (internal consistency)")
    totalPass += 1
} else {
    print("[FAIL] taxAmount + netIncome != income — values are inconsistent")
    totalFail += 1
}

// ── Final summary for run_tests.sh ──────────────────────────
print("")
print("Total: \(totalPass) passed, \(totalFail) failed")
exit(totalFail > 0 ? 1 : 0)