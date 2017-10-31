//
//  ViewCatesCorrToBudget.m
//  Sanity
//
//  Created by Ruyin Shao on 10/30/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface ViewCatesCorrToBudget : XCTestCase

@end

@implementation ViewCatesCorrToBudget

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

- (void)testCates {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app launch];
    //login
    XCUIElement *emailTextField = app.textFields[@"Email"];
    [emailTextField tap];
    [emailTextField typeText:@"tommy@u.edu"];
    XCUIElement *passwordSecureTextField = app.secureTextFields[@"Password"];
    [passwordSecureTextField tap];
    [passwordSecureTextField typeText:@"tommy"];
    [app.buttons[@"Done"] tap];
    [app.buttons[@"Login In"] tap];
    
    
    [app.tabBars.buttons[@"Add"] tap];
    [app.buttons[@"$$$$ Add Transaction $$$$"] tap];
    
    
    XCUIElement *budgetPicker = app.textFields[@"Budget"];
    [budgetPicker tap];
    [app.pickerWheels[@"viewCateTest"] swipeUp];
    
    
    XCUIElement *catePicker = app.textFields[@"Category"];
    [catePicker tap];
    XCTAssert(app.pickerWheels[@"viewCate1"].exists);
    [app.pickers.pickerWheels[@"viewCate1"] adjustToPickerWheelValue:@"viewCate2"];
    catePicker = app.textFields[@"viewCate2"];
    [catePicker tap];
    [app.pickers.pickerWheels[@"viewCate2"] adjustToPickerWheelValue:@"viewCate3"];
    
}

@end
