//
//  ProfilePageController.m
//  Sanity
//
//  Created by Tianmu on 10/15/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "ProfilePageController.h"

@implementation ProfilePageController
-(void) getUserInfo{
    [self.delegate displayProfile:self.client.myUser.username :self.client.myUser.email];
}

-(void) changeUsername:(NSString*)newUserName{
    NSDictionary *info=@{@"email":self.client.myUser.email,@"newUsername":newUserName};
    NSDictionary *message=@{@"function":@"changeUsername",@"information":info};
    [self.client sendMessage:message];

    
}

-(void) changePassword:(NSString*)oldPassword newPassword:(NSString*)newPassword{
    NSString* old1=[NSString stringWithFormat:@"%d", [self hash1:oldPassword]];
    NSString* old2=[NSString stringWithFormat:@"%d", [self hash2:oldPassword]];
    NSString* new1=[NSString stringWithFormat:@"%d", [self hash1:newPassword]];
NSString* new2=[NSString stringWithFormat:@"%d", [self hash2:newPassword]];
    NSDictionary *info=@{@"email":self.client.myUser.email,@"oldPassword1":old1,@"oldPassword2":old2,@"newPassword1":new1,@"newPassword1":new2};
    NSDictionary *message=@{@"function":@"changePassword",@"information":info};
    [self.client sendMessage:message];

    
}



-(int) hash1:(NSString*) password{
    int hash = 7;
    for (int i = 0; i < password.length; i++) {
        hash = hash*31 + [password characterAtIndex:i];
    }
    return hash;
}

-(int) hash2:(NSString*) password{
    int hash = 10;
    for (int i = 0; i < password.length; i++) {
        hash = hash*41 + [password characterAtIndex:i];
        
    }
    return hash;
}
@end
