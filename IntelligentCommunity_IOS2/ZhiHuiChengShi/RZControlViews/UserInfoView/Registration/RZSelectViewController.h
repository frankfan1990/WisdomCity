//
//  RZSelectViewController.h
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-8-26.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RZRZSelectRoomViewControllerViewController.h"

@protocol FaxianCityDelegate

-(void)selectData:(NSString *)DataString Type:(NSInteger)type Id:(NSString *)ID;

@end

@interface RZSelectViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate,RZRZSelectRoomDelegate>
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
@property(nonatomic,strong)NSString *titleId;
@property(nonatomic,strong)NSString *titletwo;
@property(nonatomic,strong)NSString *locationCity;
@property(nonatomic)NSInteger type;
-(void)resetTableView;

@property(nonatomic,assign)id delegate;

@end
