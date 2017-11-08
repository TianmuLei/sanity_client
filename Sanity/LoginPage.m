//
//  LoginPage.m
//  Sanity
//
//  Created by Gu on 10/14/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "LoginPage.h"
#import "HomePageTableViewController.h"
#import "UIClientConnector.h"
#import <LocalAuthentication/LocalAuthentication.h>


@interface LoginPage ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;
@property (weak, nonatomic) IBOutlet UILabel *warningLabel;
@property (strong, nonatomic) NSString* filepath;
@property (strong, nonatomic) NSString* autofillUsername;
@property (weak, nonatomic) IBOutlet UIButton *touchIDButton;

@end

@implementation LoginPage

- (void)viewDidLoad {
    [super viewDidLoad];
    //hide the warning Label
    [self.warningLabel setHidden:YES];
    
    self.loginController = UIClientConnector.myClient.login;
    UIClientConnector.myClient.login.delegate = self;
    //set up property list path
    // find the Documents directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths[0];
    //NSLog(@"documentsDirectory = %@", documentsDirectory);
    self.filepath = [documentsDirectory stringByAppendingPathComponent:@"INFO.plist"];
    NSLog(@"filepath = %@", self.filepath);
    NSDictionary *fileContent = [NSDictionary dictionaryWithContentsOfFile:self.filepath];
    //fill in username(email) automatically
    if(fileContent)
    {
        self.autofillUsername = fileContent[@"Username"];
        self.emailTextField.text = self.autofillUsername;
        self.touchIDButton.hidden = false;
        self.touchIDButton.enabled = true;
        [self touchIDHelper];
    }
}

- (void) touchIDHelper{
    // touch id
    LAContext *myContext = [[LAContext alloc] init];
    NSError *authError = nil;
    NSString *myLocalizedReasonString = @"Please login with your touch id";
    
    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                  localizedReason:myLocalizedReasonString
                            reply:^(BOOL success, NSError *error) {
                                if (success) {
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        [_loginController autoLogin:self.autofillUsername];
                                        
                                    });
                                } else {
                                    //                                        dispatch_async(dispatch_get_main_queue(), ^{
                                    //                                            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                    //                                                                                                message:error.description
                                    //                                                                                               delegate:self
                                    //                                                                                      cancelButtonTitle:@"OK"
                                    //                                                                                      otherButtonTitles:nil, nil];
                                    //                                            [alertView show];
                                    //                                            // Rather than show a UIAlert here, use the error to determine if you should push to a keypad for PIN entry.
                                    //                                        });
                                }
                            }];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:authError.description
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
            [alertView show];
            // Rather than show a UIAlert here, use the error to determine if you should push to a keypad for PIN entry.
        });
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginClicked:(id)sender {
    self.password = self.passwordTextField.text;
    self.email = self.emailTextField.text;
    //null check
    if(self.password.length==0 || self.email.length==0)
    {
        self.warningLabel.text = @"Please fill in all required fields!";
        [self.warningLabel setHidden:NO];
        return;
    }
    [self tryLogin];
    
}
- (IBAction)exitKeyboardForEmail:(id)sender {
    //get rid of white space
    self.emailTextField.text = [self.emailTextField.text stringByTrimmingCharactersInSet:
                                [NSCharacterSet whitespaceCharacterSet]];
    [self.emailTextField resignFirstResponder];
}

- (IBAction)exitKeyboardForPassword:(id)sender {
    [self.passwordTextField resignFirstResponder];
}

- (IBAction)backgroundClicked:(id)sender {
    //get rid of white space
    self.emailTextField.text = [self.emailTextField.text stringByTrimmingCharactersInSet:
                                [NSCharacterSet whitespaceCharacterSet]];
    [self.passwordTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
}

- (IBAction)touchIDLogin:(id)sender {
    [self touchIDHelper];
}

- (void) tryLogin{
    
    [self.loginController login:self.email password:self.password];
    
    
    /*
     #warning to be deleted!
     self.budgetArray = @[@"iPhone1", @"iPhone2",@"iPhone3",@"iPhone4",@"iPhone5",@"iTV",@"iNew"];
     self.amountArray = @[@"10/20",@"100/200",@"1000/2000",@"100000/2000000",@"10/90",@"10/100",@"35/253"];
     self.colors = @[@"black",@"black",@"black",@"orange",@"red",@"orange",@"black"];
     [self loginSucceeded:self.budgetArray withAmount:self.amountArray withColor:self.colors];
     */
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"LoginToHomeSegue"]){
        UITabBarController * tabController = (UITabBarController *)segue.destinationViewController;
        UINavigationController *navController = (UINavigationController *)tabController.viewControllers[0];
        HomePageTableViewController *controller = (HomePageTableViewController *)navController.topViewController;
        
        controller.amountArray = self.amountArray;
        controller.budgetArray = self.budgetArray;
        controller.colors = self.colors;
    }
}


- (void) loginSucceeded:(NSArray *) budget withAmount:(NSArray *) amount withColor:(NSArray *) color
{
    self.colors = color;
    self.budgetArray = budget;
    self.amountArray = amount;
    [self saveUsernameToPList];
    [self performSegueWithIdentifier:@"LoginToHomeSegue" sender:self];
}

- (void) loginFailed:(NSString*) errorMessage{
    self.warningLabel.text = errorMessage;
    [self.warningLabel setHidden:NO];
}


- (void) saveUsernameToPList {
    NSDictionary * fileToStore = [NSDictionary dictionaryWithObjectsAndKeys:
                                  self.emailTextField.text, @"Username",
                                  nil];
    [fileToStore writeToFile: self.filepath atomically:YES];
}

@end
