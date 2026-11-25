//
//  CommandCatalog.h
//  anycast
//
//  Created by Corentin on 25/11/2026.
//

#import <Foundation/Foundation.h>
#import "ResultEntry.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommandCatalog : NSObject
- (NSArray<ResultEntry *> *)systemCommands;
@end

NS_ASSUME_NONNULL_END
