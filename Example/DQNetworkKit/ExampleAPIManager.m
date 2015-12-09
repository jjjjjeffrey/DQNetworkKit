//
//  ExampleAPIManager.m
//  DQNetworkKit
//
//  Created by Jeffrey on 15/12/2.
//  Copyright © 2015年 zengdaqian. All rights reserved.
//

#import "ExampleAPIManager.h"
#import "UICKeyChainStore.h"

@interface ExampleAPIParamsReformer : NSObject <DQAPIParamsReformer>

@end

@implementation ExampleAPIParamsReformer

- (NSDictionary *)paramsWithRawValue:(NSDictionary *)rawValue api:(id <DQAPI>)api; {
    NSMutableDictionary *reformeredParams = [NSMutableDictionary new];
    reformeredParams[@"function"] = [api methodName];
    reformeredParams[@"timestamp"] = @"20151115124850";
    reformeredParams[@"source"] = @"IOS";
    reformeredParams[@"version"] = @"1.0.0";
    
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:@"user"
                                                                accessGroup:APP_GROUP];
    NSString *uuid = keychain[@"uuid"];
    if (uuid == nil) {
        uuid = [UIDevice currentDevice].identifierForVendor.UUIDString;
        keychain[@"uuid"] = uuid;
    }
    reformeredParams[@"imei"] = uuid;
    if (rawValue) {
        reformeredParams[@"data"] = rawValue;
    }
    return reformeredParams;
}

@end

@interface ExampleAPIManager ()

@property (nonatomic, strong) id <DQAPIParamsReformer> paramsReformer;


@end

@implementation ExampleAPIManager

- (NSString *)methodName; {
    return @"common.sendcode";
}

- (NSString *)baseURL {
    return @"http://cdev.365qian.com/";
}

- (NSString *)postPath; {
    return @"data.ashx";
}

//- (NSString *)paramsSerializedWithParams:(NSDictionary *)params; {
//    if (params == nil) return @"";
//    NSData *data = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
//    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//}

- (id <DQAPIParamsReformer>)paramsReformer {
    if (_paramsReformer == nil) {
        _paramsReformer = [ExampleAPIParamsReformer new];
    }
    return _paramsReformer;
}

@end
