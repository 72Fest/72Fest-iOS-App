//
//  VotingOperationDelegate.h
//  FrederickFilmFestPOC
//
//  Created by Carpe Lucem Media Group on 9/14/13.
//
//

#import <Foundation/Foundation.h>
@class VotingOperation;

@protocol VotingOperationDelegate <NSObject>
@required

- (void)votingOperationDidReceiveVoteTotal:(VotingOperation *)votingOperation;

@end
