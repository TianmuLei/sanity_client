//
//  ProfilePageController.h
//  Sanity
//
//  Created by Tianmu on 10/15/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "MainController.h"

@protocol  ProfilePageControllerDelegate<NSObject>
//add call back function here
- (void) displayProfile:(NSString*)username :(NSString*)email;
@required
@end

@interface ProfilePageController : MainController{
    id <ProfilePageControllerDelegate> _delegate;
}
@property (nonatomic,strong) id delegate;
-(void) getUserInfo;
-(void) changeUsername:(NSString*)newUserName;

-(void) changePassword:(NSString*)oldPassword newPassword:(NSString*)newPassword;
-(int) hash1:(NSString*) password;
-(int) hash2:(NSString*) password;

@end
