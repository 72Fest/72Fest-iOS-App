//
//  VotingOperation.h
//  FrederickFilmFestPOC
//
//  Created by Carpe Lucem Media Group on 9/14/13.
//
//

#import <Foundation/Foundation.h>
#import "VotingOperationDelegate.h"
@interface VotingOperation : NSOperation
- (id)initWithImageKey:(NSString *)imageKey andDelgate:(id <VotingOperationDelegate>)delegate;

@property (nonatomic, weak) id  <VotingOperationDelegate> delegate;
@property (nonatomic, assign) NSInteger voteTotal;
@end
