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
    else if (_resetPasswordTF.text != _confirmPasswordTF.text){
        [self getAlerted:@"New password is inconsistent" msg:@"Make sure that the old password and new password are the same."];
    }
    else {
    //call controller and update information
        _controller = UIClientConnector.myClient.changePassword;
        UIClientConnector.myClient.changePassword.delegate = self;
        [_controller changePassword:_oldPasswordTF.text newPassword:_resetPasswordTF.text];

    }

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) getAlerted: (NSString*) errorTitle msg:(NSString*) errorMessage {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:errorTitle
                                          message:errorMessage
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action){
                                   //set all label to red
                               }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

@end
