//
//  APIManger.m
//  MoneyOrg
//
//  Created by Jeffrey on 15/12/1.
//  Copyright © 2015年 sheely.paean.coretest. All rights reserved.
//

#import "DQAPIManger.h"
#import "AFNetworking.h"
#import "UICKeyChainStore.h"
#import "YYModel.h"
#import "DQAPI.h"
#import "DQAPIReformer.h"

#define APP_GROUP @"DQTest.amazingAppFamily"




@interface APIParamsDefaultReformer : NSObject <DQAPIParamsReformer>

@end

@implementation APIParamsDefaultReformer

- (NSDictionary *)paramsWithRawValue:(NSDictionary *)rawValue api:(id <DQAPI>)api; {
    NSMutableDictionary *params = [NSMutableDictionary new];
    if (rawValue) {
        params[@"data"] = rawValue;
    }
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithService:@"user"
                                                                accessGroup:APP_GROUP];
    NSLog(@"%@", keychain);
    NSMutableDictionary *identicationDic = [NSMutableDictionary new];
    NSString *account = keychain[@"account"];
    if (account) {
        identicationDic[@"username"] = account;
        NSString *password = keychain[account];
        if (password) {
            identicationDic[@"password"] = password;
        }
    }
//    use to test
    identicationDic[@"username"] = @"18616998609";
    identicationDic[@"password"] = @"a123456";
    
    NSString *uuid = keychain[@"uuid"];
    if (uuid == nil) {
        uuid = [UIDevice currentDevice].identifierForVendor.UUIDString;
        keychain[@"uuid"] = uuid;
    }
    identicationDic[@"imei"] = uuid;
    
    NSString *systemVersion = [UIDevice currentDevice].systemVersion;
    NSString *deviceModel = [UIDevice currentDevice].model;
    identicationDic[@"info"] = [NSString stringWithFormat:@"systemVersion:%@;systemModel:%@", systemVersion, deviceModel];
    identicationDic[@"version"] = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    identicationDic[@"build"] = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    identicationDic[@"type"] = @"basic";
    
    params[@"identication"] = identicationDic;
    
    
    return params;
}

@end

@interface DQAPIManger ()

@property (nonatomic, weak, readonly) id <DQAPI> child;
/**
 *  参数转换器，用于将业务参数转换为实际请求参数，详见DQAPIParamsReformer协议
 */
@property (nonatomic, strong) id <DQAPIParamsReformer> paramsReformer;
@property (nonatomic, strong) AFHTTPSessionManager *httpManager;
@property (nonatomic, strong) NSURLSessionDataTask *task;
@property (nonatomic, strong, readwrite) DQAPIResponse *response;
@property (nonatomic, strong, readwrite) NSError *error;


@end

@implementation DQAPIManger

- (void)dealloc {
    if (self.task) {
        [self.task cancel];
    }
}

- (instancetype)init {
    if ([super init]) {
        NSAssert([self conformsToProtocol:@protocol(DQAPI)], @"子类需要遵守API协议");
    }
    return self;
}

- (void)requestWithParams:(NSDictionary *)params landing:(id <DQAPIManagerDelegate>)delegate; {
    [self requestWithParams:params reformer:self.child.paramsReformer landing:delegate];
}

- (void)requestWithParams:(NSDictionary *)params reformer:(id <DQAPIParamsReformer>)reformer landing:(id <DQAPIManagerDelegate>)delegate; {
    
    __weak typeof(self) weakSelf = self;
    self.delegate = delegate;
    NSDictionary *reformeredParams = [reformer paramsWithRawValue:params api:self.child];

    self.task = [self.httpManager POST:self.child.postPath parameters:reformeredParams success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        weakSelf.response = [DQAPIResponse yy_modelWithDictionary:responseObject];
        if (weakSelf.response.code == 1) {
            if ([weakSelf.delegate respondsToSelector:@selector(apiDidLandingSuccess:)]) {
                [weakSelf.delegate apiDidLandingSuccess:weakSelf.child];
            }
        } else {
            if ([weakSelf.delegate respondsToSelector:@selector(apiDidLandingFailure:)]) {
                [weakSelf.delegate apiDidLandingFailure:weakSelf.child];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        weakSelf.error = [error copy];
        if ([weakSelf.delegate respondsToSelector:@selector(apiDidLandingFailure:)]) {
            [weakSelf.delegate apiDidLandingFailure:weakSelf.child];
        }
    }];
}

- (void)cancel {
    if (self.task) {
        [self.task cancel];
    }
}

#pragma mark - Getters And Setters
- (DQAPIManger <DQAPI> *)child {
    return (DQAPIManger <DQAPI> *)self;
}

- (NSString *)baseURL {
    return @"http://www.365qian.com:8300/";
}

- (NSString *)postPath; {
    NSString *r = [NSString stringWithFormat:@"cfdh/data.ashx?function=%@", self.child.methodName];
    return r;
}

- (NSString *)methodName; {
    return @"";
}

- (id <DQAPIParamsReformer>)paramsReformer {
    if (_paramsReformer == nil) {
        _paramsReformer = [APIParamsDefaultReformer new];
    }
    return _paramsReformer;
}

- (AFHTTPSessionManager *)httpManager {
    if (_httpManager == nil) {
        _httpManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:self.child.baseURL]];
        __weak typeof(self) weakSelf = self;
        
        if ([self.child respondsToSelector:@selector(paramsSerializedWithParams:)]) {
            [_httpManager.requestSerializer setQueryStringSerializationWithBlock:^NSString * _Nonnull(NSURLRequest * _Nonnull request, id  _Nonnull parameters, NSError * _Nullable __autoreleasing * _Nullable error) {
                return [weakSelf.child paramsSerializedWithParams:parameters];
            }];
            [_httpManager.requestSerializer setValue:@"text/plain; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        }
        _httpManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
        
    }
    return _httpManager;
}

@end


@implementation DQAPIResponse

- (NSString *)description {
    return [NSString stringWithFormat:@"code:%@\nmessage:%@\ndata:%@", @(self.code), self.message, self.data?:@"nil"];
}

@end



