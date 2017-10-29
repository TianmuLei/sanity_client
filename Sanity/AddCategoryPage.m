//
//  AddCategoryPage.m
//  Sanity
//
//  Created by Ruyin Shao on 10/16/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "AddCategoryPage.h"
#import "UIClientConnector.h"
#import "AddCategoryController.h"
#import "AppDelegate.h"

@interface AddCategoryPage ()
@property (weak, nonatomic) IBOutlet UITextField *categoryNameTF;
@property (weak, nonatomic) IBOutlet UITextField *amountTF;
@property (strong, nonatomic) AddCategoryController* controller;

@end

@implementation AddCategoryPage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) addSuccessful{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) addFailed: (NSString *)reasonTitle withReason:(NSString *)reason{
    [self getAlerted:reasonTitle msg:reason];
}

- (IBAction)resignKeyboard:(id)sender {
    [sender resignFirstResponder];
}


- (IBAction)submitCategory:(id)sender {
    //error checking
    if (_categoryNameTF.text.length < 1 || _amountTF.text.length < 1)
    {
        [self getAlerted:@"Required Fields" msg:@"Please fill out all required fields"];
    }
    else if (![self numberFormatChecker:_amountTF.text]){
        [self getAlerted:@"Number format error" msg:@"Please enter the right number format for amount"];
    }
    else {
#warning call controller
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        [_controller addCategory:_budgetName :_categoryNameTF.text :[f numberFromString:_amountTF.text]];
      //  [self addSuccessful];
    }
    
    
}

/* ------ helper functions ------ */
//alert window
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


//return NO if not numeric
- (BOOL) numberFormatChecker: (NSString *) mString{
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    BOOL isDecimal = [nf numberFromString:mString] != nil;
    
    return isDecimal;
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
