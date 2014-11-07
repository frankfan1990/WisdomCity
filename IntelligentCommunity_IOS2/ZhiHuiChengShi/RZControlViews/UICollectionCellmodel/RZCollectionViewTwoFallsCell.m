//
//  RZCollectionViewTwoFallsCell.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-8-21.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZCollectionViewTwoFallsCell.h"

@implementation RZCollectionViewTwoFallsCell
@synthesize viewContent;
@synthesize imageTopView;
@synthesize viewFooter;
@synthesize leftBackImageView;
@synthesize lbleftTitle;
@synthesize lbContent;
@synthesize imageIconNo1;
@synthesize lbIconNo1Title;
@synthesize lbDate;


//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖镇楼                  BUG辟易
//          佛曰:
//                  写字楼里写字间，写字间里程序员；
//                  程序人员写程序，又拿程序换酒钱。
//                  酒醒只在网上坐，酒醉还来网下眠；
//                  酒醉酒醒日复日，网上网下年复年。
//                  但愿老死电脑间，不愿鞠躬老板前；
//                  奔驰宝马贵者趣，公交自行程序员。
//                  别人笑我忒疯癫，我笑自己命太贱；
//                  不见满街漂亮妹，哪个归得程序员？


//                            _oo0oo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                           0\  =  /0
//                         ___/`___'\___
//                       .' \\|     |// '.
//                      / \\|||  :  |||// \
//                     / _||||| -:- |||||_ \
//                    |   | \\\  _  /// |   |
//                    | \_|  ''\___/''  |_/ |
//                    \  .-\__  '_'  __/-.  /
//                  ___'. .'  /--.--\  '. .'___
//                ."" '<  .___\_<|>_/___. '>' "".
//             | | :  `_ \`.;` \ _ / `;.`/ - ` : | |
//             \ \  `_.   \_ ___\ /___ _/   ._`  / /
//          ====`-.____` .__ \_______/ __. -` ___.`====
//                           `=-----='
//
//  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//           佛祖保佑           永无BUG

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"RZCollectionViewTwoFallsCell" owner:self options:nil];
        
        // 如果路径不存在，return nil
        if (arrayOfViews.count < 1)
        {
            return nil;
        }
        // 如果xib中view不属于UICollectionViewCell类，return nil
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]])
        {
            return nil;
        }
        // 加载nib
        self = [arrayOfViews objectAtIndex:0];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
