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
@required
@end


@interface SignupController : MainController{
     id <SignupControllerDelegate> _delegate;
    
}
@property (nonatomic,strong) id delegate;
-(void) signup: (NSString*) email username:(NSString*) username password:(NSString*) password;
-(int) hash1:(NSString*) password;
-(int) hash2:(NSString*) password;
@end
