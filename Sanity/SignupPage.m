//
//  SignupPage.m
//  Sanity
//
//  Created by Gu on 10/14/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "SignupPage.h"
#import "HomePageTableViewController.h"


@interface SignupPage ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;
@property (weak, nonatomic) IBOutlet UILabel *warningLabel;
@property (strong,nonatomic) NSArray * tableContent;
@property (strong,nonatomic) NSArray * colors;

@end

@implementation SignupPage

- (void)viewDidLoad {
    [super viewDidLoad];
    //hide warning label
     [self.warningLabel setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)signupClicked:(id)sender {
    self.username = self.usernameTextField.text;
    self.email = self.emailTextField.text;
    self.password = self.passwordTextField.text;
    //null check
    if(self.password.length==0 || self.email.length==0 || self.password.length==0)
    {
        self.warningLabel.text = @"Please fill in all required fields!";
        [self.warningLabel setHidden:NO];
        return;
    }
    [self trySignup];
}
- (IBAction)backgroundClicked:(id)sender {
    //get rid of white space
    self.emailTextField.text = [self.emailTextField.text stringByTrimmingCharactersInSet:
                                [NSCharacterSet whitespaceCharacterSet]];
    self.usernameTextField.text = [self.usernameTextField.text stringByTrimmingCharactersInSet:
                                   [NSCharacterSet whitespaceCharacterSet]];
    [self.emailTextField resignFirstResponder];
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}
- (IBAction)emailExitKeyboard:(id)sender {
    //get rid of white space
    self.emailTextField.text = [self.emailTextField.text stringByTrimmingCharactersInSet:
                                [NSCharacterSet whitespaceCharacterSet]];
    [self.emailTextField resignFirstResponder];
}
- (IBAction)usernameExitKeyboard:(id)sender {
    //get rid of white space
    self.usernameTextField.text = [self.usernameTextField.text stringByTrimmingCharactersInSet:
                                   [NSCharacterSet whitespaceCharacterSet]];
    [self.usernameTextField resignFirstResponder];
}
- (IBAction)passwordExitKeyboard:(id)sender {
    [self.passwordTextField resignFirstResponder];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"SignupToHomeSegue"]){
        UITabBarController * tabController = (UITabBarController *)segue.destinationViewController;
        UINavigationController *navController = (UINavigationController *)tabController.viewControllers[0];
        HomePageTableViewController *controller = (HomePageTableViewController *)navController.topViewController;
        controller.tableContent = self.tableContent;
        controller.colors = self.colors;
    }
}

- (void) trySignup{
    #warning to be deleted!
    self.tableContent = @[@"iPhone1", @"iPhone2",@"iPhone3",@"iPhone4",@"iPhone5",@"iTV",@"iNew"];
    self.colors = @[@"black",@"black",@"black",@"orange",@"red",@"orange",@"black"];
    [self signupSucceeded:self.tableContent withColor:self.colors];
}

- (void) signupSucceeded:(NSArray *) table withColor:(NSArray *) color{
    self.colors = color;
    self.tableContent = table;
    [self performSegueWithIdentifier:@"SignupToHomeSegue" sender:self];
}

- (void) signupFailed:(NSString*) errorMessage{
    self.warningLabel.text = errorMessage;
    [self.warningLabel setHidden:NO];
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
