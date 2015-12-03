//
//  APIParamsReformer.h
//  MoneyOrg
//
//  Created by Jeffrey on 15/12/2.
//  Copyright © 2015年 sheely.paean.coretest. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol DQAPIParamsReformer <NSObject>

/**
 *  业务参数转换为请求参数
 *  e.g:
 *  输入业务参数:
 *  {
 *      "key1" : "value1",
 *      "key3" : "value3",
 *      "key2" : "value2"
 *  }
 *  返回请求参数:
 *  {
 *      "identication" : {
 *      "imei" : "94BEC03E-BD7A-49E9-8412-CDE103F1776E",
 *      "build" : "1.0",
 *      "info" : "systemVersion:9.1;systemModel:iPhone",
 *      "type" : "basic",
 *      "version" : "1.0"
 *      },
 *      "data" : {
 *          "key1" : "value1",
 *          "key3" : "value3",
 *          "key2" : "value2"
 *     }
 *  }
 *
 *  @param rawValue 业务参数
 *
 *  @return 请求参数
 */
- (NSDictionary *)paramsWithRawValue:(NSDictionary *)rawValue;

@end
