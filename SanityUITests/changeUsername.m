//
//  changeUsername.m
//  Sanity
//
//  Created by Ruyin Shao on 10/30/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface changeUsername : XCTestCase

@end

@implementation changeUsername

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

- (void)testChangeUsername {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app launch];
    //login
    XCUIElement *emailTextField = app.textFields[@"Email"];
    [emailTextField tap];
    [emailTextField typeText:@"changePass@cc.com"];
    XCUIElement *passwordSecureTextField = app.secureTextFields[@"Password"];
    [passwordSecureTextField tap];
    [passwordSecureTextField typeText:@"change"];
    [app.buttons[@"Done"] tap];
    [app.buttons[@"Login In"] tap];
    
    //tap profile
    
    [app.tabBars.buttons[@"Profile"] tap];
    [app.buttons[@"Reset Username"] tap];
    
    XCUIElement *newUsername = app.textFields[@"new name"];
    [newUsername tap];
    [newUsername typeText:@"EdithLOL"];

    [app.buttons[@"Submit"] tap];
    
     XCTAssert(app.staticTexts[@"EdithLOL"].exists);
}

@end
