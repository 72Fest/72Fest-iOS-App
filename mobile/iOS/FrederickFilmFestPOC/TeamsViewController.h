//
//  TeamsViewController.h
//  FrederickFilmFestPOC
//
//  Created by Carpe Lucem Media Group on 9/10/14.
//
//

#import <UIKit/UIKit.h>

@interface TeamsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *teamsTableView;
@end
