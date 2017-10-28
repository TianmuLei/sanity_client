//
//  SanityUICreateBudgets.m
//  Sanity
//
//  Created by Gu on 10/27/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface SanityUICreateBudgets : XCTestCase

@end

@implementation SanityUICreateBudgets

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testCreateBudget{
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app launch];
    //login
    XCUIElement *emailTextField = app.textFields[@"Email"];
    [emailTextField tap];
    [emailTextField typeText:@"tianmu@usc.edu"];
    XCUIElement *passwordSecureTextField = app.secureTextFields[@"Password"];
    [passwordSecureTextField tap];
    [passwordSecureTextField typeText:@"tianmu"];
    [app.buttons[@"Done"] tap];
    [app.buttons[@"Login In"] tap];
    
    //go to add budget page
    [app.tabBars.buttons[@"Add"] tap];
    [app.buttons[@"$$$$ Add Budget $$$$"] tap];
    //click add category twice to get textfields for 3 categories
    XCUIElementQuery *tablesQuery = app.tables;
    XCUIElement *addCategoryButton = tablesQuery.buttons[@"Add Category"];
    [addCategoryButton tap];
    [addCategoryButton tap];
    //fill out the three categories
    XCUIElement *textField = [[tablesQuery.cells containingType:XCUIElementTypeStaticText identifier:@"Budget Name"] childrenMatchingType:XCUIElementTypeTextField].element;
    [textField tap];
    [textField typeText:@"BudgetTest1050"];
    
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
    
    XCUIElement *textField4 = [[[tablesQuery childrenMatchingType:XCUIElementTypeCell] elementBoundByIndex:7] childrenMatchingType:XCUIElementTypeTextField].element;
    [textField4 tap];
    [textField4 typeText:@"Cat2"];
    XCUIElement *cell2 = [[tablesQuery childrenMatchingType:XCUIElementTypeCell] elementBoundByIndex:8];
    XCUIElement *textField5 = [cell2 childrenMatchingType:XCUIElementTypeTextField].element;
    [textField5 tap];
    [textField5 typeText:@"180"];
    
    XCUIElement *textField6 = [[[tablesQuery childrenMatchingType:XCUIElementTypeCell] elementBoundByIndex:9] childrenMatchingType:XCUIElementTypeTextField].element;
    [textField6 tap];
    [textField6 typeText:@"Cat3"];
    XCUIElement *textField7 = [[[tablesQuery childrenMatchingType:XCUIElementTypeCell] elementBoundByIndex:10] childrenMatchingType:XCUIElementTypeTextField].element;
    [textField7 tap];
    [textField7 typeText:@"560"];
    
    [tablesQuery.buttons[@"Submit"] tap];
    
    
    
    // create expectation to wait for response
    XCTestExpectation *expectation = [self expectationWithDescription:@"Add Budget Success"];
    //5 == num in seconds
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        XCTAssert(app.buttons[@"$$$$ Add Budget $$$$"].exists);
        [expectation fulfill];
    });
    
    
    // wait for expectation,fail automatically after predefined seconds
    NSTimeInterval interval = 6;
    [self waitForExpectationsWithTimeout:interval handler: nil];
}

@end
