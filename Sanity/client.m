//
//  client.m
//  Sanity
//
//  Created by Tianmu on 10/5/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "client.h"
#import "SignupController.h"
#import "LoginController.h"
#import "AddBudgetController.h"
#import "AddTransactionController.h"
#import "BudgetListController.h"
#import "BudgetPageController.h"
#import "CategoryPageController.h"
#import "ProfilePageController.h"
#import "UIClientConnector.h"
#import "Budget.h"
#import "Category.h"
#import "Transaction.h"

@implementation client
- (instancetype)init
{
    self = [super init];
    if (self) {
        _webSocket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:@"ws://165.227.14.202:9999"]];
        _webSocket.delegate = self;
       [_webSocket open];
        _myUser=[[User alloc] init];
        
        _signup=[[SignupController alloc] initWithClass:self];
        _login=[[LoginController alloc] initWithClass:self];
        _addBudget=[[AddBudgetController alloc] initWithClass:self];
        _addTransaction=[[AddTransactionController alloc] initWithClass:self];
        _budgetPage=[[BudgetPageController alloc] initWithClass:self];
        _budgetList=[[BudgetListController alloc] initWithClass:self];
        _categoryPage=[[CategoryPageController alloc] initWithClass:self];
        _profilePage=[[ProfilePageController alloc] initWithClass:self];

        
        
    }
    return self;
}


