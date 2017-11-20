//
//  AddTransactionPage.m
//  Sanity
//
//  Created by Ruyin Shao on 10/16/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "AddTransactionPage.h"
#import "Budget.h"
#import "Category.h"
#import "UIClientConnector.h"
#import "AddTransactionController.h"
#import "AppDelegate.h"
#import "TesseractOCR.h"


@interface AddTransactionPage () <UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate>

@property (nonatomic, strong) NSOperationQueue *operationQueue;

//UI Elements
@property (weak, nonatomic) IBOutlet UITextField *budgetTF;
@property (weak, nonatomic) IBOutlet UIDatePicker *date;
@property (weak, nonatomic) IBOutlet UITextField *amountTF;
@property (weak, nonatomic) IBOutlet UITextField *categoryTF;
@property (weak, nonatomic) IBOutlet UITextField *descripTF;
@property UIPickerView *budgetPicker;
@property UIPickerView *categoryPicker;
@property (weak, nonatomic) IBOutlet UIButton *uploadButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


//Arrays
@property (strong, nonatomic) NSMutableArray *budgets;
@property (strong, nonatomic) NSMutableArray *categoriesCurrBudget;
@property (strong, nonatomic) AddTransactionController *controller;
@property BOOL budgetSelected;

@end

@implementation AddTransactionPage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Create a queue to perform recognition operations
    self.operationQueue = [[NSOperationQueue alloc] init];
    
    self.budgetSelected = NO;
    _budgets = [[NSMutableArray alloc]init];
    _categoriesCurrBudget = [[NSMutableArray alloc]init]; 
    
    Budget * bg = [[Budget alloc] init];
    bg.name = @"mybudget";
    bg.categories = [[NSMutableArray alloc] init];
    Category * cate1 = [[Category alloc] init];
    cate1.name = @"hahah";
    [bg.categories addObject:cate1];
    [_budgets addObject:bg];
    
    _controller = UIClientConnector.myClient.addTransaction;
    UIClientConnector.myClient.addTransaction.delegate = self;

    //call function
    [_controller requestBudgetAndCate];
    
    self.budgetPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
    self.budgetPicker.delegate = self;
    self.budgetPicker.dataSource = self;
    self.budgetPicker.showsSelectionIndicator = YES;
    _budgetTF.inputView = self.budgetPicker;
    
    self.categoryPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
    self.categoryPicker.delegate = self;
    self.categoryPicker.dataSource = self;
    self.categoryPicker.showsSelectionIndicator = YES;
    _categoryTF.inputView = self.categoryPicker;
    
 
//    [yourpicker setDelegate: self];
//    yourpicker.showsSelectionIndicator = YES;
//    self.budgetTF.inputView = yourpicker;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)uploadPressed:(id)sender {
    //pick an image
    UIImagePickerController *imgPicker = [UIImagePickerController new];
    imgPicker.delegate = self;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imgPicker animated:YES completion:nil];
    }
}

