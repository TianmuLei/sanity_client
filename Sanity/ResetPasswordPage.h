//
//  ResetPasswordPage.h
//  Sanity
//
//  Created by Ruyin Shao on 10/16/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "ViewController.h"
#import "ChangePasswordController.h"
#import "UIClientConnector.h"

@interface ResetPasswordPage : ViewController<ChangePasswordControllerDelegate>

- (void)resetPasswordSuccess;

- (void)resetPasswordFailed;


@end
