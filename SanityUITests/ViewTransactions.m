//
//  ViewTransactions.m
//  Sanity
//
//  Created by Ruyin Shao on 10/30/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface ViewTransactions : XCTestCase

@end

@implementation ViewTransactions

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

- (void)testViewTransactions {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app launch];
    //login
    XCUIElement *emailTextField = app.textFields[@"Email"];
    [emailTextField tap];
    [emailTextField typeText:@"ruyin@usc.edu"];
    XCUIElement *passwordSecureTextField = app.secureTextFields[@"Password"];
    [passwordSecureTextField tap];
    [passwordSecureTextField typeText:@"ruyin"];
    [app.buttons[@"Done"] tap];
    [app.buttons[@"Login In"] tap];
    
    XCUIElementQuery *tablesQuery = app.tables;
    [tablesQuery.cells[@"viewTrans, 131/600"] tap];
    //tap slice0 in pie chart three times
    
    
    XCUIElement *element = [[[[[[[[[[[[[XCUIApplication alloc] init] childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element;
    [element tap];
    [element tap];
    [element tap];
    
    
    [app.buttons[@"Show Details"] tap];
    
    //check if label exists in new page
    XCTAssert(app.staticTexts[@"drink"].exists);
     XCTAssert(app.staticTexts[@"eat"].exists);
}

@end
