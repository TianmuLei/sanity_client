//
//  BudgetListHistoryController.h
//  Sanity
//
//  Created by Tianmu on 10/18/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "MainController.h"

@protocol  BudgetListHistoryControllerDelegate<NSObject>
//add call back function here
- (void) setBudget:(NSArray*) budget amount:(NSArray*) amount colors:(NSArray*)color;
@required
@end

@interface BudgetListHistoryController : MainController{
    id <BudgetListHistoryControllerDelegate> _delegate;
}
@property (nonatomic,strong) id delegate;
-(void) requestBudgetList;
@end
