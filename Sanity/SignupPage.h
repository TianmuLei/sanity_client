//
//  SignupPage.h
//  Sanity
//
//  Created by Gu on 10/14/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignupPage : UIViewController
@property (strong,nonatomic) NSString * password;
@property (strong,nonatomic) NSString * email;
@property (strong,nonatomic) NSString * username;

- (void) signupSucceeded:(NSArray *)table withColor:(NSArray *)color;
- (void) signupFailed:(NSString*) errorMessage;

@end
