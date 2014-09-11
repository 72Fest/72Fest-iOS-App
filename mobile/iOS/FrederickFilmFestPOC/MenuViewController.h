//
//  MenuViewController.h
//  FrederickFilmFestPOC
//
//  Created by Carpe Lucem Media Group on 9/8/14.
//
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController

typedef enum {
    MENU_ITEM_PHOTOS,
    MENU_ITEM_TEAMS,
    MENU_ITEM_INFO,
    MENU_ITEM_CONTACT,
    NEMU_ITEM_NEWS
} MainMenuItem;

@property (weak, nonatomic) IBOutlet UIButton *photosBtn;
@property (weak, nonatomic) IBOutlet UIButton *teamsBtn;
@property (weak, nonatomic) IBOutlet UIButton *infoBtn;
@property (weak, nonatomic) IBOutlet UIButton *contactBtn;
@property (weak, nonatomic) IBOutlet UIButton *newsBtn;

@end
