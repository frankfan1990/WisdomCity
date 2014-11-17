//
//  RZUserInfoData.h
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-11-5.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"
@interface RZUserInfoData : MTLModel<MTLJSONSerializing>
@property(nonatomic,strong) NSString * address;
@property(nonatomic,strong) NSString * createDate;
@property(nonatomic,strong) NSString * emaill;
@property(nonatomic,strong) NSString * familyRole;
@property(nonatomic,strong) NSString * haveLicence;
@property(nonatomic,strong) NSString * headUrl;

@property(nonatomic,assign) NSString * id;


@property(nonatomic,strong) NSString * integral;
@property(nonatomic,strong) NSString * isFamily;
@property(nonatomic,strong) NSString * isReceivePush;
@property(nonatomic,strong) NSString * isRent;
@property(nonatomic,strong) NSString * lock;
@property(nonatomic,strong) NSString * lockTime;
@property(nonatomic,strong) NSString * nickname;
@property(nonatomic,strong) NSString * password;
@property(nonatomic,strong) NSString * roomid;
@property(nonatomic,strong) NSString * sex;
@property(nonatomic,strong) NSString * telephone;
@property(nonatomic,strong) NSString * signature;
@property(nonatomic,strong) NSString * username;
@property(nonatomic,strong) NSString * token;
+(NSDictionary *)JSONKeyPathsByPropertyKey;
@end
