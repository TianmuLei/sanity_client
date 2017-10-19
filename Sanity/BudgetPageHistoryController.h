//
//  BudgetPageHistoryController.h
//  Sanity
//
//  Created by Tianmu on 10/18/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "MainController.h"

@protocol  BudgetPageHistoryControllerDelegate<NSObject>
//add call back function here
- (void) setBudget:(NSArray*) budget amount:(NSArray*) amount colors:(NSArray*)color;
- (void) setTexts:(NSArray*) textsArray slices:(NSArray*) slicesArray;
- (void) setTexts:(NSArray*) textsArray slices:(NSArray*)slicesArray transactionNames:(NSArray*) names transactionAmounts:(NSArray*) amounts transactionDates:(NSArray*)dates numOfTransactions:(int) number labelColor:(NSString*) color;

@required
@end

@interface BudgetPageHistoryController : MainController{
    id <BudgetPageHistoryControllerDelegate> _delegate;
}
@property (nonatomic,strong) id delegate;
-(void) requestBudget:(NSString*) name period:(int)period;
//-(void) requestCategory:(NSString*) budget category:(NSString*) category;
@end
