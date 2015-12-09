//
//  DQViewController.m
//  DQNetworkKit
//
//  Created by zengdaqian on 12/02/2015.
//  Copyright (c) 2015 zengdaqian. All rights reserved.
//

#import "DQViewController.h"
#import "ExampleAPIManager.h"

@interface DQViewController () <DQAPIManagerDelegate>

@property (nonatomic, strong) ExampleAPIManager *apiManager;

@end

@implementation DQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.apiManager requestWithParams:@{@"smsType": @(1),
                                         @"mobile": @"18616998609",
                                         @"name": @"小明"} landing:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - DQAPIManagerDelegate
- (void)apiDidLandingSuccess:(DQAPIManger <DQAPI> *)apiManager; {
    
}

- (void)apiDidLandingFailure:(DQAPIManger<DQAPI> *)apiManager; {
    
}

#pragma mark - Getter And Setter
- (ExampleAPIManager *)apiManager {
    if (_apiManager == nil) {
        _apiManager = [ExampleAPIManager new];
    }
    return _apiManager;
}

@end
