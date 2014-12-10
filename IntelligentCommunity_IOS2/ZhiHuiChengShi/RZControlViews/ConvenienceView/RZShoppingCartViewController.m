//
//  RZShoppingCartViewController.m
//  ZhiHuiChengShi
//
//  Created by JM_Pro on 14-12-9.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZShoppingCartViewController.h"
#import "RZShoppingCatTableViewCell.h"
@interface RZShoppingCartViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITableView *_tableView;
    NSMutableArray *arrOfFoodImage;
    NSMutableArray *arrOfFoodName;
    NSMutableArray *arrOfFoodPrice;
    NSMutableArray *arrOfStoreName;
    UITextField *field;
}
@end

@implementation RZShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTabar];
    [self Variableinitialization];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap)];
    [self.view addGestureRecognizer:tap];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, Myheight-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.view addSubview:_tableView];
}
-(void)Variableinitialization
{
    arrOfFoodImage = [NSMutableArray arrayWithObjects:@"http://pic17.nipic.com/20111102/7015943_083452063000_2.jpg",@"http://pic24.nipic.com/20121015/9095554_134755084000_2.jpg",@"http://pic1a.nipic.com/2008-10-27/2008102793623630_2.jpg",nil];
    arrOfFoodName  = [NSMutableArray arrayWithObjects:@"红烧猪脚",@"酸辣鸡杂",@"拔丝香蕉",nil];
    arrOfFoodPrice = [NSMutableArray arrayWithObjects:@"36.00",@"28.00",@"12.00", nil];
    arrOfStoreName = [NSMutableArray arrayWithObjects:@"天天煲仔饭",@"姊妹煲仔饭",@"兄弟煲仔饭", nil];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrOfFoodName.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Myheight, 60)];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 0.5)];
    lineView.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    [footView addSubview:lineView];
    
    UIButton *footbtn = [UIButton buttonWithType:UIButtonTypeSystem];
    footbtn.frame = CGRectMake(15, 20, Mywidth-30, 45);
    footbtn.titleLabel.font = [UIFont systemFontOfSize:15];
    footbtn.backgroundColor = UIColorFromRGB(0x5496DF);
    footbtn.layer.cornerRadius = 6;
    footbtn.layer.masksToBounds = YES;
    footView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [footbtn setTitle:@"结算" forState:UIControlStateNormal];
    [footbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [footView addSubview:footbtn];
    
    return footView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 70;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellStr = @"cell";
    RZShoppingCatTableViewCell *cell = (RZShoppingCatTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil) {
        cell = [[RZShoppingCatTableViewCell alloc] init];
    }
    cell.selectionStyle = UITableViewCellStyleDefault;
    [cell.imageV setImageWithURL:arrOfFoodImage[indexPath.row] placeholderImage:[UIImage imageNamed:@""]];
    cell.labelOfprice.text = [NSString stringWithFormat:@"￥%@",arrOfFoodPrice[indexPath.row]];
    cell.labelOfFoodName.text = arrOfFoodName[indexPath.row];
    cell.labelOfStoreName.text = arrOfStoreName[indexPath.row];
    cell.numberField.text = @"1";
    cell.numberField.keyboardType = UIKeyboardTypeNumberPad;
    cell.numberField.textAlignment = NSTextAlignmentCenter;
    cell.numberField.delegate = self;
    cell.numberField.tag = 100+indexPath.row;
    cell.btnOfAdd.tag = 10000+indexPath.row;
    cell.btnOfSubStract.tag = 55555+indexPath.row;
    [cell.btnOfSubStract addTarget:self action:@selector(didSubstractBtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnOfAdd addTarget:self action:@selector(didAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    if (indexPath.row == arrOfFoodName.count-1) {
        cell.imageV0.hidden = YES;
    }
    return cell;
    
}
-(void)setTabar
{
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    
    [self.view setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
    UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLeft setFrame:CGRectMake(0, 0, 30, 30)];;
    [btnLeft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnLeft setBackgroundImage:[UIImage imageNamed:@"返回键.png"] forState:UIControlStateNormal];
    [btnLeft setBackgroundImage:[UIImage imageNamed:@"返回键.png"] forState:UIControlStateHighlighted];
    btnLeft.titleLabel.font = [UIFont systemFontOfSize:17];
    [btnLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnLeft addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnLeftitem = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
    
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems= @[negativeSpacer, btnLeftitem];
        
    }else{
        self.navigationItem.leftBarButtonItem = btnLeftitem;
    }
    
    CGRect rect = CGRectMake(0, 0, 200, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.textColor =[UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"购物车";
    [label setFont:[UIFont systemFontOfSize:19]];
    label.textAlignment =NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    self.title = NSLocalizedString(@" ", @"");
    
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)didSubstractBtn:(UIButton *)sender
{
    [field resignFirstResponder];
    field = (UITextField *)[[sender superview] viewWithTag:sender.tag-55555+100];
    int number = [field.text intValue];
    if (number == 1) {
        return;
    }
    number--;
    field.text = [NSString stringWithFormat:@"%d",number];
    
}
-(void)didAddBtn:(UIButton *)sender
{
    [field resignFirstResponder];
    field = (UITextField *)[[sender superview] viewWithTag:sender.tag-10000+100];
    int number = [field.text intValue];
    number++;
    field.text = [NSString stringWithFormat:@"%d",number];
}
-(void)didTap{
    [field resignFirstResponder];
}
#pragma mark - textField代理
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    field = textField;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField.text intValue] == 0) {
        textField.text = @"1";
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
