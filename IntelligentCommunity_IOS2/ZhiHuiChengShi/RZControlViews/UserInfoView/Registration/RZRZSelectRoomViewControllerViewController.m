//
//  RZRZSelectRoomViewControllerViewController.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-8-28.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//
#pragma mark 选择房号

#import "RZRZSelectRoomViewControllerViewController.h"
#import "ChineseInclude.h"
#import "PinYinForObjc.h"
#import "RZGetCityData.h"
#import "IIILocalizedIndex.h"
#import "NSDictionary+MutableDeepCopy.h"
#import "SVProgressHUD.h"

@interface RZRZSelectRoomViewControllerViewController ()
{
    RZGetCityData *getdatatwo;
    NSDictionary *dictdata;
    SVProgressHUD *progress;
    NSString *strId;
    NSMutableDictionary *dicDistrict;
}
@end

@implementation RZRZSelectRoomViewControllerViewController
@synthesize keys;
@synthesize resourceData;
@synthesize localresource;

@synthesize delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}
-(void)back
{
 
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    getdatatwo = [[RZGetCityData alloc] init];
    progress = [[SVProgressHUD alloc] init];
    [SVProgressHUD show];
    dicDistrict = [NSMutableDictionary dictionary];
    strId = [NSString string];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    CGRect rect = CGRectMake(0, 0, 200, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.textColor =[UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.text = _titleName;
    label.adjustsFontSizeToFitWidth=YES;
    label.textAlignment =NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    
 
    
    
    //
    UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLeft setFrame:CGRectMake(0, 0, 30, 30)];
        [btnLeft setBackgroundImage:[UIImage imageNamed:@"返回键.png"] forState:UIControlStateNormal];
    [btnLeft setBackgroundImage:[UIImage imageNamed:@"返回键.png"] forState:UIControlStateHighlighted];
    btnLeft.titleLabel.font = [UIFont systemFontOfSize:14];
    [btnLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnLeft addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnLeftitem = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems= @[negativeSpacer, btnLeftitem];
    }else{
        self.navigationItem.leftBarButtonItem =btnLeftitem;
    }
    
    
    
    [SearchBar setBackgroundImage:[UIImage imageNamed:@"search_bg.png"]];
    
    searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:SearchBar contentsController:self];
    searchDisplayController.active = NO;
    searchDisplayController.delegate = self;
    searchDisplayController.searchResultsDataSource = self;
    searchDisplayController.searchResultsDelegate = self;
    
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=6.0)){
        [TableView setBackgroundColor:[UIColor clearColor]];
        //设置table的右边索引栏的字体颜色
        TableView.sectionIndexColor = [UIColor blackColor];
        //设置table的右边索引兰的背景颜色
        TableView.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
    }
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        TableView.sectionIndexBackgroundColor = [UIColor clearColor];
        [TableView setBackgroundColor:[UIColor clearColor]];
    }
    
    
    
    allCityArray = [[NSMutableArray alloc] init];
    hotCityArray = [[NSMutableArray alloc] init];
    searchResults = [[NSMutableArray alloc]init];
    
    isSearching = NO;
    
    
    
    NSMutableArray *arr=[[NSMutableArray alloc] initWithCapacity:0];
    
    TableView.hidden = YES;
 
    if(_type==3){

        getdatatwo.urlstr = [NSString stringWithFormat:@"%@signUp/getBuildingRoomNumberList",hostIPTwo];
        getdatatwo.paramter = @{@"buildingId":self.selectCity};
        [self get_Data];
//            localCitystr= [[NSString alloc] initWithFormat:@"10001室"];
           
        }
 
    if(_type==2){
        
        getdatatwo.urlstr = [NSString stringWithFormat:@"%@signUp/getVillageList",hostIPTwo];
        if (self.selectCity == nil) {
            return;
        }
        getdatatwo.paramter = @{@"communityId":self.selectCity};
        [self get_Data];
        
//        localCitystr= [[NSString alloc] initWithFormat:@"10001室"];
        
    }
    if(_type==1){
        
        getdatatwo.urlstr = [NSString stringWithFormat:@"%@signUp/getDistrictList",hostIPTwo];
        getdatatwo.paramter = @{@"cityId":self.selectCity};
        [self get_Data];
        //localCitystr= [[NSString alloc] initWithFormat:@"10001室"];
        
    }
    
    [allCityArray addObjectsFromArray:arr];
    [searchResults addObjectsFromArray:[allCityArray mutableCopy]];
    TableView.delegate=self;
    TableView.dataSource=self;
    
    [self resetTableView];
    // Do any additional setup after loading the view from its nib.
}
-(void)get_Data
{
    [getdatatwo getData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleData:) name:@"dictdata" object:getdatatwo];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(error) name:@"error" object:getdatatwo];
    
}
-(void)error
{
    [SVProgressHUD showErrorWithStatus:@"网络异常 请重新加载"];
}
-(void)handleData:(NSNotification *)notification
{
    [SVProgressHUD showSuccessWithStatus:@"加载成功"];
    TableView.hidden = NO;
    dictdata = [NSDictionary dictionaryWithDictionary:notification.userInfo];
    NSMutableArray *arr=[NSMutableArray array];
    if(_type == 1)
    {
        [dicDistrict removeAllObjects];
        NSLog(@"%@",notification.userInfo[@"data"][@"items"]);
        for (NSDictionary *dic in dictdata[@"data"][@"items"]) {
            [arr addObject:dic[@"DistrictName"]];
            [dicDistrict setObject:dic[@"DistrictID"] forKey:dic[@"DistrictName"]];
        }
    }
    if(_type == 2 || _type == 3)
    {
        [dicDistrict removeAllObjects];
        NSLog(@"%@",notification.userInfo[@"data"][@"items"]);
        for (NSDictionary *dic in dictdata[@"data"][@"items"]) {
            [arr addObject:dic[@"name"]];
            [dicDistrict setObject:dic[@"id"] forKey:dic[@"name"]];
        }
    }
    allCityArray = arr;
    [searchResults addObjectsFromArray:[allCityArray mutableCopy]];
    [self resetTableView];
    [TableView reloadData];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*此方法做了三件事 1.得到将字典数据copy成可变字典的数据。2.得到数据的可变类型的键(key)。3.在索引最上方加了一个小的扩大镜(UITableViewIndexSearch)，用于还原图表初始位置。
 */

-(void)resetTableView
{
    self.localresource = nil;
    
    self.resourceData = nil;
    
    
    IIILocalizedIndex *iilocation = [[IIILocalizedIndex alloc] init];
    
    NSArray *arr = [NSArray arrayWithArray:searchResults];
    NSDictionary *dic = [iilocation indexed:arr];
    self.localresource = dic;
    
    
    //得到可变字典(数据)深层复制
    NSMutableDictionary *Mdic=[self.localresource mutableDeepCopy];
    
    self.resourceData = Mdic;
    NSMutableArray *key = [[NSMutableArray alloc] init];
//    if(!isSearching)
//    {
//        [key addObject:@"$"];
//        //        [key addObject:@"&"];
//    }
    
    [key addObjectsFromArray:[[self.resourceData allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    self.keys = key;
    
}


#pragma mark-
#pragma mark NO.5 Search Bar Delegate Method

//结束搜索  重置数据源
- (void) searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller
{
    isSearching = NO;
    
    [searchResults removeAllObjects];
    [searchResults addObjectsFromArray:[allCityArray mutableCopy]];
    
    [self resetTableView];
}


#pragma UISearchDisplayDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    isSearching = YES;
    
    [searchResults removeAllObjects];
    
    if (SearchBar.text.length>0&&![ChineseInclude isIncludeChineseInString:SearchBar.text]) {
        for (int i=0; i<allCityArray.count; i++) {
            
            if ([ChineseInclude isIncludeChineseInString:allCityArray[i]]) {
                NSString *tempPinYinStr = [PinYinForObjc chineseConvertToPinYin:allCityArray[i]];
                NSRange titleResult=[tempPinYinStr rangeOfString:SearchBar.text options:NSCaseInsensitiveSearch];
                if (titleResult.length>0) {
                    // [searchResults addObject:allCityArray[i]];
                    [self addObjectAlike:searchResults str:allCityArray[i]];
                    
                }
                
                NSString *tempPinYinHeadStr = [PinYinForObjc chineseConvertToPinYinHead:allCityArray[i]];
                NSRange titleHeadResult=[tempPinYinHeadStr rangeOfString:SearchBar.text options:NSCaseInsensitiveSearch];
                if (titleHeadResult.length>0) {
                    // [searchResults addObject:allCityArray[i]];
                    [self addObjectAlike:searchResults str:allCityArray[i]];
                }
            }else {
                NSRange titleResult=[allCityArray[i] rangeOfString:SearchBar.text options:NSCaseInsensitiveSearch];
                if (titleResult.length>0) {
                    //[searchResults addObject:allCityArray[i]];
                    [self addObjectAlike:searchResults str:allCityArray[i]];
                }
            }
        }
        
    } else if (SearchBar.text.length>0&&[ChineseInclude isIncludeChineseInString:SearchBar.text]) {
        for (NSString *tempStr in allCityArray) {
            NSRange titleResult=[tempStr rangeOfString:SearchBar.text options:NSCaseInsensitiveSearch];
            if (titleResult.length>0) {
                // [searchResults addObject:tempStr];
                [self addObjectAlike:searchResults str:tempStr];
            }
        }
    }
    
    NSLog(@"开始搜索啦");
    [self resetTableView];
    
}

//相同的对象则不添加进去
-(void)addObjectAlike:(NSMutableArray *)arr str:(NSString *)str
{
    if(![arr containsObject:str])
    {
        [arr addObject:str];
    }
}



#pragma UITableViewDataSource

//返回（向系统发送）分区个数,在这里有多少键就会有多少分区。
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.keys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //获取当前分区所对应的键(key)。在这里键就是分区的标示。
    NSString *key = [self.keys objectAtIndex:section];
    //获取键所对应的值（数组）。
    NSArray *arr = [self.resourceData objectForKey:key];
    //返回所在分区所占多少行。
    
//    if(!isSearching)
//    {
//        if([key isEqualToString:@"$"])  //定位城市
//        {
//            return 1;
//        }
//        //        else if([key isEqualToString:@"&"]) //热门城市
//        //        {
//        //            return [hotCityArray count];
//        //        }
//    }
    return arr.count;
    
}

//设置表格的索引数组
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    if(isSearching)
    {
        return nil;
    }
    return self.keys;
}


//点击索引会调用此方法。点击扩大镜UITableViewIndexSearch让searchbar出现(因为扩大镜在执行resettableview方法时把其下标设为0，加入key的，所以执行if语句会进入)。
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    NSString *key=[self.keys objectAtIndex:index];
    if (key==UITableViewIndexSearch) {
        [TableView setContentOffset:CGPointZero animated:NO];
        return NSNotFound;
    }
    return index;
}

