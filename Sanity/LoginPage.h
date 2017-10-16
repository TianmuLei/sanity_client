//
//  LoginPage.h
//  Sanity
//
//  Created by Gu on 10/14/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginPage : UIViewController
@property (strong,nonatomic) NSString * password;
@property (strong,nonatomic) NSString * email;

- (void) loginSucceeded:(NSArray *) budget withAmount:(NSArray *) amount withColor:(NSArray *) color;
- (void) loginFailed:(NSString*) errorMessage;
    
@end
