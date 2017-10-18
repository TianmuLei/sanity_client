//
//  ChangePasswordController.m
//  Sanity
//
//  Created by Tianmu on 10/17/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "ChangePasswordController.h"

@implementation ChangePasswordController

- (id) initWithClass:(client *)myClient{
    self = [super initWithClass: myClient];
    if (self) {
        // self.client=myClient;
    }
    
    // [self signup:@"tianmule@usc.edu" username:@"tianmule" password:@"baobao"];
    
    return self;
    
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

-(void) changePassword:(NSString*)oldPassword newPassword:(NSString*)newPassword{
    NSString* old1=[NSString stringWithFormat:@"%d", [self hash1:oldPassword]];
    NSString* old2=[NSString stringWithFormat:@"%d", [self hash2:oldPassword]];
    NSString* new1=[NSString stringWithFormat:@"%d", [self hash1:newPassword]];
    NSString* new2=[NSString stringWithFormat:@"%d", [self hash2:newPassword]];
    
    NSDictionary *info1=@{@"email":self.client.myUser.email,@"username":@"",@"password1":old1,@"password2":old2};
    NSDictionary* info2=@{@"email":self.client.myUser.email,@"username":@"",@"password1":new1,@"password2":new2};
    NSDictionary *message=@{@"function":@"changePassword",@"information1":info1,@"information2":info2};
    [self.client sendMessage:message];
    
    
}

-(void) success{
    
}
-(void) fail{
    
}


@end
