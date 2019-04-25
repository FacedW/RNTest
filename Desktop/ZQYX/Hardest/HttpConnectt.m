//
//  HttpConnect.m
//  JsPaySDK
//
//  Created by 杰莘宏业 on 16/12/21.
//  Copyright © 2016年 杰莘宏业. All rights reserved.
//

#import "HttpConnectt.h"
#import <UIKit/UIKit.h>

@implementation HttpConnectt


+ (NSData*)dictionaryToJson:(NSDictionary *)dic
{
    NSMutableString *limStr = [NSMutableString string];
    [dic enumerateKeysAndObjectsUsingBlock:^(NSString * key, NSString * obj, BOOL * _Nonnull stop) {
        [limStr appendString:key];
        [limStr appendString:@"="];
        [limStr appendString:obj];
        [limStr appendString:@"&"];
    }];
    NSString *czStr = nil;
    if ([limStr hasSuffix:@"&"]) {
        czStr = [limStr substringToIndex:limStr.length-1];
    }else{
        czStr = [limStr copy];
    }
    return [czStr dataUsingEncoding:NSUTF8StringEncoding];
    
    
//    NSError *parseError = nil;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:&parseError];
//    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


+(void)HttpWithURL:(NSString *)URLStr paramDic:(NSDictionary *)paramDic completion:(void (^)(NSDictionary * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error))completionHandler{
    NSMutableDictionary *dic = @{}.mutableCopy;
    [dic addEntriesFromDictionary:paramDic];

    //字典转字符串会进行一次utf-8编码
    NSData *jsondata = [self dictionaryToJson:dic];
    //先des,在base64
//    NSString *str = [self encrypt:json encryptOrDecrypt:kCCEncrypt key:DESKey];
    //然后组装params
//    NSDictionary *param = @{@"params":str};
//    NSURL * url = [[NSURL alloc] initWithString:URLStr];
    NSURL * url = [[NSURL alloc] initWithString:[URLStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"#%^{}\"[]|\\<> "].invertedSet]];
    
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    request.allHTTPHeaderFields = @{
                                    @"Content-Type":@"application/x-www-form-urlencoded"
                                    };
    [request setHTTPBody:jsondata];
    
    if ([[UIDevice currentDevice].systemVersion floatValue]>8.0) {
        NSURLSession * session = [NSURLSession sharedSession];
        NSURLSessionTask * task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSDictionary *jsonDic = [self transformDicWithJson:data];
#if DEBUG
            NSLog(@"request:%@ \n jsonDic:%@ \n error:%@",request,jsonDic,error);
#else
            
#endif
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(jsonDic,response,error);
            });
            
        }];
        [task resume];
    }else{
        [[[NSURLSession alloc]init] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
#if DEBUG
            NSLog(@"request:%@ \n responsedata:%@ \n error:%@",request,response,error);
#else
            
#endif
            NSDictionary *jsonDic = [self transformDicWithJson:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(jsonDic,response,error);
            });
            
        }];
        
//        NSOperationQueue * queue = [[NSOperationQueue alloc] init];
//        [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//            NSDictionary *jsonDic = [self transformDicWithJson:data];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                completionHandler(jsonDic,response,connectionError);
//            });
//
//        }];
    }
}



+ (NSDictionary *)transformDicWithJson:(NSData *)jsonData {
    NSError *error;
    if (jsonData == nil) return nil;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    if (error == nil) {
        return dic;
    }
    else {
        return nil;
    }
}



@end
