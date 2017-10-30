//
//  SanityUIAddCategory.m
//  Sanity
//
//  Created by Ruyin Shao on 10/29/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface SanityUIAddCategory : XCTestCase

@end

@implementation SanityUIAddCategory

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}



- (void)testSanityUIAddCategory
{
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
      XCUIElement *but =  [[[[[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element;
    
    [but tap];
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
