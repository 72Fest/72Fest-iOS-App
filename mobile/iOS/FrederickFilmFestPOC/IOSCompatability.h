//
//  IOSCompatability.h
//  FrederickFilmFestPOC
//
//  Created by Carpe Lucem Media Group on 9/16/13.
//
//

#ifndef FrederickFilmFestPOC_IOSCompatability_h
#define FrederickFilmFestPOC_IOSCompatability_h

/*
 *  System Versioning Preprocessor Macros
 */
//NOTE: code used from https://gist.github.com/alex-cellcity/998472

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
#define SYSTEM_IS_IOS7 SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7")
#endif