- (void)webSocketDidOpen:(SRWebSocket *)webSocket;
{
    NSLog(@"Websocket Connected");
  

  //  [_signup signup:@"tianmule@usc.edu" username:@"tianmule" password:@"baobao"];
   // [_signup signup:@"helenlei@g.com" username:@"ruyinsha" password:@"1234567"];

    //NSDictionary *message=@{@"function":@"test"};
    //[UIClientConnector.myClient sendMessage:message];

    LoginController* logCon=[[LoginController alloc] initWithClass:self];
   [logCon login:@"tianmule@usc.edu" password:@"baobao"];
   //[logCon login:@"tianmule@usc.edu" password:@"baobao1"];
    
  /*  NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = 4;
    dateComponents.month = 5;
    dateComponents.year = 2004;
    
    AddBudgetController* addCon=[[AddBudgetController alloc] initWithClass:self];
    NSMutableArray *categoryList = [[NSMutableArray alloc]init];
    NSNumber* periodObject=[[NSNumber alloc]initWithInteger:30];
    Category* cat1=[[Category alloc]init];
    Category* cat2=[[Category alloc]init];
    cat1.name=@"cat";
      cat2.name=@"dog";
    cat1.limit=100;
    cat2.limit=100;
    
    
     [categoryList addObject:cat1];
     [categoryList addObject:cat2];*/


    //[addCon addBudget:@"testBudget1" period:periodObject date:dateComponents category:categoryList threshold:periodObject frequency:periodObject];
    
   // [_addTransaction addTransaction: [[NSNumber alloc]initWithInteger:30] describe:@"lunch" category:@"cat" budget:@"testBudget1" date:dateComponents];
    [_budgetList requestBudgetList];
    [_budgetList requestBudget:@"testBudget1" ];

    [_categoryPage requestCategory:@"testBudget1" category:@"cat"];
 
    

    
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error;
{
    NSLog(@":( Websocket Failed With Error %@", error);
    
    _webSocket = nil;
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessageWithString:(nonnull NSString *)string
{
    NSLog(@"Received \"%@\"", string);
    
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean;
{
    NSLog(@"WebSocket closed");
    _webSocket = nil;
}

- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload;
{
    NSLog(@"WebSocket received pong");
}



- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    //NSLog(@"WebSocket received message");
    NSString *myString = (NSString *)message;
    
    if ([myString rangeOfString:@"function"].location == NSNotFound) {
        NSLog(@"ignore message");
    } else {
        
        
        NSData *webData = [myString dataUsingEncoding:NSUTF8StringEncoding];
        
        NSError *error;
        NSDictionary *messageObject = [NSJSONSerialization JSONObjectWithData:webData options:0 error:&error];
        NSLog(@"JSON DIct: %@", messageObject);
        
        NSString* function = [messageObject objectForKey:@"function"];
        NSString* status = [messageObject objectForKey:@"status"];
        
        if ([function isEqualToString:@"register"]){
            if([status isEqualToString:@"fail"]){
                [_signup fail];
                
            }else{
                [_signup success];
            }
        }
        else if ([function isEqualToString:@"login"]){
            if([status isEqualToString:@"fail"]){
                [_login fail];
                
            }else{
                [_login success:[messageObject objectForKey:@"budgetList"]];
                _myUser.username=[messageObject objectForKey:@"username"];
                [self addBudgetListData:[messageObject objectForKey:@"budgetList"]];
                
            }
        }
        else if ([function isEqualToString:@"createBudget"]){
            if([status isEqualToString:@"fail"]){
                [ _addBudget fail];
            }else{
                [ _addBudget success];

            }
        }
        else if ([function isEqualToString:@"addTransaction"]){
            if([status isEqualToString:@"fail"]){
                
            }else{
                
            }
        }
        else if ([function isEqualToString:@"returnBudgetList"]){
            if([status isEqualToString:@"fail"]){
                
            }else{
                NSDictionary*info=[messageObject objectForKey:@"information"];
                [self addBudgetListData:[info objectForKey:@"budgetList"]];
            }
        }
        else if ([function isEqualToString:@"returnCategoryList"]){
            if([status isEqualToString:@"fail"]){
                
            }else{
                 NSDictionary*info=[messageObject objectForKey:@"information"];
                [self addCategoryData:info];
                
            }
        }
        else if ([function isEqualToString:@"returnTransactionsList"]){
            if([status isEqualToString:@"fail"]){
                
            }else{
                NSDictionary*info=[messageObject objectForKey:@"information"];
                [self addTansData:info];
                
            }
        }
        
        
        
     
    }
    
    
    
    
}


-(NSString*) JSONToString:(NSDictionary*)dict{
    NSError *error = nil;
    NSData *json;
    
    // Dictionary convertable to JSON ?
    if ([NSJSONSerialization isValidJSONObject:dict])
    {
        // Serialize the dictionary
        json = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        
        // If no errors, let's view the JSON
        if (json != nil && error == nil)
        {
            NSString *jsonString = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
            
            return jsonString;
        }
    }
    return @"";
    
}

-(NSDictionary*) StringToJSON:(NSString*) JSONString{
    //NSString *path = JSONString;
    NSData *jsonData = [NSData dataWithContentsOfFile:JSONString];
    
    NSError *error = nil;
    
    // Get JSON data into a Foundation object
    id object = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    
    if( [object isKindOfClass:[NSDictionary class]] && error == nil){
         return object;
    }
    else{
        return nil;
    }
    
   
}


-(void) sendMessage:(NSDictionary*)dict{
    NSString *message=[self JSONToString:dict];
    NSLog(@"sendmessage:  \"%@\"", message);
   [_webSocket send:message];
}

-(void) addBudgetListData:(NSMutableArray*) list{
    _budgetListData=[[NSMutableArray alloc]init];
    
    for(int i=0;i<list.count;i++){
        NSDictionary* budget=[list objectAtIndex:i];
        Budget* single=[[Budget alloc]init];
        single.name=[budget objectForKey:@"name"];
        single.spent=[[budget objectForKey:@"budgetSpent"] doubleValue];
        single.total=[[budget objectForKey:@"budgetTotal"] doubleValue];
        single.startDateString=[budget objectForKey:@"date"];
        single.frequency=[[budget objectForKey:@"frequency"] intValue];
        single.threshold=[[budget objectForKey:@"threshold"] intValue];
        
        [_budgetListData addObject:single];
      //  Budget
              //NSString *spendT = [NSNumber stringValue];
        
    
        
    }
    
}

-(void) addCategoryData:(NSDictionary*) info{
    NSMutableArray* categoryList=[[NSMutableArray alloc]init];
    NSArray* cate=[info objectForKey:@"categoryList"];
    NSString* budgetname=[info objectForKey:@"budgetName"];
    
    
    for(int i=0;i<cate.count;i++){
        NSDictionary* category=[cate objectAtIndex:i];
        Category* single=[[Category alloc]init];
        single.name=[category objectForKey:@"name"];
        single.limit=[[category objectForKey:@"limit"] doubleValue];
        single.spent=[[category objectForKey:@"categorySpent"] doubleValue];
        single.budget=budgetname;
        [categoryList addObject:single];
    }
    for(int i=0;i<_budgetListData.count;i++){
        Budget* single=[_budgetListData objectAtIndex:i];
        if([single.name isEqualToString:budgetname]){
            single.categories=categoryList;
        }
    }
    
}
-(void) addTansData:(NSDictionary*) info{
    NSMutableArray* TransList=[[NSMutableArray alloc]init];
    NSArray* trans=[info objectForKey:@"transctionList"];
    NSString* budgetname=[info objectForKey:@"budget"];
    NSString* categoryname=[info objectForKey:@"category"];

    
    for(int i=0;i<trans.count;i++){
        NSDictionary* transaction=[trans objectAtIndex:i];
        Transaction* single=[[Transaction alloc]init];
        single.description=[transaction objectForKey:@"description"];
        single.amount=[transaction objectForKey:@"amount"];
        single.dateString=[transaction objectForKey:@"date"];
        single.budget=budgetname;
        single.category=categoryname;
        [TransList addObject:single];
    }
    for(int i=0;i<_budgetListData.count;i++){
        Budget* single=[_budgetListData objectAtIndex:i];
        if([single.name isEqualToString:budgetname]){
            for(int j=0;j<single.categories.count;j++){
                Category* cat=  [single.categories objectAtIndex:j];
                if([cat.name isEqualToString:categoryname]){
                    cat.transctions=TransList;
                }
            }
        
        }
    }
    
}






@end

