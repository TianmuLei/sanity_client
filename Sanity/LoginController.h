//
//  LoginController.h
//  Sanity
//
//  Created by Tianmu on 10/14/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainController.h"

@protocol  LoginControllerDelegate<NSObject>
//add call back function here
- (void) loginFailed:(NSString*) errorMessage;
- (void) loginSucceeded:(NSArray *) budget withAmount:(NSArray *) amount withColor:(NSArray *) color;
@required
@end


@interface LoginController : MainController{
    id <LoginControllerDelegate> _delegate;
    
}
@property (nonatomic,strong) id delegate;
-(void) login: (NSString*) email password:(NSString*) password;
-(void) fail;
-(void) success: (NSArray*) budgetList;
-(int) hash1:(NSString*) password;
-(int) hash2:(NSString*) password;
@end
