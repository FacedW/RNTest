//
//  IPConfigModel.m
//  GPPZW_325
//
//  Created by ycz on 2019/4/12.
//  Copyright © 2019年 ycz. All rights reserved.
//

#import "IPConfigModel.h"

@implementation IPConfigModel
+ (id)modelWithJSON:(NSDictionary *)dic{
    IPConfigModel *model = [[IPConfigModel alloc] init];
    model.projectStatus = [dic objectForKey:@"projectStatus"];
    model.webUrl = [dic objectForKey:@"webUrl"];
    model.webKitType = [dic objectForKey:@"webKitType"];
    return model;
}
@end
