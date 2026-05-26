import XCTest
@testable import AxcBedrockCore

final class AxcBedrockColorTests: XCTestCase {

    func testCreateHexStringWithSixDigitRGB() {
        let color = AxcBedrockColor.Axc.Create(hexStr: "#FFBBAA")

        XCTAssertEqual(color.axc.hexString, "#FFBBAA")
    }

    func testCreateHexStringWithEightDigitRGBA() {
        let color = AxcBedrockColor.Axc.Create(hexStr: "#FFBBAA80")

        XCTAssertEqual(color.axc.hexString, "#FFBBAA80")
    }

    func testCreateHexStringWithShortRGB() {
        let color = AxcBedrockColor.Axc.Create(hexStr: "#FBA")

        XCTAssertEqual(color.axc.hexString, "#FFBBAA")
    }

    func testCreateHexStringRejectsInvalidLength() {
        let color = AxcBedrockColor.Axc.CreateOptional(hexStr: "#FF")

        XCTAssertNil(color)
    }
}
