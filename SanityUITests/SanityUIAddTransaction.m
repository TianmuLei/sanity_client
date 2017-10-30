//
//  SanityUIAddTransaction.m
//  Sanity
//
//  Created by Ruyin Shao on 10/29/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface SanityUIAddTransaction : XCTestCase

@end

@implementation SanityUIAddTransaction

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

- (void)testAddTransaction{
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
    
    
    [app.tabBars.buttons[@"Add"] tap];
    [app.buttons[@"$$$$ Add Transaction $$$$"] tap];
    
    XCUIElement *budgetPicker = app.textFields[@"Budget"];
    [budgetPicker tap];
    [app.pickerWheels[@"yearly"] swipeUp];

    XCUIElement *catePicker = app.textFields[@"Category"];
    [catePicker tap];
    [app.pickerWheels[@"cate2"] swipeUp];
    
    XCUIElement *AmountTF = app.textFields[@"$"];
    [AmountTF tap];
    [AmountTF typeText:@"10"];
    [app.buttons[@"Done"] tap];
    
    XCUIElement *DescripTF = app.textFields[@"Descrip"];
    [DescripTF tap];
    [DescripTF typeText:@"transaction333"];
    [app.buttons[@"Submit"] tap];
    
    XCTAssert(app.buttons[@"$$$$ Add Transaction $$$$"].exists);
    
}

@end

