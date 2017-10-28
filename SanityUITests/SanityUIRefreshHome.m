//
//  SanityUIRefreshHome.m
//  Sanity
//
//  Created by Gu on 10/27/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface SanityUIRefreshHome : XCTestCase

@end

@implementation SanityUIRefreshHome

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

- (void)testRefreshHome
{
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *emailTextField = app.textFields[@"Email"];
    [emailTextField typeText:@"i"];
    [app.keys[@"a"] tap];
    [emailTextField typeText:@"a"];
    [app.keys[@"n"] tap];
    [emailTextField typeText:@"nmu@usc.edu"];
    
    XCUIElement *passwordSecureTextField = app.secureTextFields[@"Password"];
    [passwordSecureTextField tap];
    [passwordSecureTextField typeText:@"r"];
    
    XCUIElement *deleteKey = app.keys[@"delete"];
    [deleteKey tap];
    [deleteKey tap];
    [passwordSecureTextField typeText:@"tianmu"];
    [app.buttons[@"Done"] tap];
    [app typeText:@"\n"];
    [app.buttons[@"Login In"] tap];
    
    XCUIElementQuery *tabBarsQuery = app.tabBars;
    [tabBarsQuery.buttons[@"Add"] tap];
    [tabBarsQuery.buttons[@"Home"] tap];
    
}

@end
