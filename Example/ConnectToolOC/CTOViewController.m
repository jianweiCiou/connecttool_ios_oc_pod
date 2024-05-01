//
//  CTOViewController.m
//  ConnectToolOC
//
//  Created by jianweiCiou on 04/18/2024.
//  Copyright (c) 2024 jianweiCiou. All rights reserved.
//

#import "CTOViewController.h"
 
 
#import "ConnectToolBlack.h"
#import "EnumConstants.h"
#import "WebViewController.h" 
 
@interface CTOViewController ()

@end

@implementation CTOViewController
 
ConnectToolBlack *_connectTool;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // 工具初始
    NSString *RSAstr = @"-----BEGIN RSA PRIVATE KEY-----\n MIIEowIBAAKCAQEAudt2mFGvEEmpqFsYhdq+UrA04UoumRcB7LYx7VO4QWYzDYwNBWuMM3XfGqDSd3bC9R8uzPy2oeENa55F6R9HTk4aa7TSIVYsMp1Ipn/SMhs3snBoE9UzmUTezNKYvEZQ8yLdItAFfnql3pho7iM52h+dvdhNaPNq4W5CGqMdkOzbHcFEZMkmb0HCZJ33Iwti5gdqhrJVIA+ELGS7H/CIbOy4X6kT/9owukqSNKScBZikIHRfONMyBN4IhBbEMXRisiTz/nXoLdXP7p7/Q6gP9lIskIPWGaydncQARTKFisMkUxqM/gXcoQhXKR78MMIouyvZNuMzh4K9sxFQpamf2QIDAQABAoIBAAvpqI+u0f0bRkfyPtTQO9lqTe660IMjhGNlx4wiDPIJg5rfWoj5vGzNUKrmRVc+7NQarDybXiFrdBltIFIG8o0ZrdEwL9/PJC9tAWvFTvXDOi4HzRlTAGcB5mipKae3t2yTftUXvE0VE238cDgDWKvwfC3foBFADkkQxiVARfQ0qQes5Q6KvHIxZROzQnIpTScw8ZFdiKE1ilvytViLZeVzS+aCrXw3XTa75NU6AUAYdUmZlSlYnxuLCVuDgDBZ6TC94ZWXddv+emFWcf3lfV8MB4p6zLkW1w3jGJ47/JVfiHSvr6lKJbgUnZmzj4zDRgPnB327jrpPoF8QivV+Y5kCgYEA1yYArMdMVPYyy8BlB5rd5SOB6BL0odmdMG7tXAQsyLaINqpc3/RDRdPTry3wiGAyf0HVdAeDt9yZLmtH6hpkFogsVMilxbdLqMXd8qTdMczRJ8Mj1InsnY/fWOcaKDdQs0CA5CJYB69IX+82rxczvTltlsDxDB+A9b5LSFioa38CgYEA3SWqxVDf+QduKOnWzxrnCuns3N9MeBMpwBY3Dx2rYrPsPs4Lueb43e8M/qqg/jApufj567Ruh8H/kO6fvbMm9JxGZ9M5riLn3CuWoich8EpT4qSvZu+zUL0dVyBiYWMfXexcNUq6ckjWP+QmtiU1B9Bq4uWR1h3hCJg08lv0gKcCgYAgM5bsRVQeb08BAgXdEofdsOfTpWqqAtktE51BJXrSe8d9bxhBiNy8ycyoLpcOwl8sft0E5c8IKONgeDwmRNbwLGd+NR3iruGLHDpxA837ky1G50UonZAlsQ/7zXMzy7uvaJsiCiXk2I5blYE4yZ871imZ47zwVJLHtTitVl+23wKBgQCje3UC6Qap0hRdqoBiGkEykDvKDEk7eu8iUUniosxP6zJ6O1fv1g+kAVRZ70mUn4Y5NRWMaZZMRd3oBn+QfSAPNHfXyQ6a7LL60D5LISK1wDzDD3ubXRfyV9uYzRftZpmJlXGU8+lhEvdPxBnaDSdm32wk0BE/eFcjQ2HgyJm3gQKBgHv38GPMFMjbk0hULRMF6doKb8lHuuJoona4cC4mh5BUye5On5u8BH+ZrKP1i2W+Ttkva1kxb+V28BWnzROs3pXR6gYel7Yz18n87IjUD+NFWMdRmsNHKMwj15jbK9ZjUuum6afjHuQfkwfyE3JV0rjGI5rrisrMYmGxfjnBcX48\n -----END RSA PRIVATE KEY-----\n";
    
    NSString *X_Developer_Id = @"ebe4ae28-dda1-499d-bdbc-1066ce080a6f";
    NSString *client_secret = @"AQAAAAIAAAAQKK7k66HdnUm9vBBmzggKb+l99746/ADCj911GtHQaAgjxcxUGjnwDDY+Ao57SfwV";
    NSString *Game_id = @"07d5c223-c8ba-44f5-b9db-86001886da8d";
    
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
    
    
    NSString *notifyUrl = @"";// NotifyUrl is a URL customized by the game developer
      
     NSString *state = @"Custom state";// Custom state
     
     // Step2. Set currencyCode
     NSString *currencyCode = @"2";
     [_connectTool OpenRechargeURL:currencyCode _notifyUrl:notifyUrl state:state rootVC:self];

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
