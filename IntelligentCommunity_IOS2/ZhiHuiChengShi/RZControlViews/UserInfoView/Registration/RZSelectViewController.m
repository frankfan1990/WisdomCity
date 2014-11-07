//
//  RZSelectViewController.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-8-26.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZSelectViewController.h"
#import "ChineseInclude.h"
#import "PinYinForObjc.h"
#import "IIILocalizedIndex.h"
#import "NSDictionary+MutableDeepCopy.h"
#import "RZGetCityData.h"
#import "SVProgressHUD.h"

@interface RZSelectViewController ()
{
    RZGetCityData *getdata;
    NSDictionary *dictdata;
    NSMutableDictionary *dicCity;
    SVProgressHUD *progress;
    
}
@end

@implementation RZSelectViewController
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
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    CGRect rect = CGRectMake(0, 0, 200, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.textColor =[UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.text = _titleName;
    label.adjustsFontSizeToFitWidth=YES;
    label.textAlignment =NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
}
-(void)back
{
//    [self dismissModalViewControllerAnimated:YES];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (_type != 4) {
        progress = [[SVProgressHUD alloc] init];
        [SVProgressHUD setStatus:@"正在加载"];
        [SVProgressHUD show];
    }

    getdata = [[RZGetCityData alloc] init];
    dicCity = [NSMutableDictionary dictionary];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }

    
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
    if(_type==1){
        
        getdata.urlstr = [NSString stringWithFormat:@"%@signUp/getCityList",hostIPTwo];
       
        getdata.paramter = nil;
        if ([self.locationCity length]) {
            localCitystr =  self.locationCity;
        }
        else
        {
           localCitystr= [[NSString alloc] initWithFormat:@"定位失败"];
        }
        
        [self get_Data];
    }
    else if(_type==2){
        getdata.urlstr = [NSString stringWithFormat:@"%@signUp/getCommunityList",hostIPTwo];
        getdata.paramter = @{@"districtId":_titleId};
         [self get_Data];
    }
    else if(_type==3){
        getdata.urlstr = [NSString stringWithFormat:@"%@signUp/getBuildingList",hostIPTwo];
        getdata.paramter = @{@"districtId":_titletwo};
          [self get_Data];
    }
    else if(_type==4){
      
        TableView.hidden = NO;
        localCitystr= [[NSString alloc] initWithFormat:@"男主人"];
        arr=[NSMutableArray arrayWithObjects:@"爷爷辈",@"奶奶辈",@"父亲辈",@"母亲辈",@"男主人",@"女主人",@"子侄辈", nil];
    }
    
    allCityArray = arr;
//    [allCityArray addObjectsFromArray:arr];
    [searchResults addObjectsFromArray:[allCityArray mutableCopy]];
    TableView.delegate=self;
    TableView.dataSource=self;
   
    [self resetTableView];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)get_Data
{
    [getdata getData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleData:) name:@"dictdata" object:getdata];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(error) name:@"error" object:getdata];
    
}
-(void)error
{
    [SVProgressHUD showErrorWithStatus:@"网络异常 请重新加载"];
}
-(void)handleData:(NSNotification *)notification
{
    TableView.hidden = NO;
    [SVProgressHUD showSuccessWithStatus:@"加载成功"];
    dictdata = [NSDictionary dictionaryWithDictionary:notification.userInfo];
    NSMutableArray *arr=[NSMutableArray array];
    if(_type == 1)
    {
        NSLog(@"%@",notification.userInfo[@"data"][@"items"]);
        for (NSDictionary *dic in dictdata[@"data"][@"items"]) {
            
            [arr addObject:dic[@"CityName"]];
            [dicCity setObject:dic[@"CityID"] forKey:dic[@"CityName"]];
        }
    }
    if(_type == 2)
    {
        NSLog(@"%@",notification.userInfo[@"data"][@"items"]);
        for (NSDictionary *dic in dictdata[@"data"][@"items"]) {
            
            [arr addObject:dic[@"name"]];
            [dicCity setObject:dic[@"id"] forKey:dic[@"name"]];
        }
    }
    if(_type == 3)
    {
        NSLog(@"%@",notification.userInfo[@"data"][@"items"]);
        for (NSDictionary *dic in dictdata[@"data"][@"items"]) {
            
            [arr addObject:dic[@"name"]];
            [dicCity setObject:dic[@"id"] forKey:dic[@"name"]];
        }
    }
    
    
     allCityArray = arr;
    [searchResults addObjectsFromArray:[allCityArray mutableCopy]];
    [self resetTableView];
    [TableView reloadData];
    
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
    if(!isSearching)
    {
        [key addObject:@"$"];
//        [key addObject:@"&"];
    }
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
    
    if ( _type == 1) {
        if(!isSearching)
        {
            if([key isEqualToString:@"$"])  //定位城市
            {
                return 1;
            }
            //        else if([key isEqualToString:@"&"]) //热门城市
            //        {
            //            return [hotCityArray count];
            //        }
        }
    }

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
//    if (section == 0 && _type != 1) {
////        UIView *headView = [[UIView alloc] init];
////        [headView setFrame:CGRectMake(0, 0, 0,0)];
//        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
//        return headerView;
//    }
        UIView *headView = [[UIView alloc] init];
        [headView setFrame:CGRectMake(0, 0, tableView.frame.size.width, 25)];
        [headView setBackgroundColor:[UtilCheck getRZColor:237 green:237 blue:237 alpha:1]];
        
        UILabel *lbchar = [[UILabel alloc] init];
        [lbchar setFrame:CGRectMake(15, 0, 100, headView.frame.size.height)];
        [lbchar setFont:[UIFont systemFontOfSize:12]];
        [lbchar setTextColor:[UtilCheck getRZColor:72 green:72 blue:72 alpha:1]];
        [lbchar setBackgroundColor:[UIColor clearColor]];
        lbchar.text = [self.keys objectAtIndex:section];
    
    
    if (_type == 1) {
        if([[self.keys objectAtIndex:section] isEqualToString:@"$"])
        {
            lbchar.text = @"自动定位";
        }
        //    else if([[self.keys objectAtIndex:section] isEqualToString:@"&"])
        //    {
        //        lbchar.text = @"热门城市";
        //    }
    }

         [headView addSubview:lbchar];
         return headView;
   
}

