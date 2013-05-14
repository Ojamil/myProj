//
//  MainTabBarViewController.h
//  myProj
//
//  Created by sky on 13-5-9.
//
//

#import <UIKit/UIKit.h>


@class MainTabBarViewController;

@protocol MainTabBarViewControllerDelegate <NSObject>

@end

@interface MainTabBarViewController : UIViewController

@property (nonatomic, strong) id <MainTabBarViewControllerDelegate> delegate;

@end