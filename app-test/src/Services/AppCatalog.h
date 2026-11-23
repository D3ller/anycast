//
//  AppCatalog.h
//  anycast
//
//  Created by d3ller on 23/11/2026.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class AppEntry;
@interface AppCatalog : NSObject

- (NSMutableArray<AppEntry *>*)scanApplications;

@end

NS_ASSUME_NONNULL_END
