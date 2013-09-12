//
//  VoteManager.h
//  FrederickFilmFestPOC
//
//  Created by Carpe Lucem Media Group on 9/9/13.
//
//

#import <Foundation/Foundation.h>

#define VOTE_MANGER_IMG_KEY @"voteMangerImageKey"

@interface VoteManager : NSObject

+ (VoteManager *)defaultManager;

- (BOOL)toggleVoteForImgKey:(NSString *)imgKey;
- (BOOL)hasVoteForImgKey:(NSString *)imgKey;

@end
