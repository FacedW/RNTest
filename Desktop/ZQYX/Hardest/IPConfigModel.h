//
//  IPConfigModel.h
//  GPPZW_325
//
//  Created by ycz on 2019/4/12.
//  Copyright © 2019年 ycz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IPConfigModel : NSObject

@property (nonatomic,copy) NSString *projectStatus;//项目状态 1A 2B 3 WAP
@property (nonatomic,copy) NSString *webUrl;
@property (nonatomic,copy) NSString *webKitType;

+ (id)modelWithJSON:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
