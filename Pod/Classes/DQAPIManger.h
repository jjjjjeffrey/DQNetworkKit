//
//  APIManger.h
//  MoneyOrg
//
//  Created by Jeffrey on 15/12/1.
//  Copyright © 2015年 sheely.paean.coretest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DQAPI.h"
#import "DQAPIReformer.h"

@class DQAPIManger;
@class DQAPIResponse;
@protocol DQAPIManagerDelegate <NSObject>

- (void)apiDidLandingSuccess:(DQAPIManger <DQAPI> *)apiManager;

- (void)apiDidLandingFailure:(DQAPIManger<DQAPI> *)apiManager;

@end

@interface DQAPIManger : NSObject

@property (nonatomic, strong, readonly) DQAPIResponse *response;
@property (nonatomic, strong, readonly) NSError *error;

@property (nonatomic, weak) id <DQAPIManagerDelegate> delegate;

- (void)requestWithParams:(NSDictionary *)params landing:(id <DQAPIManagerDelegate>)delegate;

- (void)requestWithParams:(NSDictionary *)params reformer:(id <DQAPIParamsReformer>)reformer landing:(id <DQAPIManagerDelegate>)delegate;

@end


@interface DQAPIResponse : NSObject

@property (nonatomic) NSInteger code;
@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic, strong) NSString *message;

@end

