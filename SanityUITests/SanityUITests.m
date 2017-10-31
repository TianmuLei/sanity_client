//
//  SanityUITests.m
//  SanityUITests
//
//  Created by Tianmu on 10/5/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface SanityUITests : XCTestCase

@end

@implementation SanityUITests

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

- (void)testExample {
    
   
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
        [tablesQuery.cells[@"yearly, 10/10100"] tap];
        
        
        //go to add category page
        [app.buttons[@"Edit"] tap];
        [app.tables.buttons[@"Add Category"] tap];
        
        XCUIElement *categoryNameTextField = app.textFields[@"cate name"];
        [categoryNameTextField tap];
        [categoryNameTextField typeText:@"addcate1"];
        
        XCUIElement *amountTF = app.textFields[@"amount"];
        [amountTF tap];
        [amountTF typeText:@"100"];
        [app.buttons[@"Done"] tap];
        
        [app.buttons[@"Submit"] tap];
        
        XCTAssert(app.textFields[@"yearly"].exists);
    
    
}




@end