#pragma OCR Helper Method
-(void)recognizeImageWithTesseract:(UIImage *)image
{
#warning to be modified
    // Animate a progress activity indicator
    [self.activityIndicator startAnimating];
    
    // Create a new `G8RecognitionOperation` to perform the OCR asynchronously
    // It is assumed that there is a .traineddata file for the language pack
    // you want Tesseract to use in the "tessdata" folder in the root of the
    // project AND that the "tessdata" folder is a referenced folder and NOT
    // a symbolic group in your project
    G8RecognitionOperation *operation = [[G8RecognitionOperation alloc] initWithLanguage:@"eng"];
    
    // Use the original Tesseract engine mode in performing the recognition
    // (see G8Constants.h) for other engine mode options
    operation.tesseract.engineMode = G8OCREngineModeTesseractOnly;
    
    // Let Tesseract automatically segment the page into blocks of text
    // based on its analysis (see G8Constants.h) for other page segmentation
    // mode options
    operation.tesseract.pageSegmentationMode = G8PageSegmentationModeAutoOnly;
    
    // Optionally limit the time Tesseract should spend performing the
    // recognition
    //operation.tesseract.maximumRecognitionTime = 1.0;
    
    // Set the delegate for the recognition to be this class
    // (see `progressImageRecognitionForTesseract` and
    // `shouldCancelImageRecognitionForTesseract` methods below)
    operation.delegate = self;
    
    // Optionally limit Tesseract's recognition to the following whitelist
    // and blacklist of characters
    //operation.tesseract.charWhitelist = @"01234";
    //operation.tesseract.charBlacklist = @"56789";
    
    // Set the image on which Tesseract should perform recognition
    operation.tesseract.image = image;
    
    // Optionally limit the region in the image on which Tesseract should
    // perform recognition to a rectangle
    //operation.tesseract.rect = CGRectMake(20, 20, 100, 100);
    
    // Specify the function block that should be executed when Tesseract
    // finishes performing recognition on the image
    operation.recognitionCompleteBlock = ^(G8Tesseract *tesseract) {
        // Fetch the recognized text
        NSString *recognizedText = tesseract.recognizedText;
        
        //remove weird characters
        NSString *textCopy = [[NSString alloc]initWithString:tesseract.recognizedText];
        NSCharacterSet *charactersToRemove  = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyz .ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"] invertedSet];
        NSString *strippedString = [[textCopy componentsSeparatedByCharactersInSet:charactersToRemove] componentsJoinedByString:@""];
        strippedString =  [strippedString lowercaseString];
        
        NSArray *array = [strippedString componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        array = [array filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];
        //  NSLog(@"%@",array);
        
        //look for subtotal, tax and total
        bool subtotalFound = FALSE;
        bool totalFound = FALSE;
        bool taxFound = FALSE;
        float subtotal = -1;
        float total = -1;
        float tax = -1;
        
        for(int i=0; i<(array.count-1); i++)
        {
            if((!subtotalFound) && [array[i] rangeOfString:@"subtotal"].location != NSNotFound)
            {
                NSLog(@"subtotalFound: %@", array[i+1]);
                subtotalFound = TRUE;
                NSString* floatString = [NSString stringWithString:(NSString*)array[i+1]];
                subtotal = [floatString floatValue];
                //check if is valid
                if(subtotal == 0)
                {
                    subtotal = -1;
                    subtotalFound = NO;
                }
            }else if((!totalFound) && [array[i] rangeOfString:@"total"].location != NSNotFound){
                NSLog(@"totalFound: %@", array[i+1]);
                totalFound = TRUE;
                NSString* floatString = [NSString stringWithString:(NSString*)array[i+1]];
                total = [floatString floatValue];
                //check if is valid
                if(total ==0)
                {
                    total = -1;
                    totalFound = NO;
                }
            }else if(subtotalFound && (!taxFound) && [array[i] rangeOfString:@"tax"].location != NSNotFound){
                NSLog(@"taxFound: %@", array[i+1]);
                taxFound = TRUE;
                NSString* floatString = [NSString stringWithString:(NSString*)array[i+1]];
                tax = [floatString floatValue];
            }
            
            //break if all found
            if(taxFound && totalFound && subtotalFound)
            {
                break;
            }
        }
        
        
        NSString * stored = nil;
        if(subtotal==-1 && tax==-1 && total==-1)
        {
            NSLog(@"NOT FOUND!!!");
            stored = @"NOT FOUND!!!";
        }else if(subtotal==-1 || tax==-1){
            NSLog(@"total is: %.02f", total);
            stored = [[NSString alloc] initWithFormat:@"total is: %.02f", total];
        }else if(total==-1){
            NSLog(@"total calculuated is: %.02f", (subtotal+tax));
            stored = [[NSString alloc] initWithFormat:@"total calculuated is: %.02f", (subtotal+tax)];
        }else if((subtotal+tax)==total){
            NSLog(@"matched total is: %.02f", total);
            stored = [[NSString alloc] initWithFormat:@"matched total is: %.02f", total];
        }else if((subtotal+tax)<total){
            NSLog(@"smaller total is: %.02f", subtotal+tax);
            stored = [[NSString alloc] initWithFormat:@"smaller total is: %.02f", subtotal+tax];
        }else{
            NSLog(@"total smaller is: %.02f", total);
            stored = [[NSString alloc] initWithFormat:@"total smaller is: %.02f", total];
        }
        //      NSString* display = [[NSString alloc] initWithFormat:@"%@,   %@", recognizedText,stored];
        
        // Remove the animated progress activity indicator
        [self.activityIndicator stopAnimating];
        
        // Spawn an alert with the recognized text
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"OCR Result"
                                                        message:stored
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    };
    
    // Display the image to be recognized in the view
    //self.imageToRecognize.image = operation.tesseract.thresholdedImage;
    
    // Finally, add the recognition operation to the queue
    [self.operationQueue addOperation:operation];
}

#pragma mark - UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self recognizeImageWithTesseract:image];
}

#pragma OCR Delegate
- (void)progressImageRecognitionForTesseract:(G8Tesseract *)tesseract {
    //  NSLog(@"progress: %lu", (unsigned long)tesseract.progress);
}

- (BOOL)shouldCancelImageRecognitionForTesseract:(G8Tesseract *)tesseract {
    return NO;
}


#pragma mark - UIPickerViewDataSource
// #3
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (pickerView == self.budgetPicker|| pickerView == self.categoryPicker) {
        return 1;
    }

    
    return 0;
}

