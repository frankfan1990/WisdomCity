//
//  RZRZSelectRoomViewControllerViewController.h
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-8-28.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RZRZSelectRoomDelegate

-(void)selectDataForRoom:(NSString *)DataString Type:(NSInteger)type Id:(NSString *)ID;

@end

@interface RZRZSelectRoomViewControllerViewController : UIViewController
<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate>
{
    
    IBOutlet UITableView *TableView;
    IBOutlet UISearchBar *SearchBar;
    
    UISearchDisplayController *searchDisplayController;
    BOOL isSearching;  //是否正在搜索
    
    
    NSMutableArray *allCityArray;
    NSMutableArray *hotCityArray;
    NSMutableArray *searchResults;
    NSString *localCitystr;
    
}
@property (nonatomic, retain) NSDictionary *localresource;
@property (nonatomic, retain) NSMutableArray *keys;  //所有的session string
@property (nonatomic, retain) NSMutableDictionary *resourceData;
@property(nonatomic,retain)NSString *titleName;
@property(nonatomic,retain)NSString *selectName;
@property(nonatomic,retain)NSString *selectCity;
@property(nonatomic)NSInteger type;
-(void)resetTableView;

@property(nonatomic,assign)id delegate;

@end
