//
//  RZNewHouseViewController.m
//  ZhiHuiChengShi
//
//  Created by JM_Pro on 14-12-1.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZNewHouseViewController.h"
#import "RZLaunchTableViewCell.h"
#import "RZRule.h"
@interface RZNewHouseViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *arrOfname;
    NSArray *arr1;
    NSArray *arr2;
    UILabel *labelType;
    UILabel *_label;
    UITextField *field1;
    UITextField *field2;
    NSInteger count;
    BOOL isFirst;
}
@end

@implementation RZNewHouseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    arrOfname = @[@"姓名",@"手机",@"业务类型"];
    arr1 = @[@"卖房",@"买房"];
    arr2 = @[@"出租",@"租房"];
    count = arrOfname.count;
    isFirst = YES;
    [self setTabBar];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Mywidth,Myheight -64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 45*3+20, Mywidth, 20)];
    _label.text = @"信息提交后，业务人员将主动联系您";
    _label.textAlignment = NSTextAlignmentCenter;
    _label.textColor = UIColorFromRGB(0xa9a9a9);
    _label.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_label];
    
}
-(void)setTabBar{
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLeft setFrame:CGRectMake(0, 0, 30, 30)];;
    [btnLeft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnLeft setBackgroundImage:[UIImage imageNamed:@"返回键.png"] forState:UIControlStateNormal];
    [btnLeft setBackgroundImage:[UIImage imageNamed:@"返回键.png"] forState:UIControlStateHighlighted];
    btnLeft.titleLabel.font = [UIFont systemFontOfSize:17];
    [btnLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnLeft addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnLeftitem = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
    
    UIButton* btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn2 setTitle:@"提交" forState:UIControlStateNormal];
    [btn2 setFrame:CGRectMake(0,10, 40, 45)];;
    btn2.titleLabel.font = [UIFont systemFontOfSize:18];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(didAddBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnright1 = [[UIBarButtonItem alloc] initWithCustomView:btn2];
    
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -5;
        self.navigationItem.leftBarButtonItems= @[negativeSpacer, btnLeftitem];
        self.navigationItem.rightBarButtonItems= @[negativeSpacer, btnright1];
        
    }else{
        self.navigationItem.leftBarButtonItem = btnLeftitem;
        self.navigationItem.rightBarButtonItem = btnright1;
    }
    
    CGRect rect = CGRectMake(0, 0, 200, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.textColor =[UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.text = _titleStr;
    [label setFont:[UIFont systemFontOfSize:19]];
    label.textAlignment =NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    self.title = NSLocalizedString(@" ", @"");
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 3 || indexPath.row == 4) {
        UITableViewCell *cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 12, Mywidth-40-20, 25)];
        label1.font = [UIFont systemFontOfSize:15];
        if ([_titleStr isEqualToString:@"我要卖房/买房"]) {
            label1.text = arr1[indexPath.row-3];
        }else{
            label1.text = arr2[indexPath.row-3];
        }
        
        label1.textColor = UIColorFromRGB(0x5695e2);
        label1.textAlignment = NSTextAlignmentRight;
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, cell1.frame.size.height-0.5, Mywidth-20, 0.5)];
        lineView.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
        [cell1 addSubview:lineView];
        [cell1 addSubview:label1];
        cell1.selectionStyle = UITableViewCellSeparatorStyleNone;
        return cell1;
    }
    
    
    static NSString *cellStr = @"cell";
    RZLaunchTableViewCell *cell = (RZLaunchTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil) {
        cell = [[RZLaunchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    cell.label1.text = arrOfname[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CGFloat width = [self caculateTheTextHeight:arrOfname[indexPath.row] andFontSize:16];
    cell.label1.frame = CGRectMake(15, 0, width, 50);
    cell.label2.frame = CGRectMake(20+width, 10, 15, 15);
    cell.label1.text = arrOfname[indexPath.row];
    cell.textField.frame = CGRectMake(100, 0, Mywidth-150, 45);
    if (indexPath.row == 0) {
        field1 = cell.textField;
    }else if (indexPath.row == 1){
        field2 = cell.textField;
    }
    if (indexPath.row == 2) {
        cell.image1.hidden = NO;
        cell.textField.hidden = YES;
        labelType = [[UILabel alloc] initWithFrame:CGRectMake(100, 12,Mywidth-100-40, 25)];
        labelType.font = [UIFont systemFontOfSize:15];
        if ([_titleStr isEqualToString:@"我要卖房/买房"]) {
            labelType.text = @"卖房";
        }else{
            labelType.text = @"出租";
        }
        labelType.textColor = UIColorFromRGB(0x5695e2);
        labelType.textAlignment = NSTextAlignmentRight;
        [cell addSubview:labelType];
    }
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, cell.frame.size.height-0.5, Mywidth-20, 0.5)];
    lineView.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    [cell addSubview:lineView];
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2 || indexPath.row == 4 || indexPath.row == 3) {
        if (indexPath.row == 4 || indexPath.row == 3) {
            if ([_titleStr isEqualToString:@"我要卖房/买房"]) {
                labelType.text = arr1[indexPath.row-3];
            }else{
                labelType.text = arr2[indexPath.row-3];
            }
        }
        
        NSIndexPath *index1 = [NSIndexPath indexPathForRow:3 inSection:0];
        NSIndexPath *index2 = [NSIndexPath indexPathForRow:4 inSection:0];
       
        RZLaunchTableViewCell *cell = (RZLaunchTableViewCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        UIImageView *image = cell.image1;
        if (!isFirst) {
            [UIView animateWithDuration:0.35 animations:^{
                _label.frame = CGRectMake(0, 45*3+20, Mywidth, 20);
                image.transform =  CGAffineTransformMakeRotation(0);
            }];
            count = arrOfname.count;
            [_tableView beginUpdates];
            [_tableView deleteRowsAtIndexPaths:@[index1,index2] withRowAnimation:UITableViewRowAnimationAutomatic];
            [_tableView endUpdates];
            
        }else{
            [UIView animateWithDuration:0.35 animations:^{
                _label.frame = CGRectMake(0, 45*5+20, Mywidth, 20);
                image.transform =  CGAffineTransformMakeRotation(M_PI_2);
            }];
            count = arrOfname.count +2;
            [_tableView beginUpdates];
            [_tableView insertRowsAtIndexPaths:@[index1,index2] withRowAnimation:UITableViewRowAnimationAutomatic];
            [_tableView endUpdates];
           
        }
        isFirst = !isFirst;
    }

}
- (CGFloat)caculateTheTextHeight:(NSString *)string andFontSize:(int)fontSize{
    
    /*非彻底性封装*/
    CGSize constraint = CGSizeMake(CGFLOAT_MAX, 50);
    
    NSDictionary * attributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName];
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:string
     attributes:attributes];
    CGRect rect = [attributedText boundingRectWithSize:constraint
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
    
    
    return size.width;
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)didAddBtn
{
    NSString *message = @"";
    if (![field1.text length]) {
        message = @"\n姓名不能为空";
    }else if (!isValidatePhone(field2.text)){
        message = @"\n请填写正确的电话号码";
    }
    if([message length]){
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alerView show];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
