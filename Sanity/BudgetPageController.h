//
//  BudgetPageController.h
//  Sanity
//
//  Created by Tianmu on 10/15/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "MainController.h"

@protocol  BudgetPageControllerDelegate<NSObject>
//add call back function here
- (void) setBudget:(NSArray*) budget amount:(NSArray*) amount colors:(NSArray*)color;
- (void) setTexts:(NSArray*) textsArray slices:(NSArray*) slicesArray;
- (void) setTexts:(NSArray*) textsArray slices:(NSArray*)slicesArray transactionNames:(NSArray*) names transactionAmounts:(NSArray*) amounts transactionDates:(NSArray*)dates numOfTransactions:(int) number labelColor:(NSString*) color;

@required
@end

@interface BudgetPageController : MainController{
    id <BudgetPageControllerDelegate> _delegate;
}
@property (nonatomic,strong) id delegate;
-(void) requestBudgetList;
-(void) requestBudget:(NSString*) name;
-(void) requestCategory:(NSString*) budget category:(NSString*) category;
-(void) requestSummary:(NSString*) name;
@end
