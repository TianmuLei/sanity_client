//
//  ProfilePage.m
//  SanityTab
//
//  Created by Ruyin Shao on 10/13/17.
//  Copyright © 2017 Ruyin Shao. All rights reserved.
//

#import "ProfilePage.h"
#import "ProfilePageController.h"
#import "UIClientConnector.h"
#import "AppDelegate.h"
#import "Currency.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "LoginPage.h"

@interface ProfilePage ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UITextField *currencyTF;
@property UIPickerView *currencyPicker;
@property (strong, nonatomic) ProfilePageController *controller;
@property (strong, nonatomic) Currency* dataModel;
@property BOOL currencySelected;
@end



@implementation ProfilePage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _controller = UIClientConnector.myClient.profilePage;
    UIClientConnector.myClient.profilePage.delegate = self;
    [_controller getUserInfo];
    //initialize data model and picker
    self.dataModel = [Currency sharedModel];

    //picker
    self.currencyPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(5, 40, 200, 220)];
    self.currencyPicker.delegate = self;
    self.currencyPicker.dataSource = self;
    self.currencyPicker.showsSelectionIndicator = YES;
    self.currencyTF.inputView = self.currencyPicker;
    
    // add a toolbar with Done button
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar.barStyle = UIBarStyleBlackOpaque;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouched:)];
    
    [toolBar setItems:[NSArray arrayWithObjects:doneButton, nil]];
    self.currencyTF.inputAccessoryView = toolBar;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _controller = UIClientConnector.myClient.profilePage;
    UIClientConnector.myClient.profilePage.delegate = self;
    [_controller getUserInfo];
    
   // [self.view]; // to reload selected cell
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) displayProfile:(NSString*)username :(NSString*)email{
    self.nameLabel.text = username;
    self.emailLabel.text = email;
}

- (void)doneTouched:(id)sender{
    if (![self.currencyTF.text isEqualToString:[_dataModel currCurrency]]) {
        self.dataModel.currCurrency = self.currencyTF.text;
    }
    
    [_currencyTF endEditing:YES];
}
- (IBAction)logoutFacebook:(id)sender {
    [FBSDKAccessToken setCurrentAccessToken:nil];
     [self performSegueWithIdentifier:@"LogOutSuccess" sender:nil];
}

#pragma mark - UIPickerViewDataSource
// #3
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// #4
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == self.currencyPicker) {
        if (self.currencyTF.text.length < 1) {
              _currencySelected = NO;
        }
        return [_dataModel.currencyNames count];
    }
    
    return 0;
}

#pragma mark - UIPickerViewDelegate

// #5
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == self.currencyPicker) {
        if (row > -1){
            _currencySelected = YES;
            return [_dataModel.currencyNames objectAtIndex:row];
        }
    }
    return nil;
}

// #6
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView == self.currencyPicker) {
        self.currencyTF.text = [_dataModel.currencyNames objectAtIndex:row];
       
    }
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"LogOutSuccess"]){
      LoginPage *loginPage = segue.destinationViewController;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
