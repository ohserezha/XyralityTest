//
//  APIManager.h
//  XyralityTest
//
//  Created by ezkeemo on 10/20/15.
//  Copyright © 2015 ezkeemo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIManager : NSObject

+ (instancetype)sharedManager;
- (void)getWorldsListWithCredentialsLogin:(NSString *)login
                                 password:(NSString *)password
                                onSuccess:(void (^)(id responseObject))successBlock
                                onFailure:(void(^)(NSError *error))failureBlock;

@end
