//
//  SignupController.m
//  Sanity
//
//  Created by Tianmu on 10/7/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "SignupController.h"

@implementation SignupController


- (id) initWithClass:(client *)myClient{
    self = [super initWithClass: myClient];
    if (self) {
       // self.client=myClient;
    }
    
    [self signup:@"tianmule@usc.edu" username:@"tianmule" password:@"baobao"];

    return self;
    
   }


-(void) signup: (NSString*) email username:(NSString*) username password:(NSString*) password{
    int p1=[self hash1:password];
    int p2=[self hash2:password];
    NSString *password1 = [NSString stringWithFormat:@"%d", p1];
    NSString *password2 = [NSString stringWithFormat:@"%d", p2];

    
    
    
    NSDictionary *info=@{@"username":username,@"Email":email,@"password1":password1,@"password2":password2};
    
    NSDictionary *message=@{@"function":@"Register",@"information":info};
    
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
