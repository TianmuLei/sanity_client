//
//  SanityUISignupFailedWithNotEnoughArgs.m
//  Sanity
//
//  Created by Gu on 10/28/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface SanityUISignupFailedWithNotEnoughArgs : XCTestCase

@end

@implementation SanityUISignupFailedWithNotEnoughArgs

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSanityUISignupFailedWithNotEnoughArgs
{
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app launch];
    [app.buttons[@"Sign Up"] tap];
    XCUIElement *trojanUscEduTextField = app.textFields[@"trojan@usc.edu"];
    [trojanUscEduTextField tap];
    [trojanUscEduTextField typeText:@"tommy@usc.edu"];
    
    XCUIElement *tommyTrojanTextField = app.textFields[@"Tommy Trojan"];
    [tommyTrojanTextField tap];
    [tommyTrojanTextField typeText:@"Tommy Trojan"];
    
    [app.buttons[@"Done"] tap];
    [app.buttons[@"Sign Up"] tap];
    
    //check if label exists in page
    XCTAssert(app.staticTexts[@"Please fill in all required fields!"].exists);
}

@end