// #4
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == self.budgetPicker) {
        if (_budgetTF.text.length < 1) {
           //  _budgetSelected = NO;
        }
        return [self.budgets count];
    }
    if (pickerView == self.categoryPicker) {
#warning  tobe changed
        if (self.budgetSelected){
            return [self.categoriesCurrBudget count];
        }
        return 0;
    }
    
    return 0;
}

#pragma mark - UIPickerViewDelegate

// #5
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == self.budgetPicker) {
        if (row > -1){
            self.categoriesCurrBudget = [(Budget *)[self.budgets objectAtIndex:row] categories];
            _budgetSelected = YES;
            return [(Budget *)self.budgets[row] name];
        }
    }
    if (pickerView == self.categoryPicker) {
        if (_budgetSelected){
            return [(Category *)self.categoriesCurrBudget[row] name];
        }
        return nil;
    }
    
    return nil;
}

// #6
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView == self.budgetPicker) {
        self.budgetTF.text = [(Budget *)self.budgets[row] name];
        self.categoriesCurrBudget = [(Budget *)[self.budgets objectAtIndex:row] categories];
        [_budgetTF endEditing:YES];
    }
    if (pickerView == self.categoryPicker) {
        self.categoryTF.text = [(Category *)self.categoriesCurrBudget[row] name];
        [_categoryTF endEditing:YES];
    }
}


#pragma mark - Table view data source
- (IBAction)submitTransaction:(id)sender {
    if (_amountTF.text.length < 1 || _budgetTF.text.length < 1 || _categoryTF.text.length < 1) {
        [self getAlerted:@"Required Fields" msg:@"Please fill in all required fields"];
    }

    else if (![self numberFormatChecker:_amountTF.text]){
         [self getAlerted:@"Number format Error" msg:@"Please enter numbers for transaction amount"];
    
    }
    else {
        //get elements
        NSCalendar *calendar            = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        
        NSDateComponents *components = [calendar components:(NSCalendarUnitYear|
                                                             NSCalendarUnitMonth |
                                                             NSCalendarUnitDay   |
                                                             NSCalendarUnitHour  |
                                                             NSCalendarUnitMinute|
                                                             NSCalendarUnitSecond) fromDate:[_date date]];
        
        //check whether exceeds amount
        NSNumber *newAmount = [NSNumber numberWithFloat:_amountTF.text.floatValue];
        [self exceedsBudget:newAmount withBudget:_budgetTF.text withCategory:_categoryTF.text];
        [_controller addTransaction:newAmount describe:_descripTF.text category:_categoryTF.text budget:_budgetTF.text date:components];
        
    }

}

- (BOOL) exceedsBudget:(NSNumber *) newAmount withBudget:(NSString*) budget withCategory:(NSString*) cate{
    
    for (Budget* b in _budgets) {
        if ([b.name isEqualToString: budget]) {
            int threshold = b.threshold;
            
            for (Category *c in b.categories) {
                if ([c.name isEqualToString:cate]){
                    float n = c.spent + [newAmount floatValue];
                    float remainingAmount = b.total - b.spent - [newAmount floatValue];
                    if (n > c.limit*threshold/100) {
                        NSString *notiTitle = [[NSString alloc] initWithFormat:@"Spent over budget with threshold %@ %% ", @(b.threshold).stringValue];
                        NSString *notiContent = [[NSString alloc] initWithFormat:@"You spend over budget %@ in category %@, date remaining %@, amount remainging %@", b.name, c.name,@(b.remain).stringValue,@(remainingAmount).stringValue];
                        [AppDelegate setNotificationTitleAndContent:notiTitle withContent:notiContent];
                        [AppDelegate registerNotification:3];
                        for (int i = 1; i <  b.remain; ++ i) {
                            [AppDelegate setNotificationTitleAndContent:notiTitle withContent:notiContent];
                            [AppDelegate registerNotification:60*60*24*i];

                        }
#warning lack time interval
                        break;
                    }
                }
            }
        }
    }
    
    return false;
}

- (float) remainingAmountCalc:(Budget*) b newAmount: (float) amount{
    
    return 0.0f;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [super tableView:tableView numberOfRowsInSection:section];

}

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

//call back functions
- (void) receiveBudgetInfo:(NSMutableArray *)budgetsFromServer{
    _budgets = budgetsFromServer;
    
}

- (void) addSuccessful{
      [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void) addFailed{
    [self getAlerted:@"Duplicate transactions" msg:@"You have entered a transaction that's duplicate"];
}


//dismiss keyboards
- (IBAction)dissmissKey:(id)sender {
    [sender resignFirstResponder];
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
