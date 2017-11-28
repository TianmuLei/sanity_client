//
//  ResetPasswordPage.m
//  Sanity
//
//  Created by Ruyin Shao on 10/16/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "ResetPasswordPage.h"
#import "ChangePasswordController.h"
#import "UIClientConnector.h"

@interface ResetPasswordPage ()
@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTF;
@property (weak, nonatomic) IBOutlet UITextField *resetPasswordTF;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTF;
@property (weak, nonatomic) IBOutlet UITextField *emailTF;
@property (weak, nonatomic) IBOutlet UITextField *verificationCodeTF;

@property ChangePasswordController* controller;
@end

@implementation ResetPasswordPage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) resetPasswordSuccess {
      [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void) resetPasswordFailed {
    [self getAlerted:@"Reset Password Failed." msg:@"Old password incorrect."];
}

- (IBAction)submitPasswordChange:(id)sender {
    if (_resetPasswordTF.text.length < 1 || _oldPasswordTF.text.length < 1 ||
        _confirmPasswordTF.text.length < 1) {
        [self getAlerted:@"Required Fields" msg:@"Should input all text fields to change password"];
    }
    else if (![_resetPasswordTF.text isEqualToString:_confirmPasswordTF.text]){
        [self getAlerted:@"New password is inconsistent" msg:@"Make sure that the old password and new password are the same."];
    }
    else {
    //call controller and update information
        _controller = UIClientConnector.myClient.changePassword;
        UIClientConnector.myClient.changePassword.delegate = self;
        [_controller changePassword:_oldPasswordTF.text newPassword:_resetPasswordTF.text];

    }

}

#pragma mark callbacks
- (void) ForgetPasswordSuccess{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void) ForgetPasswordFailed:(NSString *)reason{
      [self getAlerted:@"Forget Password Failed." msg:reason];
}

- (IBAction)dismissKey:(id)sender {
    [sender resignFirstResponder];
}
- (IBAction)submitEmail:(id)sender {
    [self.controller forgetPassword:self.emailTF.text];
}
- (IBAction)submitForgetPass:(id)sender {
#warning call controler
    [self.controller forgetChangePassword:self.verificationCodeTF.text password:self.resetPasswordTF.text];
    [self ForgetPasswordSuccess];
}


- (void) getAlerted: (NSString*) errorTitle msg:(NSString*) errorMessage {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:errorTitle
                                          message:errorMessage
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action){
                                   if ([errorTitle isEqualToString: @"Forget Password Failed."]){
                                       [self.navigationController popToRootViewControllerAnimated:YES];
                                   }
                                   
                               }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
 */

@end