-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_type != 1 && section == 0) {
        return 0;
    }
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
    UITableViewCell *cell2 = [[UITableViewCell alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    int section = indexPath.section;
 
    NSString *key = [self.keys objectAtIndex:section];
    NSArray *arr = [self.resourceData objectForKey:key];

    if (_type == 1 && !isSearching) {
        if(indexPath.section == 0)  //定位城市
        {
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-120, 5, 100, 34)];
            label.backgroundColor = [UIColor colorWithRed:0 green:213/255.0 blue:121/255.0 alpha:1];
            label.tag = 99;
            label.text = @"     当前定位";
            label.layer.cornerRadius = 5;
            label.layer.masksToBounds = YES;
            [label setTextColor:[UIColor whiteColor]];
            [cell2 addSubview:label];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 5, 20, 25)];
            [imageView setImage:[UIImage imageNamed:@"地标.png"]];
            [label addSubview:imageView];
            
            
            if([localCitystr isEqualToString:@""])
            {
                UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] init];
                activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
                [activity setFrame:CGRectMake(25, 10, 20, 20)];
                
                //停止后是否隐藏(默认为YES)
                activity.hidesWhenStopped = YES;
                [activity startAnimating];
                [cell2.contentView addSubview:activity];
                
            }else
            {
                cell2.textLabel.text = localCitystr;
            }
           return cell2;
        }
   
        
        //    else if([key isEqualToString:@"&"]) //热门城市
        //    {
        //        cell.textLabel.text = [hotCityArray objectAtIndex:indexPath.row];
        //    }
    }
    cell.textLabel.text = [arr objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    return cell;
  
//    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:cell.textLabel.text forKey:CityShare];
//    [defaults synchronize];
    
    if ([cell.textLabel.text isEqualToString:@"定位失败"]) {
        return ;
    }
    
    if(_type == 4){
    if([delegate respondsToSelector:@selector(selectData:Type:Id:)])
    {
        [delegate selectData:cell.textLabel.text Type:_type Id:@""];
    }
    [self back];
    }
    else{
        RZRZSelectRoomViewControllerViewController *view=[[RZRZSelectRoomViewControllerViewController alloc] initWithNibName:@"RZRZSelectRoomViewControllerViewController" bundle:nil];
        if (_type == 3) {
            view.type=3;
            view.titleName=@"选择房号";
        }
        if (_type == 2) {
            view.type=2;
            view.titleName=@"选择小区";
        }
        if (_type == 1) {
            view.type=1;
            view.titleName=@"选择地区";
            
        }

        view.delegate = self;
        view.selectName=cell.textLabel.text;
        view.selectCity = [dicCity objectForKey:cell.textLabel.text];
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:view];
//        //    [nav.navigationBar setBackgroundImage:[[UIImage imageNamed:@"navBackimage"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)] forBarMetrics:UIBarMetricsDefault];
        if(IOS7){
        nav.navigationBar.barTintColor=[UtilCheck getRZColor:45 green:132 blue:220 alpha:1];
        }
        else{
            nav.navigationBar.tintColor=[UtilCheck getRZColor:45 green:132 blue:220 alpha:1];
        }
        [self presentViewController:nav animated:YES completion:nil];
        
    }
    
}
-(void)selectDataForRoom:(NSString *)DataString Type:(NSInteger)type Id:(NSString *)ID{
    
//     if(type!=4){
         if([delegate respondsToSelector:@selector(selectData:Type:Id:)])
         {
             [delegate selectData:DataString Type:_type Id:ID];
         }
         [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//    }
 
}

@end
