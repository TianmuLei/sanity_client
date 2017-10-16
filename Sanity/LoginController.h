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
@required
@end


@interface LoginController : MainController{
    id <LoginControllerDelegate> _delegate;
    
}
@property (nonatomic,strong) id delegate;
-(void) login: (NSString*) email password:(NSString*) password;
-(int) hash1:(NSString*) password;
-(int) hash2:(NSString*) password;
@end
