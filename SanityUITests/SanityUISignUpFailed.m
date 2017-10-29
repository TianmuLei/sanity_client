//
//  SanityUISignUpFailed.m
//  Sanity
//
//  Created by Gu on 10/28/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface SanityUISignUpFailed : XCTestCase

@end

@implementation SanityUISignUpFailed

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

- (void)testSanityUISignUpFailed {
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app launch];
    [app.buttons[@"Sign Up"] tap];
    XCUIElement *trojanUscEduTextField = app.textFields[@"trojan@usc.edu"];
    [trojanUscEduTextField tap];
    [trojanUscEduTextField typeText:@"z@z.com"];
    
    XCUIElement *tommyTrojanTextField = app.textFields[@"Tommy Trojan"];
    [tommyTrojanTextField tap];
    [tommyTrojanTextField typeText:@"Tommy Trojan"];
    
    
    XCUIElement *tommytrojan111SecureTextField = app.secureTextFields[@"tommyTrojan111"];
    [tommytrojan111SecureTextField tap];
    [tommytrojan111SecureTextField typeText:@"tommytrojan"];
    [app.buttons[@"Done"] tap];
    [app.buttons[@"Sign Up"] tap];
    
    // create expectation to wait for response
    XCTestExpectation *expectation = [self expectationWithDescription:@"Add Budget Success"];
    //5 == num in seconds
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //check if "Add" button exists
        XCTAssert(app.staticTexts[@"The email address has already been registered"].exists);
        [expectation fulfill];
    });
    
    // wait for expectation,fail automatically after predefined seconds
    NSTimeInterval interval = 6;
    [self waitForExpectationsWithTimeout:interval handler: nil];
}

@end
