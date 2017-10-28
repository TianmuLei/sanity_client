//
//  SanityUICreateBudgetsFailedWithNotEnoughArgs.m
//  Sanity
//
//  Created by Gu on 10/28/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface SanityUICreateBudgetsFailedWithNotEnoughArgs : XCTestCase

@end

@implementation SanityUICreateBudgetsFailedWithNotEnoughArgs

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

- (void)testSanityUICreateBudgetsFailedWithNotEnoughArgs
{
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
    [textField typeText:@"budget1WithNotEnoughArgs"];
    
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
    
    [app.buttons[@"Done"] tap];
    
    [tablesQuery.buttons[@"Submit"] tap];
    
    
    
    //check if label exists in page
    XCTAssert(app.staticTexts[@"Please fill in all required fields"].exists);
}

@end
