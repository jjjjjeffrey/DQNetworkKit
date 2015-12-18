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

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkTaskDidStartNotification:) name:DQNetworkTaskDidStartNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkTaskDidCompleteNotification:) name:AFNetworkingTaskDidCompleteNotification object:nil];
    
    [self.apiManager requestWithParams:@{@"smsType": @(1),
                                         @"mobile": @"18616998609",
                                         @"name": @"小明"} landing:self];
    
    [self.apiManager requestWithParams:@{@"smsType": @(10),
                                         @"mobile": @"18888888888",
                                         @"name": @"呵呵呵"} landing:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Events and Actions
- (void)networkTaskDidStartNotification:(NSNotification *)notification {
    NSURLSessionDataTask *task = notification.object;
    NSLog(@"Request Identifier:%@", @(task.taskIdentifier));
    if (task.currentRequest.HTTPBody) {
        NSString *body = [[NSString alloc] initWithData:task.currentRequest.HTTPBody encoding:NSUTF8StringEncoding];
        NSLog(@"REQUEST------------------------------>:\n%@ %@\n%@\n%@",
              task.currentRequest.HTTPMethod, task.currentRequest.URL, task.currentRequest.allHTTPHeaderFields, body);
    }
}

- (void)networkTaskDidCompleteNotification:(NSNotification *)notification {
    NSURLSessionDataTask *task = notification.object;
    NSLog(@"Response Identifier:%@", @(task.taskIdentifier));
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
    NSDictionary *userInfo = notification.userInfo;
    if (userInfo[AFNetworkingTaskDidCompleteResponseDataKey]) {
        NSData *data = userInfo[AFNetworkingTaskDidCompleteResponseDataKey];
        NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"RESPONSE<------------------------------:\n%@\n%@",
              response.allHeaderFields, body);
    }
    
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