//tableview 的头部
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc] init];
    [headView setFrame:CGRectMake(0, 0, tableView.frame.size.width, 25)];
    [headView setBackgroundColor:[UtilCheck getRZColor:237 green:237 blue:237 alpha:1]];
    
    UILabel *lbchar = [[UILabel alloc] init];
    [lbchar setFrame:CGRectMake(15, 0, 100, headView.frame.size.height)];
    [lbchar setFont:[UIFont systemFontOfSize:12]];
    [lbchar setTextColor:[UtilCheck getRZColor:72 green:72 blue:72 alpha:1]];
    [lbchar setBackgroundColor:[UIColor clearColor]];
    lbchar.text = [self.keys objectAtIndex:section];
    
//    if([[self.keys objectAtIndex:section] isEqualToString:@"$"])
//    {
//        lbchar.text = @"自动定位";
//    }
    //    else if([[self.keys objectAtIndex:section] isEqualToString:@"&"])
    //    {
    //        lbchar.text = @"热门城市";
    //    }
    
    [headView addSubview:lbchar];
    
    return headView;
}

-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return  26;
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cityChooseCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    int section = indexPath.section;
    
    NSString *key = [self.keys objectAtIndex:section];
    NSArray *arr = [self.resourceData objectForKey:key];
  
    
    cell.textLabel.text = [arr objectAtIndex:indexPath.row];
    
