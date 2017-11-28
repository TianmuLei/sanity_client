//
//  ChangePasswordController.h
//  Sanity
//
//  Created by Tianmu on 10/17/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "MainController.h"
//#import "client.h"

@protocol  ChangePasswordControllerDelegate<NSObject>
//add call back function here
- (void)resetPasswordSuccess;

- (void)resetPasswordFailed;
- (void)ForgetPasswordSuccess;
//give me a reason for success or not
- (void)ForgetPasswordFailed:(NSString*) reason;
//- (void) displayProfile:(NSString*)username :(NSString*)email;
@required
@end

@interface ChangePasswordController : MainController{
    id <ChangePasswordControllerDelegate> _delegate;
}
@property (nonatomic,strong) id delegate;
-(void) changePassword:(NSString*)oldPassword newPassword:(NSString*)newPassword;
-(int) hash1:(NSString*) password;
-(int) hash2:(NSString*) password;
- (id) initWithClass:(client *)myClient;
-(void) success;
-(void) fail;
-(void) forgetPassword:(NSString*)email;
-(void) forgetChangePassword:(NSString*)email password:(NSString*)password code:(NSString*)code;
-(void) successForget;
-(void) failForget;
//@property (strong, atomic)  client *client;

@end
