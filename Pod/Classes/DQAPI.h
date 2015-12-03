//
//  API.h
//  MoneyOrg
//
//  Created by Jeffrey on 15/12/2.
//  Copyright © 2015年 sheely.paean.coretest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DQAPIReformer.h"

/**
 *  每个DQAPIManger子类都应遵守DQAPI协议
 */
@protocol DQAPI <NSObject>

@optional
- (NSString *)methodName;
- (NSString *)postPath;
- (id <DQAPIParamsReformer>)paramsReformer;
- (NSString *)baseURL;

@end
