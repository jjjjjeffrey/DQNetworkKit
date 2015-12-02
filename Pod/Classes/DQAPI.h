//
//  API.h
//  MoneyOrg
//
//  Created by Jeffrey on 15/12/2.
//  Copyright © 2015年 sheely.paean.coretest. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DQAPI <NSObject>

@required
- (NSString *)methodName;
@optional
- (NSString *)baseURL;

@end
