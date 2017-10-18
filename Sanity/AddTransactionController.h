//
//  AddTransactionController.h
//  Sanity
//
//  Created by Tianmu on 10/14/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "MainController.h"

@protocol  AddTransactionControllerDelegate<NSObject>
//add call back function here
- (void) addSuccessful;
- (void) addFailed;
- (void) receiveBudgetInfo: (NSMutableArray *) budgetsFromServer;

@required
@end

@interface AddTransactionController : MainController{
      id <AddTransactionControllerDelegate> _delegate;
}
@property (nonatomic,strong) id delegate;
-(void) addTransaction: (NSNumber*) amount describe:(NSString*) describe category:(NSString*) category budget:(NSString*)budget date:(NSDateComponents*) date;
-(void) requestBudgetAndCate;
-(void) fail;
-(void) success;

@end
