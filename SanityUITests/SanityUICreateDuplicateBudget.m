//
//  SanityUICreateDuplicateBudget.m
//  Sanity
//
//  Created by Gu on 10/28/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface SanityUICreateDuplicateBudget : XCTestCase

@end

@implementation SanityUICreateDuplicateBudget

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

- (void)testCreateDuplicateBudget{
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
    
    //go to add budget page
    [app.tabBars.buttons[@"Add"] tap];
    [app.buttons[@"$$$$ Add Budget $$$$"] tap];
    //click add category twice to get textfields for 3 categories
    XCUIElementQuery *tablesQuery = app.tables;
    //fill out the three categories
    XCUIElement *textField = [[tablesQuery.cells containingType:XCUIElementTypeStaticText identifier:@"Budget Name"] childrenMatchingType:XCUIElementTypeTextField].element;
    [textField tap];
    [textField typeText:@"budget1"];
    
    XCUIElementQuery *periodCellsQuery = [tablesQuery.cells containingType:XCUIElementTypeStaticText identifier:@"Period"];
    [periodCellsQuery.textFields[@"Number of days"] tap];
    [[periodCellsQuery childrenMatchingType:XCUIElementTypeTextField].element typeText:@"10"];
    [tablesQuery.textFields[@"%"] tap];
    [[[tablesQuery.cells containingType:XCUIElementTypeStaticText identifier:@"Notification Threshold"] childrenMatchingType:XCUIElementTypeTextField].element typeText:@"78"];
    [tablesQuery.textFields[@"Number of days"] tap];
    [[[tablesQuery.cells containingType:XCUIElementTypeStaticText identifier:@"Notification Frequncy"] childrenMatchingType:XCUIElementTypeTextField].element typeText:@"12"];
    
    XCUIElement *cell = [[tablesQuery childrenMatchingType:XCUIElementTypeCell] elementBoundByIndex:5];
    [cell.staticTexts[@"Category Name: "] swipeUp];
    
    XCUIElement *textField2 = [cell childrenMatchingType:XCUIElementTypeTextField].element;
    [textField2 tap];
    [textField2 typeText:@"Cat1"];
    XCUIElement *textField3 = [[[tablesQuery childrenMatchingType:XCUIElementTypeCell] elementBoundByIndex:6] childrenMatchingType:XCUIElementTypeTextField].element;
    [textField3 tap];
    [textField3 typeText:@"100"];
    
    [app.buttons[@"Done"] tap];
    
    [tablesQuery.buttons[@"Submit"] tap];
    
    
    
    // create expectation to wait for response
    XCTestExpectation *expectation = [self expectationWithDescription:@"Add Budget Success"];
    //5 == num in seconds
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //check if alert appears
        XCTAssert(app.staticTexts[@"Duplicate Name"].exists);
        [expectation fulfill];
    });
    
    
    // wait for expectation,fail automatically after predefined seconds
    NSTimeInterval interval = 6;
    [self waitForExpectationsWithTimeout:interval handler: nil];
}

@end
