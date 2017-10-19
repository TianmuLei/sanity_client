//
//  client.h
//  Sanity
//
//  Created by Tianmu on 10/5/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <SocketRocket/SRWebSocket.h>
#import "User.h"


@class SignupController;
@class LoginController;
@class AddTransactionController;
@class AddBudgetController;
@class BudgetListController;
@class BudgetPageController;
@class CategoryPageController;
@class ProfilePageController;
@class Budget;
@class Category;
@class ChangePasswordController;
@class ChangeUsernameController;
@class EditBudgetController;
@class BudgetListHistoryController;
@class BudgetPageHistoryController;

@interface client : NSObject <SRWebSocketDelegate>
@property (strong, atomic)  SRWebSocket *webSocket;
@property (strong, atomic)  User *myUser;
@property (strong,atomic) SignupController* signup;
@property (strong,atomic) LoginController* login;
@property (strong,atomic) AddTransactionController* addTransaction;
@property (strong,atomic) AddBudgetController* addBudget;
@property (strong,atomic) BudgetListController* budgetList;
@property (strong,atomic) BudgetPageController* budgetPage;
@property (strong,atomic) CategoryPageController* categoryPage;
@property (strong,atomic) ProfilePageController* profilePage;
@property (strong,atomic) ChangeUsernameController* changeUsername;
@property (strong,atomic) ChangePasswordController* changePassword;
@property (strong,atomic) EditBudgetController* editBudget;
@property (strong,atomic) BudgetListHistoryController* budgetListHistory;
@property (strong,atomic) BudgetPageHistoryController* budgetPageHistory;
@property (strong,atomic) NSMutableArray* budgetListData;
@property (strong,atomic) NSMutableArray* budgetHistoryData;
@property (strong,atomic) NSMutableArray* budgetHistoryDataDic;
@property (strong,atomic) NSMutableArray* budgetListDataDic;
-(NSString*) JSONToString:(NSDictionary*)dict;
-(NSDictionary*) StringToJSON:(NSString*) JSONString;
-(void) addBudgetListData:(NSMutableArray*) list;
-(void) sendMessage:(NSDictionary*)dict;
-(Budget*) getBudget:(NSString*)name;
-(Budget*) getBudget:(NSString*)name period:(int)period;
-(Category*) getCategory:(NSString*)budgetName :(NSString*)categoryName;
-(Category*) getCategory:(NSString*)budgetName :(NSString*)categoryName period:(int) period;
@end

