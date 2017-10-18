//
//  ChangeUsernameController.m
//  Sanity
//
//  Created by Tianmu on 10/17/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "ChangeUsernameController.h"

@implementation ChangeUsernameController
-(void) changeUsername:(NSString*)newUserName{
    NSDictionary *info=@{@"email":self.client.myUser.email,@"username":newUserName,@"password1":@"",@"password2":@""};
    NSDictionary *message=@{@"function":@"changeUsername",@"information":info};
    
    self.client.myUser.username=newUserName;

    [self.client sendMessage:message];
    
    
}
-(void) success{
    [self.delegate resetSuccess];
    
}
-(void) fail{
    [self.delegate resetSuccess];
}
@end
