//
//  API.h
//  MoneyOrg
//
//  Created by Jeffrey on 15/12/2.
//  Copyright © 2015年 sheely.paean.coretest. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  每个DQAPIManger子类都应遵守DQAPI协议
 */
@protocol DQAPIParamsReformer;
@protocol DQAPI <NSObject>

@optional
/**
 *  方法名
 *
 *  @return 返回接口请求方法名
 */
- (NSString *)methodName;
/**
 *  请求路径
 *
 *  @return 返回自定义请求路径
 */
- (NSString *)postPath;
/**
 *  参数转换器，用于将业务参数转换为实际请求参数，详见DQAPIParamsReformer协议
 *
 *  @return 返回自定义的参数转换器
 */
- (id <DQAPIParamsReformer>)paramsReformer;
/**
 *  URL请求地址
 *
 *  @return 返回自定义的URL请求地址
 */
- (NSString *)baseURL;
/**
 *  用于自定义参数的序列化，默认参数序列化为URL编码方式
 *
 *  @param params 参数字典
 *
 *  @return 返回自定义序列化参数字符串
 */
- (NSString *)paramsSerializedWithParams:(NSDictionary *)params;

@end