//    if([key isEqualToString:@"$"])  //定位城市
//    {
//        //cell.textLabel.text = @"长沙";
//        NSLog(@"定位城市：%@",localCitystr);
//        if([localCitystr isEqualToString:@""])
//        {
//            UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] init];
//            activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
//            [activity setFrame:CGRectMake(25, 10, 20, 20)];
//            //停止后是否隐藏(默认为YES)
//            activity.hidesWhenStopped = YES;
//            [activity startAnimating];
//            [cell.contentView addSubview:activity];
//            
//        }else
//        {
//            cell.textLabel.text = localCitystr;
//        }
//        
//    }
    //    else if([key isEqualToString:@"&"]) //热门城市
    //    {
    //        cell.textLabel.text = [hotCityArray objectAtIndex:indexPath.row];
    //    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    strId = [dicDistrict objectForKey:cell.textLabel.text];
    if([delegate respondsToSelector:@selector(selectDataForRoom:Type:Id:)])
    {
        [delegate selectDataForRoom:[NSString stringWithFormat:@"%@%@",_selectName,cell.textLabel.text] Type:_type Id:strId];
    }
//         [self.navigationController dismissViewControllerAnimated:NO completion:nil];
    
}



/*
 另加一个
 使用presentModalViewControllerAnimated方法从A->B->C，若想在C中直接返回A，则可这样实现：
 
 C中返回事件：
 
 void back
 {
 [self dismissModalViewControllerAnimated:NO];//注意一定是NO！！
 [[NSNotificationCenter  defaultCenter]postNotificationName:@"backback" object:nil];
 }
 然后在B中，
 
 //在viewdidload中：
 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(back) name:@"backback" object:nil];
 
 -(void)back
 {
 [self dismissModalViewControllerAnimated:YES];
 }
 */
@end
