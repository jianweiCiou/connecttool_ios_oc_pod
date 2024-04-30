//
//  CTOViewController.m
//  ConnectToolOC
//
//  Created by jianweiCiou on 04/18/2024.
//  Copyright (c) 2024 jianweiCiou. All rights reserved.
//

#import "CTOViewController.h"
 

//#import "ConnectToolOCframework.h"
#import "ConnectToolBlack.h"
#import "EnumConstants.h"
#import "WebViewController.h"
//#import <ConnectToolOCframework/ConnectToolBlack.h>
 
@interface CTOViewController ()

@end

@implementation CTOViewController
 
ConnectToolBlack *_connectTool;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // 工具初始
    NSString *RSAstr = @"";
    
    NSString *X_Developer_Id = @"";
    NSString *client_secret = @"";
    NSString *Game_id = @""; 
    
    _connectTool = [[ConnectToolBlack alloc]
                    initWithToolInfo:RSAstr
                    client_id:X_Developer_Id
                    X_Developer_Id:X_Developer_Id
                    client_secret:client_secret
                    Game_id:Game_id
                    platformVersion:nativeVS];
    
    
    // 切換測試與正式
     [ConnectToolBlack setToolVersion:testVS]; // 測試
    // [ConnectToolBlack setToolVersion:releaseVS]; // 正式
    
    
    NSString *notifyUrl = @""; // NotifyUrl is a URL customized by the game
    NSString *state = [[NSUUID UUID]UUIDString];
    
    NSInteger consume_spCoin = 1;
    NSString *orderNo = [[NSUUID UUID]UUIDString];
    NSString *requestNumber = [[NSUUID UUID]UUIDString];
    
    NSString *GameName = @"GameName";
    NSString *productName = @"productName";
    
    [_connectTool OpenConsumeSPURL:consume_spCoin orderNo:orderNo GameName:GameName productName:productName _notifyUrl:notifyUrl state:state requestNumber:requestNumber rootVC:self];

}


/// 17dame 應用事件回應
- (void) r17dame_ReceiverCallback:(NSNotification *) notification
{
    NSDictionary *dict = notification.userInfo;
    NSString *backType = [dict valueForKey:@"accountBackType"];
    
//    NSLog(@"17dame 應用事件回應 :%@" ,backType);
    if ([backType isEqualToString:@"CompletePurchase"]){
        NSLog(@"完成儲值");
        NSLog(@"TradeNo :%@" , [dict valueForKey:@"TradeNo"]);
        NSLog(@"PurchaseOrderId :%@" , [dict valueForKey:@"PurchaseOrderId"]);
         
        // 更新 me
        [self GetMe_Coroutine];
    }
    
    // Complete consumption of SP Coin
    if ([backType isEqualToString:@"CompleteConsumeSP"]){
        NSLog (@"CompleteConsumeSP");
        
        //完成消費 SP
        NSLog(@"完成消費");
        NSLog(@"consume_status :%@" , [dict valueForKey:@"consume_status"]);
        NSLog(@"transactionId :%@" , [dict valueForKey:@"transactionId"]);
        NSLog(@"orderNo :%@" , [dict valueForKey:@"orderNo"]);
        NSLog(@"productName :%@" , [dict valueForKey:@"productName"]);
        NSLog(@"spCoin :%@" , [dict valueForKey:@"spCoin"]);
        NSLog(@"rebate :%@" , [dict valueForKey:@"rebate"]);
        NSLog(@"orderStatus :%@" , [dict valueForKey:@"orderStatus"]);
        NSLog(@"state :%@" , [dict valueForKey:@"state"]);
        NSLog(@"notifyUrl :%@" , [dict valueForKey:@"notifyUrl"]);
         
         
    }
    
    // 登入
    if ([backType isEqualToString:@"Authorize"]){
        NSUUID *GetMe_RequestNumber =  [NSUUID UUID] ;
        NSString *state = @"App-side-State";
        [_connectTool appLinkDataCallBack_OpenAuthorize:notification
                                                 _state:state
                                    GetMe_RequestNumber:GetMe_RequestNumber authCallback:^(AuthorizeInfo *_token) {
            NSLog(@"Authorize 回應");
            NSLog(@"userId :%@" , _token.meInfo.data.userId);
            NSLog(@"email :%@" , _token.meInfo.data.email);
                        NSLog(@"spCoin :%ld" , (long)_token.meInfo.data.spCoin);
                        NSLog(@"rebate :%ld" , (long)_token.meInfo.data.rebate);
             
        }];
    }
}


-(void)GetMe_Coroutine{
    NSUUID *GetMe_RequestNumber = [NSUUID UUID]; // App-side-RequestNumber(UUID), default random
    [_connectTool GetMe_Coroutine:GetMe_RequestNumber callback:^(MeInfo * _Nonnull me) {
        NSLog(@"Authorize 回應");
        NSLog(@"userId :%@" , me.data.userId);
        NSLog(@"email :%@" , me.data.email);
        NSLog(@"nickName :%@" , me.data.nickName);
        NSLog(@"spCoin :%ld" , (long)me.data.spCoin);
        NSLog(@"rebate :%ld" , (long)me.data.rebate);
         
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
