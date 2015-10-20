//
//  APIManager.m
//  XyralityTest
//
//  Created by ezkeemo on 10/20/15.
//  Copyright © 2015 ezkeemo. All rights reserved.
//

#import "APIManager.h"
#import "AFNetworking.h"

static NSString * const kWorldsListRequestURL = @"http://backend1.lordsandknights.com/XYRALITY/WebObjects/BKLoginServer.woa/wa/worlds";

@implementation APIManager

+ (instancetype)sharedManager {
    static APIManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[APIManager alloc] init];
    });
    return manager;
}

- (void)getWorldsListWithCredentialsLogin:(NSString *)login password:(NSString *)password onSuccess:(void (^)(id responseObject))successBlock onFailure:(void (^)(NSError *error))failureBlock {
    AFHTTPRequestOperationManager *requestManager = [AFHTTPRequestOperationManager manager];
    requestManager.responseSerializer = [AFPropertyListResponseSerializer serializer];
    NSString *deviceType = [NSString stringWithFormat:@"%@ - %@ %@", [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemName], [[UIDevice currentDevice] systemVersion]];
    NSString *deviceID = [[NSUUID UUID] UUIDString];
    //temporary for testing purposes
    login = @"ios.test@xyrality.com";
    password = @"password";
    NSDictionary *parametersDict = @{@"login":login,
                                 @"password":password,
                                 @"deviceType":deviceType,
                                 @"deviceId":deviceID};
    [requestManager POST:kWorldsListRequestURL parameters:parametersDict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        if (failureBlock) {
            NSLog(@"request error occured. Error code is %d : %@", error.code, [error localizedDescription]);
            failureBlock(error);
        }
    }];
}
@end
