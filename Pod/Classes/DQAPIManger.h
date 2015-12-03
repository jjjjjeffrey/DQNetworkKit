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
/**
 *  API着陆代理协议
 */
@protocol DQAPIManagerDelegate <NSObject>

- (void)apiDidLandingSuccess:(DQAPIManger <DQAPI> *)apiManager;

- (void)apiDidLandingFailure:(DQAPIManger<DQAPI> *)apiManager;

@end


/**
 *  API请求基类，每个API请求类都应继承此类，并遵守DQAPI协议
 */
@interface DQAPIManger : NSObject


/**
 *  API返回Model类
 */
@property (nonatomic, strong, readonly) DQAPIResponse *response;
@property (nonatomic, strong, readonly) NSError *error;
/**
 *  API着陆代理
 */
@property (nonatomic, weak) id <DQAPIManagerDelegate> delegate;

/**
 *  API起飞方法，用于放飞API请求
 *
 *  @param params   业务参数
 *  @param delegate 着陆代理
 */
- (void)requestWithParams:(NSDictionary *)params landing:(id <DQAPIManagerDelegate>)delegate;
/**
 *  API起飞方法，用于放飞API请求
 *
 *  @param params   业务参数
 *  @param reformer 指定参数转换器
 *  @param delegate 着陆代理
 */
- (void)requestWithParams:(NSDictionary *)params reformer:(id <DQAPIParamsReformer>)reformer landing:(id <DQAPIManagerDelegate>)delegate;

/**
 *  取消请求
 */
- (void)cancel;

@end


@interface DQAPIResponse : NSObject

/**
 *  错误码
 */
@property (nonatomic) NSInteger code;
/**
 *  业务数据
 */
@property (nonatomic, strong) NSDictionary *data;
/**
 *  错误信息
 */
@property (nonatomic, strong) NSString *message;

@end

