//
//  SanityUILogin.m
//  Sanity
//
//  Created by Gu on 10/28/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface SanityUILogin : XCTestCase

@end

@implementation SanityUILogin

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

- (void)testSanityUILogin {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app launch];
    //login
    XCUIElement *emailTextField = app.textFields[@"Email"];
    [emailTextField tap];
    [emailTextField typeText:@"z@z.com"];
    XCUIElement *passwordSecureTextField = app.secureTextFields[@"Password"];
    [passwordSecureTextField tap];
    [passwordSecureTextField typeText:@"zg"];
    [app.buttons[@"Done"] tap];
    [app.buttons[@"Login In"] tap];
    
    // create expectation to wait for response
    XCTestExpectation *expectation = [self expectationWithDescription:@"Add Budget Success"];
    //5 == num in seconds
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //check if "Add" button exists
        XCTAssert(app.buttons[@"Add"].exists);
        [expectation fulfill];
    });
    
    // wait for expectation,fail automatically after predefined seconds
    NSTimeInterval interval = 6;
    [self waitForExpectationsWithTimeout:interval handler: nil];
}

@end
