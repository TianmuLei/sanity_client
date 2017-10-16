//
//  SignupController.h
//  Sanity
//
//  Created by Tianmu on 10/7/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "MainController.h"




@protocol  SignupControllerDelegate<NSObject>
//add call back function here

- (void) signupSucceeded:(NSArray *) budget withAmount:(NSArray *) amount withColor:(NSArray *) color;
- (void) signupFailed:(NSString*) errorMessage;
@required
@end


@interface SignupController :MainController{
     id <SignupControllerDelegate> _delegate;
    
}
@property (nonatomic,strong) id delegate;
@property (strong, atomic)  client *client;
-(void) signup: (NSString*) email username:(NSString*) username password:(NSString*) password;
-(int) hash1:(NSString*) password;
-(int) hash2:(NSString*) password;
-(void) success;
-(void) fail;
@end
